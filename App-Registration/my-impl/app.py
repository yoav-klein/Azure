
import json
from urllib.parse import urlencode, urlunparse, urlparse

import requests
import jwt
from flask import Flask, render_template, request, session, redirect, url_for
from flask import Flask, url_for, redirect, session

import app_config

app = Flask(__name__)
app.config.from_object(app_config)
app.secret_key = 'super secret key'
app.config['SESSION_TYPE'] = 'filesystem'

op_config = {}

def configure_op():
    url = f"{app_config.AUTHORITY}/.well-known/openid-configuration"
    global op_config
    op_config = requests.get(url).json()


def construct_auth_endpoint_url():    
    query = {
        'scope': 'openid profile offline_access' + ' ' + app_config.SCOPES,
        'client_id': app_config.CLIENT_ID,
        'response_type': 'code',
        'response_mode': 'query',
        'state': 'random_string',
        'redirect_uri': app_config.REDIRECT_URI
    }

    query_string = urlencode(query)
    parsed = urlparse(op_config['authorization_endpoint'])
    auth_uri = urlunparse([parsed[0], parsed[1], parsed[2], '', query_string, ''])

    return auth_uri


@app.route("/")
def index():
    if "user" not in session:
        return redirect(url_for("login"))
    return render_template("index.html", name=session["user"]["name"])


@app.route("/graphcall")
def graphcall():
    token = session['access_token']
    if not token:
        return redirect(url_for("login"))
    graph_data = requests.get(  # Use token to call downstream service
        app_config.ENDPOINT,
        headers={'Authorization': 'Bearer ' + token},
        ).json()
    return render_template('display.html', result=graph_data)


@app.route("/login")
def login():
    print(construct_auth_endpoint_url())
    return render_template("login.html", auth_url=construct_auth_endpoint_url())
    
@app.route("/logout")
def logout():
    session.clear()  # Wipe out user and its token cache from session
    return redirect(  # Also logout from your tenant's web session
        op_config['end_session_endpoint']  + "?post_logout_redirect_uri=" + url_for("index", _external=True))


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
    
    resp = requests.post(token_endpoint, data=query_string).json()
    
    session['user'] = jwt.decode(resp['id_token'], options={"verify_signature": False})
    session['access_token'] = resp['access_token']

    return redirect(url_for("index"))

def main():
    configure_op()
    app.run()

if __name__ == "__main__":
    main()