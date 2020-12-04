from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Outfit(db.Model):
  __tablename__ = 'outfit'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  gender = db.Column(db.String, nullable=False)
  weather = db.Column(db.String, nullable=False)
  min_temp = db.Column(db.Integer, nullable=False)
  max_temp = db.Column(db.Integer, nullable=False)
 
  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
    self.gender = kwargs.get('gender')
    self.weather = kwargs.get('weather')
    self.min_temp = kwargs.get('min_temp')
    self.max_temp = kwargs.get('max_temp')

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'gender': self.gender,
      'weather': self.weather,
      'min_temp': self.min_temp,
      'max_temp': self.max_temp
    }