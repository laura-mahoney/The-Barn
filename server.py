
import os
from flask import Flask, request, jsonify, render_template, redirect, flash, session, abort
from flask_assets import Environment
from requests_oauthlib import OAuth2Session
from requests_oauthlib.compliance_fixes import facebook_compliance_fix
from jinja2 import StrictUndefined 
from model import connect_to_db, db, Barncrew, Kennel, Dog, Shift
import jinja2

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

    dogs = db.session.query(Dog.dog_name).all()

    flash("Logged in")
    return render_template("barn.html", crew=crew, dogs=dogs)

@app.route('/thebarn')
def loggedin():
    """returns the barn homepage when a user is already logged in"""

    crew = Barncrew.query.get(session['crew_id'])

    dogs = db.session.query(Dog.dog_name).all()

    return render_template("barn.html", crew=crew, dogs=dogs)


@app.route('/logout')
def logout():
    """Log out."""

    del session["crew_id"]
    flash("Logged Out.")
    return redirect("/")



@app.route('/addnotes', methods=['GET'])
def add_notes():
    """opens page to add general notes about the barn"""

    dogs = db.session.query(Dog).all()

    return render_template("addnotes.html", dogs=dogs)


@app.route('/addnotes', methods=['POST'])
def post_notes():
    """submits general notes about the barn"""

    date_time = '01-Jan-2016'
    duration = '3 hours'
    notes = request.form["notes"]

    new_notes = Shift(notes=notes, date_time=date_time, duration=duration)
    
    crew = Barncrew.query.get(session['crew_id'])
    dogs = db.session.query(Dog.dog_name).all()

    db.session.add(new_notes)
    db.session.commit()

    flash("You've added general barn notes!")
    return render_template("barn.html", crew=crew, dogs=dogs)


@app.route("/dog/<int:dog_id>", methods=['GET'])
def user_detail(dog_id):
    """Show info about dog."""

    dog = Dog.query.get(dog_id)
    crew = Barncrew.query.get(session['crew_id'])

    return render_template("dog.html", dog=dog, crew=crew)


# @app.route("/dog/<int:dog_id>", methods=['POST'])
# def user_detail(dog_id):
#     """Submit info about dog."""

#     pass




if __name__ == '__main__':

    
    
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    # DebugToolbarExtension(app)
    
    app.run(host="0.0.0.0", port=5000, debug=True)


