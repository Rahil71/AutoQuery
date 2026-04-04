from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

prod_engine = None
sandbox_engine = None

ProdSessionLocal = None
SandboxSessionLocal = None


def init_prod_db(database_url):
    global prod_engine, ProdSessionLocal

    prod_engine = create_engine(database_url)
    ProdSessionLocal = sessionmaker(
        autocommit=False,
        autoflush=False,
        bind=prod_engine
    )


def init_sandbox_db(sandbox_url):
    global sandbox_engine, SandboxSessionLocal

    sandbox_engine = create_engine(sandbox_url)
    SandboxSessionLocal = sessionmaker(
        autocommit=False,
        autoflush=False,
        bind=sandbox_engine
    )