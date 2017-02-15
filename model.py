"""Database functions for thebarn database"""

import datetime
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

"""ORM"""

class Barncrew(db.Model):
    """Creates Barn Crew Member"""

    __tablename__ = "barncrew"

    def __repr__(self):
        return "<Crew ID: crew_id=%s First Name: fname=%s>" % (self.crew_id, self.fname)

    crew_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    fname = db.Column(db.String(20), nullable=False)
    lname = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(30), unique=True, nullable=False)
    phone = db.Column(db.String(20), nullable=False)
    password = db.Column(db.String(30), nullable=False)
    pos_code = db.Column(db.String(10), db.ForeignKey("positions.pos_code")) 




class Positions(db.Model):

    __tablename__="positions"

    def __repr__(self):
        return "<Position ID: pos_id=%s>" % (self.pos_code)

    pos_code = db.Column(db.String(10), primary_key=True)



class Dog(db.Model):
    """Creates Dog in the barn"""
    
    __tablename__ = "dog"

    def __repr__(self):
        return "<Dog ID: dog_id=%s Dog Name: dog_name=%s>" % (self.dog_id, self.dog_name)

    dog_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    dog_name = db.Column(db.String(20), nullable=True) 
    kennel_id = db.Column(db.Integer, db.ForeignKey("kennel.kennel_id"), nullable=False)
    breed = db.Column(db.String(60), nullable=False)
    gender = db.Column(db.String(10), nullable=False)
    altered = db.Column(db.Boolean, nullable=False)
    age = db.Column(db.Float, nullable=False)
    intake_date = db.Column(db.DateTime, nullable=False)



class Kennel(db.Model):
    """Prepares kennels for dogs"""

    __tablename__ = "kennel"

    def __repr__(self):
        return "<Kennel ID: kennel_id=%s>" % (self.kennel_id)

    kennel_id = db.Column(db.Integer, primary_key=True)
    dog_door = db.Column(db.Boolean, default=True, nullable=False) #boolean DEFAULT true NOT NULL
    size = db.Column(db.String(10), nullable=False)
    indoor = db.Column(db.Boolean, default=True, nullable=False) #boolean DEFAULT true NOT NULL



class Shift(db.Model):
    """Creates a shift object with"""

    __tablename__ = "shift"

    def __repr__(self):
        return "<Shift ID: shift_id=%s Date: date_time=%s>" % (self.shift_id, self.date_time)

    shift_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    date_time = db.Column(db.DateTime, nullable=False)
    duration =db.Column(db.String(10), nullable=False)
    notes =db.Column(db.String(3000), nullable=False)



class Barncrewshift(db.Model):
    """Creates a shift/volunteer object"""

    __tablename__ = "barncrewshift"

    def __repr__(self):
        return "<Shift ID: shift_id=%s Crew ID: crew_id=%s>" % (self.shift_id, self.crew_id)

    id = db.Column(db.Integer, autoincrement=True, primary_key=True, nullable=False)
    shift_id = db.Column(db.Integer, db.ForeignKey("shift.shift_id"), nullable=False)
    crew_id = db.Column(db.Integer, db.ForeignKey("barncrew.crew_id"), nullable=False)
    mentor_id = db.Column(db.Integer, db.ForeignKey("barncrew.crew_id"), nullable=True)



class Dogshift(db.Model):
    """Creates a shift/dog object"""

    __tablename__ = "dogshift"

    def __repr__(self):
        return "<Shift ID: shift_id=%s Dog ID: dog_id=%s>" % (self.shift_id, self.dog_id)

    shift_id = db.Column(db.Integer, db.ForeignKey("shift.shift_id"), primary_key=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=False)
    notes = db.Column(db.String(3000), nullable=False)


class Activities(db.Model):
    """Creates an activities object for tracking activities as boolean data"""

    __tablename__ = "activities"

    def __repr__(self):
        return "<Shift ID: shift_id=%s Dog ID: dog_id=%s>" % (self.shift_id, self.dog_id)

    shift_id = db.Column(db.Integer, db.ForeignKey("shift.shift_id"), primary_key=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=False)
    dogmountain = db.Column(db.Integer, default=False, nullable=True)
    flirtpole = db.Column(db.Integer, default=False, nullable=True)
    drills = db.Column(db.Integer, default=False, nullable=True)
    walkonleash = db.Column(db.Integer, default=False, nullable=True)
    pushups = db.Column(db.Integer, default=False, nullable=True)
    fetch = db.Column(db.Integer, default=False, nullable=True)
# Helper functions


class Commands(db.Model):
    """ Creates a commands object for tracking command skill progress on a scale from 1 to 5"""

    __tablename__ = "commands"

    def __repr__(self):
        return "<Shift ID: shift_id=%s Dog ID: dog_id=%s>" % (self.shift_id, self.dog_id)

    shift_id = db.Column(db.Integer, db.ForeignKey("shift.shift_id"), primary_key=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=False)
    wait = db.Column(db.Integer, nullable=True)
    sit = db.Column(db.Integer, nullable=True)
    down = db.Column(db.Integer, nullable=True)
    drop = db.Column(db.Integer, nullable=True)
    leaveit = db.Column(db.Integer, nullable=True)
    shake = db.Column(db.Integer, nullable=True)
    stay = db.Column(db.Integer, nullable=True)

class Playmates(db.Model):
    """creates play groups as objects out of dog friends"""
    
    __tablename__ = "playmates"

    def __repr__(self):
        return "<Shift ID: shift_id=%s Dog ID: dog_id=%s>" % (self.shift_id, self.dog_id)

    shift_id = db.Column(db.Integer, db.ForeignKey("shift.shift_id"), primary_key=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=False)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=True)
    dog_id = db.Column(db.Integer, db.ForeignKey("dog.dog_id"), nullable=True)



def init_app():
    # Makes flask app to use Flask-SQLAlchemy.
    from flask import Flask
    app = Flask(__name__)

    connect_to_db(app)
    print "Connected to The Barn DB."

def connect_to_db(app):
    """Connect the database to Flask app."""

    # Configure to use database.
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgres:///thebarn'
    app.config['SQLALCHEMY_ECHO'] = False
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)

def check_crew(email, password):
    pass

if __name__ == "__main__":
  

    from flask import Flask

    app = Flask(__name__)

    connect_to_db(app)
    print "Connected to The Barn DB."

