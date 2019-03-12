# API Documentation

You can look at all the APIs implemented here at a glance, for more details look under specific version folder.

## Authentication

Application works on token authentication. Every logged in user will be given an authentication token which is to be sent with every request.

Authentication token can be used through:

### Params method

You need the following params with the request to authenticate yourself:

* user_token

`user_token` will have the authentication token provided after log-in.

### Headers method

You need to send the following headers in the request to authenticate yourself:

* Authorization

`Authorization` will have the authentication token including Bearer provided after log-in.
e.g:
* Key: Authorization
* Value: Bearer PUT_TOKEN_HERE

## Restricted and unrestricted routes

Unrestricted routes does not require the user to be signed-in but restricted routes are only for logged in users.

All restricted routes from here on will be marked as `R` for restricted and `U` for unrestricted.

Note: The v1 API will be namespaced 'v1' and all the URLs are to prepend 'v1' except the users routes.


### [Users](doc/v1/users.md)

* Verify Sponsor
    * **POST** /users.json `U` `{ "user": { "name": "jhon",	"email": "first1@gmail.com", "mobile_number": "123456789", "sponsor_id": "123", "country": "India",	"state": "state", "city": "city", "address": "address", "dob": "2017-1-01", "password": "12345678" }`

* Sign-Up
    * **POST** /users.json `U` `{ "user": { "name": "jhon",	"email": "first1@gmail.com", "mobile_number": "123456789", "sponsor_id": "123", "country": "India",	"state": "state", "city": "city", "address": "address", "dob": "2017-1-01", "password": "12345678" }`

* Login
    * **POST** /users/sign_in.json `U` `  {"user": {"email": "example@gmail.com", "password": "password" } }`

* Edit-Password
    * **PATCH** /v1/user/change-password `R` `  {"user": { "password": "new password", "password_confirmation": "new password confirm",	"current_password": "old password" } }`

* Profile-Update
    * **PATCH** /v1/users/update `R` `  { "user": { "name":"SuperAdmin", "dob":"2016-1-1", "address": "advcd", "country": "India", "state": "punjab", "city": "adert"} }`

### [UserRefer](doc/v1/checkLevel.md)

* Level
    * **GET** /v1/level `R` {"user_refer": {"level":1}}

### [Limit](doc/v1/limit.md)
* Check Limit
    * **GET** /v1/limits.json 'R'

### [Bank Accounts](v1/bankAccounts.md)

### [Transfers](v1/bankTransfer.md)

### [Wallet](v1/wallet.md)

### [Settings](v1/settings.md)
