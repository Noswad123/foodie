import logging

from fastapi import APIRouter

from src.services.ingredient_service import IngredientService
from src.startup.component_registry import ComponentRegistry

from .base_router import BaseRouter

@ComponentRegistry.register_router(
    key="ingredient",
    service_class=IngredientService,
    description="Ingredients used in recipes"
)
class IngredientRouter(BaseRouter[IngredientService]):
    def __init__(self, logger: logging.Logger, service, router: APIRouter):
        super().__init__(logger, service, router)

    def register(self):
        @self.router.get("/")
        def get_ingredients():
            return self.service.get_ingredients()
        return self.router
