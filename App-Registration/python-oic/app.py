
import json

import requests

from flask import Flask, render_template, request, session, redirect, url_for
from flask_session import Session

from oic.oic import Client
from oic.utils.authn.client import CLIENT_AUTHN_METHOD
from oic.oic.message import ProviderConfigurationResponse
from oic.oic.message import RegistrationResponse
from oic import rndstr
from oic.utils.http_util import Redirect
from oic.oic.message import AuthorizationResponse

import app_config

client = Client(client_authn_method=CLIENT_AUTHN_METHOD)
oidc_config = {}

app = Flask(__name__)
app.secret_key = 'super secret key'
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)

def get_oidc_data():
    url = f"{app_config.AUTHORITY}/.well-known/openid-configuration"
    global oidc_config
    oidc_config = requests.get(url).json()

@app.route("/")
def index():
    if not session.get("user"):
        return redirect(url_for("login"))
    return render_template('index.html', )

def setup_oidc():
    global client

    op_info = ProviderConfigurationResponse(**oidc_config)
    client.handle_provider_config(op_info, op_info['issuer'])
    info = {"client_id": app_config.CLIENT_ID, 
    "client_secret": app_config.CLIENT_SECRET,
    "redirect_uris": ["http://localhost:5000/getAToken"]}
    client_reg = RegistrationResponse(**info)

    client.store_registration_info(client_reg)
    print(client.authorization_endpoint)

@app.route("/login")
def login():
    global args
    session["state"] = rndstr()
    session["nonce"] = rndstr()
    args = {
        "client_id": client.client_id,
        "response_type": "code",
        "scope": ["openid", "profile"],
        "nonce": session["nonce"],
        "redirect_uri": client.registration_response["redirect_uris"][0],
        "state": session["state"]
    }

    
    auth_req = client.construct_AuthorizationRequest(request_args=args)
    login_url = auth_req.request(client.authorization_endpoint)
    print("========")
    print(login_url)
    print("========")
    return Redirect(login_url)

@app.route("/getAToken")
def authorize():
    global args
    response = request.args

    aresp = client.parse_response(AuthorizationResponse, info=response,
                                sformat="dict")

    print(request.args)
    code = aresp["code"]
    assert aresp["state"] == session["state"]

    args["code"]=code
    
    resp = client.do_access_token_request(state=aresp["state"],
                                       request_args=args,
                                       authn_method="client_secret_basic")
    print("======================")
    print(resp)
    print("====================")
    session["user"] = resp['id_token']
    return redirect(url_for('index'))

@app.route("/logout")
def logout():
    session.clear()  # Wipe out user and its token cache from session
    return redirect(  # Also logout from your tenant's web session
        oidc_config['end_session_endpoint']  + "?post_logout_redirect_uri=" + url_for("index", _external=True))

if __name__ == "__main__":
    get_oidc_data()
    print(oidc_config)
    setup_oidc()
    app.run()