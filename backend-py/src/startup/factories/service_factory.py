import logging
from typing import Any, Callable

from ..component_registry import ComponentRegistry
from ..providers.app_context_provider import AppContext

ServiceBuilder = Callable[[], Any]


class ServiceFactory:
    def __init__(
        self, ctx: AppContext, component_registry: ComponentRegistry, logger: logging.Logger
    ):
        self.ctx = ctx
        self.component_registry = component_registry
        self.logger = logger
        self._service_cache: dict[str, Any] = {}
        self._construction_stack: set[str] = set()

        # For services requiring  more complicated initialization
        self._custom_builders: dict[str, ServiceBuilder] = {}

    def manufacture(self, entity: str) -> Any:
        if entity in self._service_cache:
            return self._service_cache[entity]
        if entity in self._construction_stack:
            raise RuntimeError(f"Circular dependency detected at '{entity}'")
        if not self.component_registry.is_valid_entity(entity):
            raise ValueError(f"Unknown entity: {entity}") from None

        self._construction_stack.add(entity)
        try:
            if entity in self._custom_builders:
                service = self._custom_builders[entity]()
            else:
                service_class = self.component_registry.get_service_class(entity)
                if not service_class:
                    raise ValueError(f"No service class found for entity '{entity}'")

                param_map = getattr(service_class, "dependency_params", {})
                deps = {p: self.manufacture(e) for p, e in param_map.items()}
                service = service_class(self.ctx, self.logger, **deps)

            self._service_cache[entity] = service
            return service
        finally:
            self._construction_stack.discard(entity)
