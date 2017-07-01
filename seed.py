"""utility file to seed barncrew and dogs"""

from sqlalchemy import func
from model import Barncrew, Dog, Kennel, Positions, Shift
import datetime

from model import connect_to_db, db
from server import app


def load_crew():
    """load crew from database"""
    Barncrew.query.delete()

    # Read barncrew file and insert data
    for row in open("seed_data/barncrew.txt"):
        row = row.rstrip()
        fname, lname, email, phone, password, pos_code = row.split("|")

        crew = Barncrew(fname=fname, lname=lname, email=email, phone=phone, password=password, pos_code=pos_code)
        
        db.session.add(crew)
 
    db.session.commit()


def load_dogs():

    Dog.query.delete()

    for row in open("seed_data/dogs.txt"):
        row = row.strip()
        dog_name, kennel_id, breed, gender, altered, age, intake_date = row.split("|")


        if intake_date:
            intake_date = datetime.datetime.strptime(intake_date, "%d-%b-%Y")
        else:
            intake_date = None

        dog = Dog(dog_name=dog_name, kennel_id=kennel_id, breed=breed, gender=gender, altered=altered, age=age, intake_date=intake_date)

        db.session.add(dog)

    db.session.commit()

# def set_val_crew_id():
#     """Set value for the next crew after seeding database"""

#     # Get the Max crew in the database
#     result = db.session.query(func.max(Barncrew.crew_id)).one()
#     max_id = int(result[0])

#     # Set the value for the next crew_id to be max_id + 1
#     query = "SELECT setval('barncrew_crew_id_seq', :new_id)"
#     db.session.execute(query, {'new_id': max_id + 1})
#     db.session.commit()


def load_positions():

    Positions.query.delete()

    pos = ['mgmt', 'admin', 'volunteer']

    for p in pos: 

        position = Positions(pos_code=p)

        db.session.add(position)

    db.session.commit()


def load_kennel():

    Kennel.query.delete()
    
    for row in open("seed_data/kennel.txt"):
        row = row.strip()
        
        kennel_id, dog_door, size, indoor = row.split("|")
   
        kennel = Kennel(kennel_id=kennel_id, dog_door=dog_door, size=size, indoor=indoor)

        db.session.add(kennel)

    db.session.commit()

def load_shift():

    for row in open("seed_data/shift.txt"):
        row = row.strip()

        shift_id, date_time, duration, notes = row.split("|") 
    
        shift = Shift(shift_id=shift_id, date_time=date_time, duration=duration, notes=notes)

        db.session.add(shift)

    db.session.commit()

if __name__ == "__main__":
    connect_to_db(app)

    
    db.create_all()
    
    load_shift()
    load_kennel()
    load_positions()
    load_crew()
    # set_val_crew_id()
    load_dogs()
    