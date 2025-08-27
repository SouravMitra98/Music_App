import uuid
import cloudinary
from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session, joinedload
from database import get_db
from models.favorite import Favorite
from models.song import Song
from pydantic_schemas.favorite_song import FavoriteSong
from routes.auth import auth_middleware
import cloudinary.uploader


router = APIRouter()

cloudinary.config(
    cloud_name="djzddtynd",
    api_key="878262491229153",
    api_secret="fyDTZea09TmLc_ob9W46I4toQ88",  # Click 'View API Keys' above to copy your API secret
    secure=True,
)


@router.post("/upload", status_code=201)
def upload_song(
    song: UploadFile = File(...),
    thumbnail: UploadFile = File(...),
    artist: str = Form(...),
    song_name: str = Form(...),
    hex_code: str = Form(...),
    db: Session = Depends(get_db),
    auth_dict=Depends(auth_middleware),
):
    song_id = str(uuid.uuid4())
    song_result = cloudinary.uploader.upload(
        song.file, resource_type="auto", folder=f"songs/{song_id}"
    )
    thumb_result = cloudinary.uploader.upload(
        thumbnail.file, resource_type="auto", folder=f"songs/{song_id}"
    )
    new_song = Song(
        id=song_id,
        song_name=song_name,
        artist=artist,
        hex_code=hex_code,
        song_url=song_result["url"],
        thumbnail_url=thumb_result["url"],
    )

    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    return new_song


@router.get("/list")
def list_songs(db: Session = Depends(get_db), auth_details=Depends(auth_middleware)):
    songs = db.query(Song).all()
    return songs


@router.post("/favorite")
def favorite_song(
    fav_song: FavoriteSong,
    db: Session = Depends(get_db),
    auth_details=Depends(auth_middleware),
):
    user_id = auth_details["uid"]
    existing_fav = (
        db.query(Favorite)
        .filter(Favorite.song_id == fav_song.song_id, Favorite.user_id == user_id)
        .first()
    )

    if existing_fav:
        db.delete(existing_fav)
        db.commit()
        return {"message": False}
    else:
        new_fav = Favorite(
            id=str(uuid.uuid4()),
            song_id=fav_song.song_id,  # ✅ this now refers to the request body
            user_id=user_id,
        )
        db.add(new_fav)
        db.commit()
        db.refresh(new_fav)
        return {"message": True, "favorite": new_fav}


@router.get("/list/favorites")
def list_fav_songs(
    db: Session = Depends(get_db), auth_details=Depends(auth_middleware)
):
    user_id = auth_details["uid"]
    fav_songs = (
        db.query(Favorite)
        .filter(Favorite.user_id == user_id)
        .options(joinedload(Favorite.song))
        .all()
    )
    # songs = db.query(Song).all()
    return fav_songs
