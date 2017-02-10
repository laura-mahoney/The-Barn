
import os
from flask import Flask, request, jsonify, render_template, redirect, flash, session, abort
from flask_assets import Environment
from requests_oauthlib import OAuth2Session
from requests_oauthlib.compliance_fixes import facebook_compliance_fix
from jinja2 import StrictUndefined 

APP_ID = os.environ['APP_ID']
APP_SECRET = os.environ['APP_SECRET']
authorization_base_url = 'https://www.facebook.com/dialog/oauth'
token_url =  'http://graph.facebook.com/oauth/access_token'
redirect_uri = 'https://localhost:5000/process_login'


facebook = OAuth2Session(APP_ID, redirect_uri=redirect_uri)
facebook = facebook_compliance_fix(facebook)

os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

app = Flask(__name__)

assets = Environment(app)

app.jinja_env.undefined = StrictUndefined
assets.url = app.static_url_path
app.config['ASSETS_DEBUG'] = True


def save_created_state(state):
    pass
def is_valid_state(state):
    return True


#routes
#####################################################################
@app.route('/')
def index_page():
    """The Barn Hello"""

    return render_template("homepage.html")

@app.route('/login')
def login():
    """ Loggin In With Facebook"""
    authorization_url, state = facebook.authorization_url(authorization_base_url)
    print 'Please authorize', authorization_url

    return redirect(authorization_url, code=302)

@app.route('/process_login')
def facebook_auth():

    error = request.args.get('error', '')
    if error:
        return "Error: " + error

    state = request.args.get('state', '')

    if not is_valid_state(state):
        abort(403)
    code = request.args.get('code')
    print 20 * '*'
    print code
    
    facebook.fetch_token(token_url, APP_SECRET=APP_SECRET, authorization_response="http://localhost:5000/process_login?code="+code+"&state"+state)

    r = facebook.get('https://graph.facebook.com/me?')
    return render_template('base.html', content=r.content)



if __name__ == '__main__':

    app.run(host="0.0.0.0", port=5000, debug=True)



