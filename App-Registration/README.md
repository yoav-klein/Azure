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
