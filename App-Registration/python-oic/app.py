
from flask import Flask, request, session, redirect, url_for
from flask_session import Session

from oic.oic import Client
from oic.utils.authn.client import CLIENT_AUTHN_METHOD
from oic.oic.message import ProviderConfigurationResponse
from oic.oic.message import RegistrationResponse
from oic import rndstr
from oic.utils.http_util import Redirect
from oic.oic.message import AuthorizationResponse

client = Client(client_authn_method=CLIENT_AUTHN_METHOD)
args = {}

app = Flask(__name__)
app.secret_key = 'super secret key'
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)

@app.route("/")
def index():
    if not session.get("user"):
        return redirect(url_for("login"))
    return f"Hello {session['user']}"

def setup_oidc():
    global client
    print("HERE")
    op_info = ProviderConfigurationResponse(
        version="2.0", issuer="https://login.microsoftonline.com/3bfb3df7-6b1e-447a-8dfc-cac205f2e79f/v2.0",
        authorization_endpoint="https://login.microsoftonline.com/3bfb3df7-6b1e-447a-8dfc-cac205f2e79f/oauth2/v2.0/authorize",
        token_endpoint="https://login.microsoftonline.com/3bfb3df7-6b1e-447a-8dfc-cac205f2e79f/oauth2/v2.0/token",
        jwks_uri="https://login.microsoftonline.com/3bfb3df7-6b1e-447a-8dfc-cac205f2e79f/discovery/v2.0/keys")

    client.handle_provider_config(op_info, op_info['issuer'])
    info = {"client_id": "e9d39dba-03ce-4e6d-9f70-f31209fc8419", 
    "client_secret": "D408Q~PNFYjKuogTbJcp_ozB-au1hRnF13w4zaBW",
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
        "scope": ["openid", "User.ReadBasic.All"],
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

    print("Got a response !!")
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
    return "OK"

    

if __name__ == "__main__":
    setup_oidc()
    app.run()