
import os
from flask import Flask, request, jsonify, render_template, redirect, flash, session, abort, url_for
from flask_assets import Environment
from requests_oauthlib import OAuth2Session
from requests_oauthlib.compliance_fixes import facebook_compliance_fix
from jinja2 import StrictUndefined 
from model import connect_to_db, db, Barncrew, Kennel, Dog, Shift, Activities, Commands, Dogshiftcommands, Dogshiftactivities, Dogplaymates, Dogshift, Barncrewshift
import jinja2
import json 
from datetime import datetime, time, date
from sqlalchemy import desc
from json import loads 
from werkzeug.utils import secure_filename #add
import bcrypt

# UPLOAD_FOLDER = 'static/images'
ALLOWED_EXTENSIONS = set(['jpg'])

app = Flask(__name__)

app.secret_key = "hghghghg"

APP_ROOT = os.path.dirname(os.path.abspath(__file__))
UPLOAD_FOLDER = os.path.join(APP_ROOT, 'static/images')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER #add

app.config['TEMPLATES_AUTO_RELOAD'] = True
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0

app.jinja_env.undefined = StrictUndefined


#routes
#####################################################################


@app.route('/')
def index_page():
    """The Barn Homepage"""

    return render_template("homepage.html")

@app.route('/register', methods=["GET"])
def register_form():
    """ Show form for user signup."""

    return render_template("register_form.html")


@app.route('/register', methods=['POST'])
def register_process():
    """Process registration"""

    email = request.form["email"]
    password = request.form["password"]
    hashed_password = bcrypt.hashpw(password.encode('utf8'), bcrypt.gensalt(12)) 

    fname = request.form["fname"]
    lname = request.form["lname"]

    user_exists = Barncrew.query.filter_by(email=email).first()
    
    if user_exists is not None: 
        flash("A User With That Email Already Exists!", 'error')
        return redirect('/register')
    else:
        new_crew = Barncrew(email=email, password=hashed_password, fname=fname, lname=lname)

        db.session.add(new_crew)
        db.session.commit()

        flash("You're Signed Up for Pupdates!", 'message')
        return redirect("/sign_in")



@app.route('/sign_in', methods=['GET'])
def sign_in_form():
    """Show login form"""

    return render_template("sign_in.html")



@app.route('/sign_in', methods=['POST'])
def sign_in_process():
    """Process login"""

    email = request.form["email"]
    password = request.form["password"]

    crew = Barncrew.query.filter_by(email=email).first()
    dogs = db.session.query(Dog).all()

    if not crew:
        flash("Barncrew Member Does Not Exist", 'error')
        return redirect("/sign_in")

    if bcrypt.checkpw(password.encode('utf8'), crew.password.encode('utf8')):

        session["crew_id"] = crew.crew_id
        
        shift_id = Shift.query.all()
        all_crew = Barncrew.query.all()

        recent_shift = Shift.query.order_by(Shift.date_time.desc()).first().shift_id#query for most recent notes by date and time
        recent_notes = Shift.query.get(recent_shift)

        recent_dogshifts = Dogshift.query.filter(Dogshift.shift_id==recent_shift).all() #query for all of the pupdates of this shift id

        flash("Signed In")
        return render_template("barn.html", crew=crew, dogs=dogs, all_crew=all_crew, shift_id=shift_id, recent_notes=recent_notes, recent_dogshifts=recent_dogshifts)

    else:
        flash("Incorrect Password", 'error')
        return redirect("/sign_in")


@app.route('/thebarn')
def logged_in():
    """returns the barn homepage when a user is already logged in"""
    crew = Barncrew.query.get(session['crew_id'])
    dogs = db.session.query(Dog).all()
    
    all_crew = Barncrew.query.all()
    recent_shift = Shift.query.order_by(Shift.date_time.desc()).first().shift_id#query for most recent notes by date and time
    recent_notes = Shift.query.get(recent_shift)
    
    recent_dogshifts = Dogshift.query.filter(Dogshift.shift_id==recent_shift).all() #query for all of the pupdates of this shift id

    return render_template("barn.html", crew=crew, dogs=dogs, all_crew=all_crew, recent_notes=recent_notes, recent_dogshifts=recent_dogshifts)


@app.route('/logout')
def logout():
    """Log out."""

    del session["crew_id"]
    flash("Logged Out", 'message')
    return redirect("/")



@app.route('/addnotes', methods=['POST'])
def create_shift():
    """opens page to add general notes about the barn"""
    #shift is created here in the db, new shift created, shift id passed to jinja, pass in crew
    crew = Barncrew.query.get(session['crew_id'])
    dogs = db.session.query(Dog).all()
    
    date_time = request.form.get("date") + " " + request.form.get("time")
    date_time = datetime.strptime(date_time, "%Y-%m-%d %H:%M")

    duration = request.form.get("duration_shift")
    support_name = request.form.get("crew_name")
    support = Barncrew.query.filter(Barncrew.fname==support_name).first()

    new_shift = Shift(date_time=date_time, duration=duration)    
    db.session.add(new_shift)
    db.session.commit()

    new_bcshift = Barncrewshift(shift_id=new_shift.shift_id, crew_id=crew.crew_id, support_id=support.crew_id)
    db.session.add(new_bcshift)
    db.session.commit()   


    return render_template("addnotes.html", dogs=dogs, crew=crew, shift_id=new_shift.shift_id, new_shift=new_shift)



