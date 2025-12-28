import logging
from typing import Generic, TypeVar

from fastapi import APIRouter

ServiceType = TypeVar("ServiceType")


class BaseRouter(Generic[ServiceType]):
    def __init__(self, logger: logging.Logger, service: ServiceType, router: APIRouter):
        self.service = service
        self.router = router
        self.logger = logger
