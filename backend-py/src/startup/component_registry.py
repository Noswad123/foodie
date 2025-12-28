
import importlib
from dataclasses import dataclass
from typing import Any, Literal, Optional, Union

from inflection import camelize, underscore


@dataclass
class RegistryEntry:
    name: str
    plural: Optional[str] = None
    description: str = ""
    router_class: Optional[type[Any]] = None
    service_class: Optional[type[Any]] = None
    service_module_path: Optional[str] = None
    service_class_name: Optional[str] = None


class ComponentRegistry:
    _registry: dict[str, RegistryEntry] = {}

    @classmethod
    def _ensure_entry(cls, key: str, *, name: Optional[str] = None) -> RegistryEntry:
        return cls._registry.setdefault(
            key,
            RegistryEntry(name=name or key.capitalize())
        )

    @classmethod
    def _register(
        cls,
        *,
        key: str,
        target_kind: Literal["service", "router"],
        target_cls: type[Any],
        name: Optional[str] = None,
        plural: Optional[str] = None,
        description: Optional[str] = None,
        service_module_path: Optional[str] = None,
        service_class_name: Optional[str] = None,
        service_class: Optional[type[Any]] = None,
    ) -> type[Any]:
        entry = cls._ensure_entry(key, name=name)

        if target_kind == "service":
            entry.service_class = target_cls
            if service_module_path is not None:
                entry.service_module_path = service_module_path
            if service_class_name is not None:
                entry.service_class_name = service_class_name
        else:
            entry.router_class = target_cls
            if plural is not None:
                entry.plural = plural or f"{key}s"
            if description is not None:
                entry.description = description
            if entry.service_class is None and service_class is not None:
                entry.service_class = service_class

        return target_cls

    @classmethod
    def register_service(
        cls,
        key: str,
        *,
        name: Optional[str] = None,
        module_path: Optional[str] = None,
        class_name: Optional[str] = None,
    ):
        def decorator(service_cls: type[Any]):
            return cls._register(
                key=key,
                target_kind="service",
                target_cls=service_cls,
                name=name,
                service_module_path=module_path,
                service_class_name=class_name,
            )

        return decorator

    @classmethod
    def register_router(
        cls,
        key: str,
        *,
        name: Optional[str] = None,
        plural: Optional[str] = None,
        description: str = "",
        service_class: Optional[type[Any]] = None,
    ):
        def decorator(router_cls: type[Any]):
            return cls._register(
                key=key,
                target_kind="router",
                target_cls=router_cls,
                name=name,
                plural=plural or f"{key}s",
                description=description,
                service_class=service_class,
            )

        return decorator

    @classmethod
    def get(cls, key: str) -> Union[RegistryEntry, None]:
        return cls._registry.get(key)

    @classmethod
    def all(cls) -> dict[str, RegistryEntry]:
        return cls._registry

    @classmethod
    def get_service_import_info(cls, key: str) -> tuple[Optional[str], Optional[str]]:
        entry = cls._registry.get(key)
        return (
            (entry.service_module_path, entry.service_class_name)
            if entry
            else (None, None)
        )

    @classmethod
    def openapi_tags(cls):
        return [
            {"name": v.name, "description": v.description}
            for v in cls._registry.values()
            if v.router_class is not None
        ]

    @classmethod
    def get_router_class(cls, key: str):
        entry = cls._registry.get(key)
        return entry.router_class if entry else None

    @classmethod
    def get_service_class(cls, key: str) -> Optional[type[Any]]:
        entry = cls._registry.get(key)
        if not entry:
            return None

        if entry.service_class is not None:
            return entry.service_class

        # Prefer explicit module+class if provided
        if entry.service_module_path and entry.service_class_name:
            mod = importlib.import_module(entry.service_module_path)
            entry.service_class = getattr(mod, entry.service_class_name)
            return entry.service_class

        # most of the time our services will exist directly in the services folder
        module_name = f"{underscore(key)}_service"
        class_name = camelize(key) + "Service"
        mod = importlib.import_module(f"src.services.{module_name}")
        entry.service_class = getattr(mod, class_name)
        return entry.service_class

    @classmethod
    def get_plural(cls, key: str) -> str:
        entry = cls._registry.get(key)
        return entry.plural or (key + "s") if entry else (key + "s")

    @classmethod
    def get_name(cls, key: str) -> str:
        entry = cls._registry.get(key)
        return entry.name if entry else key.capitalize()

    @classmethod
    def is_valid_entity(cls, key: str) -> bool:
        return key in cls._registry

