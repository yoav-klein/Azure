# App Registration
---

The Microsoft identity platform allows you to use it as an Identity provider, and to delegate
to it authentication and authorization tasks for your application.

This is done by registering your application in the `App registration` section in Azure Active Directory.

## The flow
Recall the _Code Authorization flow_ defined by the OAuth 2.0 specification:
1. The user (using his user-agent, most commonly browser) browses to the _client application_
2. The client application redirects the user to the _Authorization Endpoint_ in the _authorization server_. The client
application specifies which _scopes_ - permissions - it wants. 
3. The user then interacts with the authorization server - in our case Microsoft identity platform. The user authenticates
itself and grants permissions to the client application to access his resources.
4. The user-agent is redirected back to the client application, using a _redirect URI_ specified by the application. The user-agent
is equiped with an _authorization code_, 
5. The client application uses the authorization code to request for an access token and a ID token from the _Token Endpoint_ in the authorization server.
6. The authorization server sends the access token and ID token as JWTs.
7. The client can ask for resources from the _resource server_ on behalf of the user using the access token, and can identify
the user using the ID token.

## Implementations
So what we have here are 3 implementations of a client application. 

### ms-identity-python-webapp

This sample Python application uses the MSAL (Microsoft Authentication Library) - which is the recommended way by Microsoft.
The MSAL library implements the client-side of an OAuth 2.0 and OpenID Connect flows when the Identity provider is Microsoft identity platform.

This sample application signs in a user using his Microsoft account (be it a personal or organizational account), acquires an access token from the Microsoft identity platform on his behalf, and uses it to do a Microsoft Graph API call which simply lists all the users in its organization.

Basically I took the sample application as is, just added some `Debug` prints to see the contents of tokens etc.

### python-oic
This sample application uses the generic Python OpenID Connect Python library. Basically this can be used with other Identity providers, such as Google, Facebook, etc.


### my-impl
This sample application doesn't use any pre-made library. It uses simple `request` methods to interact with the Microsoft identity platform.
All the information about the structure of the requests and all that is taken from the Microsoft identity platform reference:

https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow
https://learn.microsoft.com/en-us/azure/active-directory/develop/id-tokens

## What is does
Basically these sample applications just implement the above-described flow, and by which acquire an access token with which
the client application can issue requests to resources on-behalf of the user.

In this case, we allow the user to issue a request to the Microsoft Graph API, to read basic information about all the users
in the organization. This is done by sending a request to the `/v1.0/users` endpoint of the Graph API.
For this, we need to request the user to grant us the `User.ReadBasic.All` scope.


## Usage
### Install prerequisites
In each sample application directory there is a `requirements.txt` that you need to install.

### Register your application
First, you must register an application with the Microsoft identity platform. You need to set the Redirect URI
and a client secret.

For the _Redirect URI_ you must specify: `http://localhost:5000/getAToken`

So basically the information you need to come up with sums up to:
1. Client ID
2. Client secret
3. Tenant ID
4. Redirect URI

### Configure the application
You need to set these values in the `app_config.py` file, which is present in each of the sample applications.

Also, you have the `SCOPES` configuration bit in the app_config files, with which you can set your application
to ask for certain scopes.

### Run
```
$ py app.py
```

And browse to `http://localhost:5000`


## Google

We've also added here a sample application that does OpenID Connect authentication with Google. 
It's very similar to the `my-impl` application.

Refer to https://developers.google.com/identity/openid-connect/openid-connect
