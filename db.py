from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_table = db.Table(
  'association',
  db.Model.metadata,
  db.Column('course_id', db.Integer, db.ForeignKey('course.id')),
  db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

# implement database model classes
class Course(db.Model):
  __tablename__ = 'course'
  id = db.Column(db.Integer, primary_key=True)
  code = db.Column(db.String, nullable=False)
  name = db.Column(db.String, nullable=False)
  assignments = db.relationship('Assignment', cascade='delete')
  users = db.relationship('User', secondary=association_table, back_populates='courses')
  instructors = []
  students = []
 
  def __init__(self, **kwargs):
    self.code = kwargs.get('code')
    self.name = kwargs.get('name')
    self.assignments = []
    self.instructors = []
    self.students = []

  def serialize(self):
    return {
      'id': self.id,
      'code': self.code,
      'name': self.name,
      'assignments': self.assignments,
      'instructors': self.instructors,
      'students': self.students
    }

class Assignment(db.Model):
  __tablename__ = 'assignment'
  id = db.Column(db.Integer, primary_key=True)
  title = db.Column(db.String, nullable=False)
  due_date = db.Column(db.Integer, nullable=False)
  course = db.Column(db.Integer, db.ForeignKey('course.id'), nullable=False)

  def __init__(self, **kwargs):
    self.title = kwargs.get('title')
    self.due_date = kwargs.get('due_date')
    self.course = kwargs.get('course')

  def serialize(self):
    return {
      'id': self.id,
      'title': self.title,
      'due_date': self.due_date,
      'course': self.course
    }

class User(db.Model):
  __tablename__ = 'user'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  netid = db.Column(db.String, nullable=False)
  courses = db.relationship('Course', secondary=association_table, back_populates='users')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
    self.netid = kwargs.get('netid')
    self.courses = []

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'netid': self.netid,
      'courses' : self.courses
    }