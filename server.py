
import os
from flask import Flask, request, jsonify, render_template, redirect, flash, session, abort
from flask_assets import Environment
from requests_oauthlib import OAuth2Session
from requests_oauthlib.compliance_fixes import facebook_compliance_fix
from jinja2 import StrictUndefined 
from model import connect_to_db, db, Barncrew, Kennel, Dog, Shift, Activities, Commands, Dogshiftcommands, Dogshiftactivities, Dogplaymates, Dogshift
import jinja2
import json 
from datetime import datetime

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

    if not crew:
        flash("Barncrew member does not exist.")
        return redirect("/sign_in")

    if crew.password != password:
        flash("Incorrect password")
        return redirect("/sign_in")

    session["crew_id"] = crew.crew_id
    # Barncrew.query.get(session["crew_id"])

    dogs = db.session.query(Dog).all()

    flash("Logged in")
    return render_template("barn.html", crew=crew, dogs=dogs)

@app.route('/thebarn')
def logged_in():
    """returns the barn homepage when a user is already logged in"""
    crew = Barncrew.query.get(session['crew_id'])
    # dogs = db.session.query(Dog.dog_name).all()
    dogs = db.session.query(Dog).all()

    return render_template("barn.html", crew=crew, dogs=dogs)


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
    
    date_time = request.form.get("time_day")
    duration = request.form.get("duration_shift")
    print date_time
    print duration


    new_shift = Shift(date_time=date_time, duration=duration)
    db.session.add(new_shift)
    db.session.commit()

    session["shift_id"] = new_shift.shift_id #adding shift_id to session for later use

    return render_template("addnotes.html", dogs=dogs, crew=crew, shift_id=new_shift.shift_id)



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


    new_notes = Dogshift(shift_id=shift_id, dog_id=dog_id, notes=notes)


    new_activity = Activities(dogmountain=dogmountain, flirtpole=flirtpole, drills=drills,
                            walkonleash=walkonleash, pushups=pushups, fetch=fetch)

    new_command = Commands(wait=wait, sit=sit, down=down, drop=drop, leaveit=leaveit,
                            shake=shake, stay=stay)


    db.session.add(new_notes)
    db.session.add(new_activity)
    db.session.add(new_command)
    db.session.commit()

    # new_dogshiftact = Dogshiftactivities(activity_id=)

    # new_dogshiftcom = Dogshiftcommands()

    # db.session.add(new_dogshiftact)
    # db.session.add(new_dogshiftcom)
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



if __name__ == '__main__':

    
    
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    # DebugToolbarExtension(app)
    
    app.run(host="0.0.0.0", port=5000, debug=True)


