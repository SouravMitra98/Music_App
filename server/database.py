from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
import psycopg2


DATABASE_URL = "postgresql+psycopg2://postgres:Sourav7452@localhost:5432/musicapp"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