@app.route("/dog/notes.json", methods=['POST'])
def dog_form():
    """Gathers info about a dog from form and sends to database."""

    
    crew = Barncrew.query.get(session['crew_id'])
    # shift_id = Shift.query.get(session['shift_id']) #querying databse for shift_id stored in session

    dog_id = request.form.get("dog-id")
    dog = Dog.query.get(dog_id)
    shift_id = request.form.get("shift-id")
    notes = request.form.get("pupdatenotes")

    dogmountain = request.form.get("dogmountain")
    flirtpole = request.form.get("flirtpole")
    drills = request.form.get("drills")
    walkonleash = request.form.get("leash")
    pushups = request.form.get("pushups")
    fetch = request.form.get("fetch")

    wait = request.form.get("wait")
    sit = request.form.get("sit")
    down = request.form.get("down")
    drop = request.form.get("drop")
    leaveit = request.form.get("leaveit")
    shake = request.form.get("shake")
    stay = request.form.get("stay")

    dogs = db.session.query(Dog).all()
    play_mate1 = request.form.get("dog1")
    play_mate2 = request.form.get("dog2")

    new_notes = Dogshift(shift_id=shift_id, dog_id=dog_id, notes=notes)


    new_activity = Activities(dogmountain=dogmountain, flirtpole=flirtpole, drills=drills,
                            walkonleash=walkonleash, pushups=pushups, fetch=fetch)

    new_command = Commands(wait=wait, sit=sit, down=down, drop=drop, leaveit=leaveit,
                            shake=shake, stay=stay)

    new_playmate = Dogplaymates(shift_id=shift_id, dog_id=dog_id, play_mate1=play_mate1, play_mate2=play_mate2)


    db.session.add(new_notes)
    db.session.add(new_activity)
    db.session.add(new_command)
    db.session.add(new_playmate)
    db.session.commit()

    new_dogshiftact = Dogshiftactivities(activity_id=new_activity.activity_id, dogshift_id=new_notes.dogshift_id)

    score = wait + sit + down + drop + leaveit + shake + stay
    
    new_dogshiftcom = Dogshiftcommands(commands_id=new_command.commands_id, dogshift_id=new_notes.dogshift_id, score=score)

    db.session.add(new_dogshiftact)
    db.session.add(new_dogshiftcom)
    db.session.commit()

    my_dictionary = {"message": "notes succesfully added"}

    return jsonify(my_dictionary)



@app.route('/submitnotes', methods=['POST'])
def post_notes():
    """submits general notes about the barn by updating the shift that has already been created"""
    crew = Barncrew.query.get(session['crew_id'])
    dogs = db.session.query(Dog).all()
    shift_id = request.form.get('shift-id')

    shift = Shift.query.get(shift_id)
    shift.notes = request.form.get('notes')
    
    db.session.commit()

    flash("You've Added General Barn Notes!", 'message')
    return redirect("/thebarn")


@app.route('/getintakedata', methods=['GET'])
def get_intake():

    dogs = db.session.query(Dog).all()
    total_dogs = len([i for i in dogs])
    

    current_id = request.args.get('currentDogId')

    recent_shift = Shift.query.order_by(Shift.date_time.desc()).first().shift_id#query for most recent notes by date and time
    recent_notes = Shift.query.get(recent_shift)
    
    recent_dogshifts = Dogshift.query.filter(Dogshift.shift_id==recent_shift).all() 
    intake_data = Dog.query.get(int(current_id))

    recent_dog_notes = []

    for recent in recent_dogshifts:
        if recent.dog_id == int(current_id):
            recent_dog_notes.append(recent.notes)

    data = {'total_dogs': total_dogs, 'recentnotes': recent_dog_notes, 'dogid': int(current_id), 'name': intake_data.dog_name, 'kennel': intake_data.kennel_id, 'age': intake_data.age, 'breed': intake_data.breed, 'intakedate': intake_data.intake_date, 'gender': intake_data.gender, 'altered': intake_data.altered}


    return jsonify(data)

