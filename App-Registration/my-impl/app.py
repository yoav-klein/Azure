
@app.route("/")
def index():
    # if not logged in: redirect to login
    # render_template("index.html", user=user)

@app.route("/login")
def login():
    # send authorization request to authorization endpoint
    # redirect to /authorized

@app.route("/logout")
def logout():

@app.route("/authorized")
def authorized():
    # take the request parmaters - authorization code and status
    # contact token endpoint to request for a ID token and access token
    # redirect to index


def main():
    

if __name__ == "__main__":
    main()