import json

from db import db
from db import Outfit
from flask import Flask
from flask import request

# define db filename
db_filename = "outfits.db"
app = Flask(__name__)

# setup config
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

# -- ROUTES ------------------------------------------------------

@app.route("/")
@app.route("/api/outfits/")
def get_outfits():
    return success_response( [o.serialize() for o in Outfit.query.all()] )

@app.route("/api/outfits/<string:gender>/<string:weather>/<string:temp>/")
def get_outfit(gender, weather, temp):
    outfits = Outfit.query.filter_by(gender=gender, weather=weather, temp=temp)
    if outfits is None:
        return failure_response('Outfit not found')
    return success_response( [o.serialize() for o in outfits] )

@app.route("/api/outfits/", methods=["POST"])
def create_outfit():
    body = json.loads(request.data)
    if body.get("name") is None:
        return failure_response('Name not found')
    if body.get("gender") is None:
        return failure_response('Gender not found')
    elif body.get("weather") is None:
        return failure_response('Weather not found')
    elif body.get("temp") is None:
        return failure_response('Temperature not found')
    else:
        new_outfit = Outfit(name=body.get ("name"), gender=body.get("gender"), weather=body.get("weather"), temp=body.get("temp"))
        db.session.add(new_outfit)
        db.session.commit()
        return success_response(new_outfit.serialize(), 201)

@app.route("/api/outfits/<int:course_id>/", methods=["DELETE"])
def delete_outfit(course_id):
    outfit = Outfit.query.filter_by(id=course_id).first()
    if outfit is None:
        return failure_response('Outfit not found') 
    db.session.delete(outfit)
    db.session.commit()
    return success_response(outfit.serialize())

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)