import logging

from dependency_injector import containers, providers

from ..component_registry import ComponentRegistry
from ..factories.router_factory import RouterFactory
from ..factories.service_factory import ServiceFactory
from ..providers.app_context_provider import get_app_context


class AppContainer(containers.DeclarativeContainer):
    # I could create a different logger per factory
    logger = providers.Singleton(logging.getLogger, "foodieLogger")

    ctx = providers.Singleton(
        get_app_context, logger
    )

    component_registry = providers.Object(ComponentRegistry)

    service_factory = providers.Singleton(ServiceFactory, ctx, component_registry, logger)

    router_factory = providers.Singleton(RouterFactory, component_registry, logger)
