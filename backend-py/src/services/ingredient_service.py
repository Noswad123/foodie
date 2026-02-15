import logging
import json

import requests


class IngredientService:
    def __init__(self, ctx, logger: logging.Logger):
        self.ctx = ctx
        self.logger = logger

    def get_ingredients(self):
        table_name = "Ingredients"
        TOKEN = self.ctx.get_config_value("PERSONAL_TOKEN")
        base_id = self.ctx.get_config_value("BASE_ID")
        endpoint = f"https://api.airtable.com/v0/{base_id}/{table_name}"
        headers = {
            "Authorization": f"Bearer {TOKEN}",
        }
        r = requests.get(endpoint, headers=headers)

        return r.json()
