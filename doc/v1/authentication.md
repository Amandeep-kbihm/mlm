# v1 Users API Documentation

## Sign-Up

* **POST** /users.json `U`
  * Post data:

              {
                  "user": {
                      "name": "John",      //Required
                      "password": "password"  //Required
                      "email": "j@j.com",     //Required
                      "mobileNumber": "123456789",  //Required
                      "dob": "2016-01-30",   //Required
                      "address": " House No.-XYZ",   //Required
                      "city": "jalandhar ",  //Required
                      "state": "punjab",     //Required
                      "country": "india",    //Required
                      "sponserId": "ZNOF4X"  //Required
                  }
              }
  * Response Success

                {
                  "id": 5,
                  	"name": "John",
                  	"created_at": "2017-05-01T07:43:01.000Z",
                  	"updated_at": "2017-05-01T07:43:02.000Z",
                  	"email": "j@j.com",
                  	"authentication_token": "yXq86GHxKsVhDSxxXx93",
                  	"sponsor_id": "6A309E",
                  	"refer_id": "0550E9",
                  	"chain_count": 0,
                  	"address": " House No.-XYZ",
                  	"city": "jalandhar ",
                  	"state": "punjab",
                  	"dob": "2017-01-01",
                  	"mobile_number": "123456789",
                  	"country": "India",
                  	"real_sponsor_id": "XYZA",
                  	"user_level": 0,
                  	"status": false
                }

  * Response Failed  (if sponserId == null):

                {
                "errors": {
                		"sponsor_id": [
                			"Enter your Refer ID!"
                		]
                }


* Response Failed  (if sponserId == Wrong):

                {
                "errors": {
                		"sponsor_id": [
                			"Sponsor ID not valid!"
                		]
                }

  * Response Failed (if Email Exist):

                  {
                    "errors": {
                    		"email": [
                    			"has already been taken"
                    		]
                    	}
                  }


## Login

* **POST** /users/sign_in.json `U`
  * Post data:

              {
                 "user": {
                     "email": "john@j.com",
                     "password": "password"
                 }
             }

  * Return data:

                {
                    "id": 5,
                    	"authentication_token": "BJHQjgKkQG7NfchJAVLB",
                    	"name": "aman4",
                    	"created_at": "2017-05-01T07:43:01.000Z",
                    	"updated_at": "2017-05-02T05:30:37.000Z",
                    	"email": "john@j.com",
                    	"sponsor_id": "6A309E",
                    	"refer_id": "0550E9",
                    	"chain_count": 0,
                    	"address": "House No.-XYZ",
                    	"city": "jalandhar",
                    	"state": "punjab",
                    	"dob": "2017-01-01",
                    	"mobile_number": "123456789",
                    	"country": "India",
                    	"real_sponsor_id": "XYZA",
                    	"user_level": 0,
                    	"status": true
                }

## Change-Password

* **PATCH** /api/v1/api/v1/users/change-password `R`


              {
                 "user": {
                     "Password": "password",  //Required
                     "password_confirmation": //Required
                     "current_password": "confirmNewPassword"  //Required
                 }
             }

  * Response Success

                {
                  "status":"success", msg: "Password successfully change"
                }

  * Response Failed (if password and confirm password not match ):

                  {
                    "error": "Password and Confirm Password does not match"
                  }

  * Response Failed (All fields are required)

                  {
                    error": "Password, Password Confirm and Current Password fields are required"
                  }

## Profile-Update

* **PATCH** /api/v1/users `R`

                {
                 "user": {
                         "name": "john",   //Required
                         "dob": "2016-01-30",  //Required
                         "address": "House No.-XYZ",  //Required
                         "city": "jalandhar",  //Required
                         "state": "punjab",   //Required
                         "country": "india",   //Required
                         "mobileNumber": "9876543210"    //Required
                 }
             }


  * Response Success:

                {
                  {
                    "status": "Success",
                    "msg": "Update successfully"
                  }
                }
