import importlib
import pkgutil

from fastapi import FastAPI

import src.routers  # Ensure the module path is discoverable

from .component_registry import ComponentRegistry
from .factories.router_factory import RouterFactory
from .factories.service_factory import ServiceFactory

# Discover and import all router modules
# this triggers the registration of all routers
for _, module_name, _ in pkgutil.iter_modules(src.routers.__path__):
    importlib.import_module(f"src.routers.{module_name}")


def register_services_and_routers(
    app: FastAPI, service_factory: ServiceFactory, router_factory: RouterFactory
):
    for entity_key in ComponentRegistry.all():
        entity_info = ComponentRegistry.get(entity_key)

        if not entity_info:
            continue

        router_class = entity_info.router_class

        service_class = entity_info.service_class
        service = service_factory.manufacture(entity_key) if service_class else None

        if not router_class:
            continue
        try:
            router = router_factory.manufacture(entity_key, service)
            app.include_router(router)
        except Exception as e:
            raise RuntimeError(
                f"Failed to register router for '{entity_key}': {e}"
            ) from e
