
CLIENT_ID = "488379779056-vd7hrljjgb4lhb0ar1udibe6esfurh0g.apps.googleusercontent.com"

CLIENT_SECRET = "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"

REDIRECT_PATH = "/getAToken"  # Used for forming an absolute URL to your redirect URI.
                              # The absolute URL must match the redirect URI you set
                              # in the app's registration in the Azure portal.

REDIRECT_URI = f"http://localhost:5000{REDIRECT_PATH}"

SCOPE = "openid profile email https://www.googleapis.com/auth/photoslibrary"