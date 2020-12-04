import json

from db import db
from db import User, Assignment, Course
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


# -- COURSE ROUTES ------------------------------------------------------


@app.route("/")
@app.route("/api/courses/")
def get_courses():
    return success_response( [t.serialize() for t in Course.query.all()] )


@app.route("/api/courses/", methods=["POST"])
def create_course():
    body = json.loads(request.data)
    if body.get("code") is None:
        return failure_response('Code not found')
    elif body.get("name") is None:
        return failure_response('Name not found')
    else:
        new_course = Course(code=body.get("code"), name=body.get("name"))
        db.session.add(new_course)
        db.session.commit()
        return success_response(new_course.serialize(), 201)

@app.route("/api/courses/<int:course_id>/")
def get_course(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response('Course not found')
    return success_response(course.serialize())


@app.route("/api/courses/<int:course_id>/", methods=["DELETE"])
def delete_course(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response('Course not found') 
    db.session.delete(course)
    db.session.commit()
    return success_response(course.serialize())


# -- USER ROUTES ---------------------------------------------------


@app.route("/api/users/", methods=["POST"])
def create_user():
    body = json.loads(request.data)
    if body.get("name") is None:
        return failure_response('Name not found')
    elif body.get("netid") is None:
        return failure_response('Netid not found')
    else:
        new_user = User(name=body.get("name"), netid=body.get("netid"))
        db.session.add(new_user)
        db.session.commit()
        return success_response(new_user.serialize(), 201)


@app.route("/api/users/<int:user_id>/")
def get_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response('User not found')
    return success_response(user.serialize())

@app.route("/api/courses/<int:course_id>/add/", methods=["POST"])
def assign_user(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response('Course not found')
    body = json.loads(request.data)
    user_id = body.get('user_id')
    if user_id == None:
        return failure_response('Invalid user_id')
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response('User not found')
    user_type = body.get('type')
    append_user = user.serialize()
    del append_user['courses']
    if user_type == "student":
        course.students.append(append_user) 
        return success_response(course.serialize())
    elif user_type == "instructor":
        course.instructors.append(append_user) 
        return success_response(course.serialize())
    else:
        return failure_response('Invalid user type')
    db.session.commit()


# -- ASSIGNMENT ROUTES --------------------------------------------------


@app.route("/api/courses/<int:course_id>/assignment/", methods=["POST"])
def create_assignment(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response('Course not found')
    body = json.loads(request.data)
    if body.get('title') is None:
        return failure_response('Missing title')
    if body.get('due_date') is None:
        return failure_response('Missing due date')

    append_course = course.serialize()
    del append_course ['assignments']
    del append_course ['instructors']
    del append_course ['students']
    new_assignment = Assignment(
        title=body.get('title'),
        due_date=body.get('due_date'),
        course=5
    )
    db.session.add(new_assignment)
    db.session.commit()
    return success_response(new_assignment.serialize())

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)