@app.route('/reports.json', methods=['GET', 'POST'])
def get_reports():
    """Query the database to get dog friends and dog reports """
    #current dog's id and name 
    current_id = request.form.get('currentDogId')
    current_name = Dog.query.get(current_id).dog_name
    print current_name 

    #querying for the current dog's playmates 
    dog_playmates = Dogplaymates.query.filter_by(dog_id=current_id).all()

    #query for dogshifts of this dog to get scores of the current dog 
    dsids = []

    dogsid = Dogshift.query.filter_by(dog_id=current_id).all()
    for item in dogsid:
         dsids.append(item.dogshift_id) 


    scores = []
    for item in dsids: 
        dogscore = Dogshiftcommands.query.filter_by(dogshift_id=item).one()
        scores.append(dogscore.score)
    
    #get the averages of all the scores
    averages = {'Wait': 0, 'Sit': 0, 'Down': 0, 'Drop': 0, 'Leave It': 0, 'Shake': 0, 'Stay': 0}

    for item in scores:
        averages['Wait']=averages['Wait']+int(item[0])
        averages['Sit']=averages['Sit']+int(item[1])
        averages['Down']=averages['Down']+int(item[2])
        averages['Drop']=averages['Drop']+int(item[3])
        averages['Leave It']=averages['Leave It']+int(item[4])
        averages['Shake']=averages['Shake']+int(item[5])
        averages['Stay']=averages['Stay']+int(item[6])

    if len(scores)>1:
        for key in averages:
            averages[key] = averages[key]/len(scores)

    average_score = []
    average_score.append(averages)


    command_data = {
     "labels": averages.keys(),
                "datasets": [
                    {
                        "data": averages.values(),
                        "backgroundColor": [
                            "#96FFF3",
                            "#96D7FF",
                            "#96A2FF",
                            "#96FFBF",
                            "#A2FF96",
                            "#8BFCE6",
                            "#A1BFFF"
                        ],
                        "hoverBackgroundColor": [
                            "#C0C2C0",
                            "#C0C2C0",
                            "#C0C2C0",
                            "#C0C2C0",
                            "#C0C2C0",
                            "#C0C2C0",
                            "#C0C2C0"
                        ]

                    }]
        }
    

    #a list of all the current dog's dog friend ids, not unique  
    dog_friends_ids = []

    for friends in dog_playmates:
        dog_friends_ids.append(friends.play_mate1)
        dog_friends_ids.append(friends.play_mate2)
    

    #this initializes the first index of the node list as a dictionary with nodes and sources defined as the current dog's dog name
    dog_nodes = []
    current_dog = {}
    current_dog['node'] = current_name 
    current_dog['source'] = current_name

    dog_nodes.append(current_dog)


    #now dog friend ids are unique as nodes , no more repeat names 
    dog_friends_ids = set(dog_friends_ids)

    #dog nodes are now based on dog friend names instead of ids 
    for friends in dog_friends_ids:
            dog_names={}
            dog_name=Dog.query.get(friends).dog_name 
            dog_names['node']=dog_name
            dog_names['source']=current_name 

            dog_nodes.append(dog_names)

    print dog_nodes

    #links are just indices based on the length of the dog nodes
    dog_links = []
    for i in range(1, len(dog_nodes)):
        link = {'source': 0, 'target': i}
        dog_links.append(link)

    print dog_links  
    
    return jsonify({'dog_nodes': dog_nodes, 'dog_links': dog_links, 'command_data': command_data})


#this function will help the route upload the image to the folder
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


# this route will get dog info, and add a new dog to the database
@app.route('/adddog', methods=['GET', 'POST'])
def add_dog():

    dog_name = request.form.get('dog_name')
    breed = request.form.get('breed')
    age = request.form.get('age')
    gender = request.form.get('gender')
    altered = request.form.get('altered')
    intake_date = request.form.get('intake_date')
    
    verify_values = [dog_name, breed, age, gender, altered, intake_date]

    #if form is left empty, flash error message
    for vals in verify_values:
        if vals == "" or None:
            flash('Please Complete Missing Information', 'error')
            return redirect('/thebarn')

    #checking if the dog already exists in the barn
    dog_exists = Dog.query.filter_by(dog_name = dog_name).first()

    #if the dog name already exists
    if dog_exists is not None:
        flash('Dog Name is Taken, Please Choose Another', 'error')
        return redirect("/thebarn")
    #checking if post request has image file part named 'new_dog_pic'
    if 'new_dog_pic' not in request.files:
            flash('Please Upload a Photo', 'error')
            return redirect('/thebarn')

    file = request.files['new_dog_pic']
    print type(file)

    if file.filename == '':
        flash('Please Upload a Photo', 'error')
        return redirect('/thebarn')

    #breaks the file name up to be renamed with dog's name and img type added at end
    file_arrary = file.filename.split(".")
    file.filename = dog_name + "." + file_arrary[-1]

    print file.filename 
    # if user does not select file, browser also
    # submit a empty part without filename

    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    

    new_dog_pic = file.filename

    #creates a new kennel for the new dog
    new_kennel = Kennel(dog_door=True, size='Small', indoor=True)

    db.session.add(new_kennel)
    db.session.commit()

    new_kennel = Kennel.query.order_by(Kennel.kennel_id.desc()).first()

    new_dog = Dog(dog_name=dog_name, breed=breed, age=int(age), gender=gender, kennel_id = new_kennel.kennel_id, altered=altered, intake_date=intake_date, dog_pic=new_dog_pic)

    db.session.add(new_dog)
    db.session.commit()

    flash("You've added " + dog_name + " to the barn!")
    return redirect("/thebarn")

if __name__ == '__main__':
    
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    # DebugToolbarExtension(app)
    
    app.run(host="0.0.0.0", port=5000, debug=True)


