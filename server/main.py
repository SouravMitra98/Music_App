from models.base import Base
from xml.dom.expatbuilder import TEXT_NODE
from fastapi import FastAPI, Request
from routes import auth, song
from database import engine

app = FastAPI()

app.include_router(auth.router, prefix="/auth")
app.include_router(song.router, prefix="/song")

Base.metadata.create_all(engine)
