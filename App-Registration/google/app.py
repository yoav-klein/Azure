
import hashlib
import os
import json

from urllib.parse import urlencode, urlunparse, urlparse

import requests
import jwt
from flask import Flask, session, render_template, url_for, redirect, request

import app_config

app = Flask(__name__)
app.config.from_object(app_config)
app.secret_key = 'super secret key'
app.config['SESSION_TYPE'] = 'filesystem'

op_config = {}
def configure_op():
    global op_config
    op_config = requests.get("https://accounts.google.com/.well-known/openid-configuration").json()
    print(op_config)

# Create a state token to prevent request forgery.
# Store it in the session for later validation.
#state = hashlib.sha256(os.urandom(1024)).hexdigest()
#session['state'] = state
# Set the client ID, token state, and application name in the HTML while
# serving it.


def construct_auth_endpoint_url():    
    query = {
        'scope': 'openid profile email',
        'client_id': app_config.CLIENT_ID,
        'response_type': 'code',
        'response_mode': 'query',
        'state': hashlib.sha256(os.urandom(1024)).hexdigest(),
        'redirect_uri': app_config.REDIRECT_URI
    }

    query_string = urlencode(query)
    parsed = urlparse(op_config['authorization_endpoint'])
    auth_uri = urlunparse([parsed[0], parsed[1], parsed[2], '', query_string, ''])

    return auth_uri


@app.route(app_config.REDIRECT_PATH)
def authorized():
    code = request.args['code']
    state = request.args['state']

    token_endpoint = op_config['token_endpoint']
    
    query = {
        'client_id': app_config.CLIENT_ID,
        'code': code,
        'grant_type': 'authorization_code',
        'client_secret': app_config.CLIENT_SECRET,
        'redirect_uri': app_config.REDIRECT_URI
    }

    query_string = urlencode(query)
    
    resp = requests.post(token_endpoint, data=query_string, headers={'Content-Type': 'application/x-www-form-urlencoded'}).json()
    
    session['user'] = jwt.decode(resp['id_token'], options={"verify_signature": False})
    session['access_token'] = resp['access_token']

    return redirect(url_for("index"))

@app.route("/")
def index():
    if "user" not in session:
        return redirect(url_for("login"))
    return render_template("index.html", name=session["user"]["name"])

    
@app.route("/login")
def login():
    return render_template("login.html", auth_url=construct_auth_endpoint_url())


def main():
    configure_op()
    app.run()


if __name__ == "__main__":
    main()