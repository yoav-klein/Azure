# App Registration
---

The Microsoft identity platform allows you to use it as an Identity provider, and to delegate
to it authentication and authorization tasks for your application.

This is done by registering your application in the `App registration` section in Azure Active Directory.

In here, we have the `ms-identity-python-webapp`, which is a sample Python application
which acts as a client application in the OAuth2.0 flow. This is taken from the Microsoft documenation.

This sample application signs in a user using his Microsoft account (be it a personal or organizational account), acquires an access token from the Microsoft identity platform on his behalf, and uses it to do a Microsoft Graph API call which simply lists all the users in its organization.

Basically I took the sample application as is, just added some `Debug` prints to see the contents of tokens etc.

