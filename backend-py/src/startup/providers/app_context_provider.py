import logging
import os
from functools import lru_cache

class AppContext:
    def __init__(
        self,
        logger: logging.Logger,
        env=None,
    ):
        if env is None:
            env = os.getenv("ENV", "dev")

        self.logger = logger
        self.config = {}
        self.config["BASE_ID"] = os.getenv("BASE_ID")
        self.config["PERSONAL_TOKEN"] = os.getenv("PERSONAL_TOKEN")
        print(self.config)


    def get_config_value(self, key: str) -> str:
        return self.config[key]

@lru_cache
def get_app_context(
        logger: logging.Logger,
) -> AppContext:
    return AppContext(logger)
