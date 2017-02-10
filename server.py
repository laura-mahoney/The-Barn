
import os
from flask import Flask, request, jsonify, render_template, redirect, flash, session, abort
from flask_assets import Environment
from requests_oauthlib import OAuth2Session
from requests_oauthlib.compliance_fixes import facebook_compliance_fix
from jinja2 import StrictUndefined 
from model import connect_to_db, db, Barncrew, Kennel

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
    return redirect("/")



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
        return redirect("/register")

    if crew.password != password:
        flash("Incorrect password")
        return redirect("/sign_in")

    session["crew_id"] = crew.crew_id

    flash("Logged in")
    return redirect("/barn/%s" % crew.crew_id)



@app.route('/logout')
def logout():
    """Log out."""

    del session["crew_id"]
    flash("Logged Out.")
    return redirect("/")




if __name__ == '__main__':

    
    
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    DebugToolbarExtension(app)
    
    app.run(host="0.0.0.0", port=5000, debug=True)


