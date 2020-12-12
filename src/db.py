from flask_sqlalchemy import SQLAlchemy
import base64
import boto3
import datetime
from io import BytesIO
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import random
import re
import string

db = SQLAlchemy()

EXTENSIONS = ["png", "gif", "jpg", "jpeg"]
BASE_DIR = os.getcwd() 
S3_BUCKET = "cs1998-rainorshine"
S3_BASE_URL = f"https://{S3_BUCKET}.s3-us-east-2.amazonaws.com"


class Outfit(db.Model):
  __tablename__ = 'outfit'

  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  gender = db.Column(db.String, nullable=False)
  weather = db.Column(db.String, nullable=False)
  temp = db.Column(db.String, nullable=False)

  base_url = db.Column(db.String, nullable=True)
  salt = db.Column(db.String, nullable=False)
  extension = db.Column(db.String, nullable=False)
  width = db.Column(db.Integer, nullable = False)
  height = db.Column(db.Integer, nullable=False)
  created_at = db.Column(db.DateTime, nullable=False)
 
  # image_data = db.Column(db.String, nullable=False)

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
    self.gender = kwargs.get('gender')
    self.weather = kwargs.get('weather')
    self.temp = kwargs.get('temp')
    self.create(kwargs.get("image_data"))

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'gender': self.gender,
      'weather': self.weather,
      'temp': self.temp,
      "url": f"{self.base_url}/{self.salt}.{self.extension}",
      "created_at": str(self.created_at),
    }

  def create(self, image_data):
    try:
      # base64 string --> .png --> png
      ext = guess_extension(guess_type(image_data)[0])[1:]
      if ext not in EXTENSIONS:
        raise Exception(f"Extension {ext} not supported")

      # generate secure random string for image name
      salt = "".join(
        random.SystemRandom().choice(
          string.ascii_uppercase + string.digits
        )
        for _ in range(16)
      )
      
      # remove header of base64 string and open image
      img_str = re.sub("^data:image/.+;base64,",  "", image_data)
      image_data = base64.b64decode(img_str)
      img = Image.open(BytesIO(image_data))

      self.base_url = S3_BASE_URL
      self.salt = salt
      self.extension = ext
      self.width = img.width
      self.height = img.height
      self.created_at = datetime.datetime.now()

      img_filename = f"{salt}.{ext}"
      self.upload(img, img_filename)
    
    except Exception as e:
      print(f"Unable to create image due to {e}")

  def upload(self, img, img_filename):
    try:
      # save file temporarily on server
      img_temploc = f"{BASE_DIR}/{img_filename}"
      img.save(img_temploc)

      # upload image to S3
      s3_client = boto3.client("s3")
      s3_client.upload_file(img_temploc, S3_BUCKET, img_filename)

      # make s3 img url public
      s3_resource = boto3.resource("s3")
      object_acl = s3_resource.ObjectAcl(S3_BUCKET, img_filename)
      object_acl.put(ACL="public-read")

      os.remove(img_temploc)

    except Exception as e:
          print(f"Unable to upload image due to {e}")