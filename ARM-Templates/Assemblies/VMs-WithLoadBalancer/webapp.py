import socket
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
        return f"Hello from {socket.gethostname()}"

app.run(host='0.0.0.0', port=80)
