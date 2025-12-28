import logging

from dotenv import load_dotenv
from fastapi import FastAPI, Request
from fastapi.openapi.docs import get_swagger_ui_html
from fastapi.responses import JSONResponse

from src.startup.auto_register import register_services_and_routers
from src.startup.containers.app_container import AppContainer

load_dotenv('.env.local')

class HealthCheckFilter(logging.Filter):
    """Filter out health check requests from access logs"""

    def filter(self, record: logging.LogRecord) -> bool:
        return "/health" not in record.getMessage()

def configure_logging():
    """Configure logging with INFO level and health check filtering"""
    # Always use INFO level for good visibility
    log_level = logging.INFO

    # Apply health check filter to all environments
    logging.getLogger("uvicorn.access").addFilter(HealthCheckFilter())

    logging.basicConfig(level=log_level)
    logging.info("Application starting with INFO log level (health checks filtered)")


def build_app(container: AppContainer | None = None) -> FastAPI:
    configure_logging()
    app = FastAPI(title="Foodie", description="Recipes Galore", version="1.0.0")

    container = container or AppContainer()
    service_factory = container.service_factory()
    router_factory = container.router_factory()

    register_services_and_routers(app, service_factory, router_factory)

    @app.get("/docs", include_in_schema=False)
    def swagger_docs():
        return get_swagger_ui_html(
            openapi_url=str(app.openapi_url),
            title=f"{app.title} – Swagger",
            swagger_ui_parameters={"docExpansion": "none"},
        )

    def catch_all_exceptions(request: Request, exc: Exception):
        return JSONResponse(status_code=500, content={"detail": str(exc)})

    app.add_exception_handler(Exception, catch_all_exceptions)
    return app


app = build_app()
