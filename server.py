
import os
from flask import Flask, request, jsonify, render_template, redirect, flash, session, abort
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

""" facebook authentication """

# APP_ID = os.environ['APP_ID']
# APP_SECRET = os.environ['APP_SECRET']
# authorization_base_url = 'https://www.facebook.com/dialog/oauth'
# token_url =  'http://graph.facebook.com/oauth/access_token'
# redirect_uri = 'https://localhost:5000/process_login'


# facebook = OAuth2Session(APP_ID, redirect_uri=redirect_uri)
# facebook = facebook_compliance_fix(facebook)

# os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

app = Flask(__name__)

app.secret_key = "hghghghg"

app.config['TEMPLATES_AUTO_RELOAD'] = True
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0

# assets = Environment(app)

app.jinja_env.undefined = StrictUndefined
# assets.url = app.static_url_path
# app.config['ASSETS_DEBUG'] = True


# def save_created_state(state):
#     pass
# def is_valid_state(state):
#     return True


#routes
#####################################################################


@app.route('/')
def index_page():
    """The Barn Homepage"""

    return render_template("homepage.html")

# @app.route('/login')
# def login():
#     """ Loggin In With Facebook"""
#     authorization_url, state = facebook.authorization_url(authorization_base_url)
#     print 'Please authorize', authorization_url

#     return redirect(authorization_url, code=302)


@app.route('/register', methods=["GET"])
def register_form():
    """ Show form for user signup."""

    return render_template("register_form.html")


# @app.route('/process_login')
# def facebook_auth():
#"""Process login with facebook """

#     error = request.args.get('error', '')
#     if error:
#         return "Error: " + error

#     state = request.args.get('state', '')

#     if not is_valid_state(state):
#         abort(403)
#     code = request.args.get('code')
#     print 20 * '*'
#     print code
    
#     facebook.fetch_token(token_url, APP_SECRET=APP_SECRET, authorization_response="http://localhost:5000/process_login?code="+code+"&state"+state)

#     r = facebook.get('https://graph.facebook.com/me?')
#     return render_template('base.html', content=r.content)



@app.route('/register', methods=['POST'])
def register_process():
    """Process registration"""

    email = request.form["email"]
    password = request.form["password"]


    new_crew = Barncrew(email=email, password=password)

    db.session.add(new_crew)
    db.session.commit()

    flash("You've been added to The Barn Crew!")
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
        flash("Barncrew member does not exist.")
        return redirect("/sign_in")

    if crew.password != password:
        flash("Incorrect password")
        return redirect("/sign_in")

    session["crew_id"] = crew.crew_id
    # Barncrew.query.get(session["crew_id"])

    
    shift_id = Shift.query.all()
    all_crew = Barncrew.query.all()

    recent_shift = Shift.query.order_by(Shift.date_time.desc()).first().shift_id#query for most recent notes by date and time
    recent_notes = Shift.query.get(recent_shift)

    recent_dogshifts = Dogshift.query.filter(Dogshift.shift_id==recent_shift).all() #query for all of the pupdates of this shift id

    # previous_dogshift = Dogshift.query.get(recent_shift-1).all()

    flash("Logged in")
    return render_template("barn.html", crew=crew, dogs=dogs, all_crew=all_crew, shift_id=shift_id, recent_notes=recent_notes, recent_dogshifts=recent_dogshifts)


@app.route('/thebarn')
def logged_in():
    """returns the barn homepage when a user is already logged in"""
    crew = Barncrew.query.get(session['crew_id'])
    dogs = db.session.query(Dog).all()
    
    #shift_id = Shift.query.all()
    all_crew = Barncrew.query.all()
    recent_shift = Shift.query.order_by(Shift.date_time.desc()).first().shift_id#query for most recent notes by date and time
    recent_notes = Shift.query.get(recent_shift)
    
    recent_dogshifts = Dogshift.query.filter(Dogshift.shift_id==recent_shift).all() #query for all of the pupdates of this shift id

    # previous_dogshift = Dogshift.query.filter(Dogshift.shift_id==(recent_shift-1)).all()

    return render_template("barn.html", crew=crew, dogs=dogs, all_crew=all_crew, recent_notes=recent_notes, recent_dogshifts=recent_dogshifts)


@app.route('/logout')
def logout():
    """Log out."""

    del session["crew_id"]
    flash("Logged Out.")
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

    new_dogshiftcom = Dogshiftcommands(commands_id=new_command.commands_id, dogshift_id=new_notes.dogshift_id)

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
    
    # shift_id = Shift.query.get(session['shift_id']) #querying databse for shift_id stored in session

    db.session.commit()

    flash("You've added general barn notes!")
    return redirect("/thebarn")


@app.route('/playmates.json', methods=['GET', 'POST'])
def get_reports():
    """Query the database to get dog friends and dog reports """
    #current dog's id
    current_id = request.form.get('currentDogId')
    print current_id
    #querying for the current dog's playmates 
    dog_playmates = Dogplaymates.query.filter_by(dog_id=current_id).all()

    #alll of the dog objects
    dogs = db.session.query(Dog).all()

    #a list of all the current dog's dog friend ids, not unique  
    dog_friends_ids = []

    for friends in dog_playmates:
        dog_friends_ids.append(friends.play_mate1)
        dog_friends_ids.append(friends.play_mate2)
    
    print dog_friends_ids
    # I was using thiss query to get the dog's names, but decided to just use ids
    # dog_names = []
    
    # for friends in dog_friends_ids:
    #         dog_name=Dog.query.get(friends).dog_name 
    #         dog_names.append(dog_name)


    #looping over the dog list to gather frequency of dog friendships 
    dog_frequency={}

    for friends in dog_friends_ids:
        if friends in dog_frequency:
            dog_frequency[friends] += 1
        else: 
            dog_frequency[friends] = 1

    #make nodes and links for graph out of the unique dog ids 
    #nodes

    dog_nodes = []
    unique_ids=dog_frequency.keys()

    for dog_id in unique_ids: 
        
        dog_dict = {}

        dog_dict['node']=dog_id
        dog_dict['source']=int(current_id)
        
        dog_nodes.append(dog_dict)

    #links 
    dog_links = []

    for dog_id in unique_ids:
        link_dict = {}

        link_dict['source']=int(current_id)
        link_dict['target']=dog_id
        link_dict['value']=dog_frequency[dog_id] #this is the value of frequency 

        dog_links.append(link_dict)

    for i in dog_links:
        print i

    for i in dog_nodes:
        print i

    
    return jsonify({'dog_nodes': dog_nodes, 'dog_links': dog_links})

# @app.route('/getscores', methods=['GET', 'POST'])
# def get_reports():
#     """ Query the database for command scores for each dog for graphing"""
#     pass








if __name__ == '__main__':

    
    
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    # DebugToolbarExtension(app)
    
    app.run(host="0.0.0.0", port=5000, debug=True)


