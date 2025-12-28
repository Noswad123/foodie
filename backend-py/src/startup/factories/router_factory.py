import logging

from fastapi import APIRouter
from inflection import underscore

from ..component_registry import ComponentRegistry


class RouterFactory:
    def __init__(
            self,
            component_registry: ComponentRegistry,
            logger: logging.Logger
    ):
        self.entity_registry = component_registry
        self.logger = logger

    def manufacture(self, entity: str, service) -> APIRouter:
        if not self.entity_registry.get(entity):
            raise ValueError(f"Unknown entity: {entity}")

        router_class = self.entity_registry.get_router_class(entity)
        if not router_class:
            raise ValueError(f"Router class doesn't exist for {entity}")

        plural = self.entity_registry.get_plural(entity)
        name = self.entity_registry.get_name(entity)

        router = APIRouter(
            prefix=f"/{underscore(plural).replace('_', '-')}", tags=[name]
        )
        try:
            return router_class(
                logger=self.logger,
                service=service,
                router=router,
            ).register()
        except TypeError as e:
            if service is None:
                return router_class(
                    logger=self.logger,
                    router=router
                ).register()
            raise RuntimeError(f"Failed to construct router for '{entity}': {e}") from e
