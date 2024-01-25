# Google
---

This demo application is exercising using OAuth and OpenID Connect with Google.

Like in Microsoft, we've created an Application registration in Google, which represents our application.
using the Client ID we've received, we can now ask for consent on behalf of the user to access his resources,
and also use Google as the identity provider.

You can see the list of scopes that Google supports here:
https://developers.google.com/identity/protocols/oauth2/scopes

In this demo, we ask for the scopes: `openid`, `profile`, `email` and `https://www.googleapis.com/auth/drive.photos.readonly` - which allows us to access Google photos of the user.

If you run this application you'll see in the console output the tokens you receive from 
the Authorization endpoint of the Authorization server. 

The ID token you receive is a JWT, and you can see its contents using a JWT decoder.

The Access token you receive is opaque, and Google allows you to decode it by pasting it to the following curl request:
```
curl "https://oauth2.googleapis.com/tokeninfo?access_token=ACCESS_TOKEN"
```

## TODO
Might be cool to actually access the Google Photos API and pull some photos from there...