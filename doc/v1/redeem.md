# v1 Redeem API Documentation

## Paytem Payment Transaction

* **POST** /api/v1/payment_transactions/paytm `R`
  * Post data:

              {
                  "payment_transactions":{
                  		"amount": "200",   //Required
                  		"mobile_number": "14586258",  //Required
                  		"name": "XYZ",   //Required
                  		"pan_number": "123456789"   //Required
                  	}
              }

  * Response Success

                {
                  "status": "Success",
                  	"msg": "Wait for approval"
                }

  * Response Failed  (if Wallet Balance < 700):

                {
                "status": "failure",
                  	"msg": "Insufficient amount"
                }



## Bank Payment Transaction

* **POST** /api/v1/payment_transactions/bank `R`
  * Post data:

              {
                  "payment_transactions":{
                  		"amount": 100,
                  		"mobile_number": "7777777",
                  		"name": "XYZ",
                  		"pan_number": "123456789",
                  		"bank_account": "ABCD",
                  		"ifsc":"12345",
                  		"state": "Punjab",
                  		"address":"Khanna"
                  	}
              }

  * Response Success

                {
                  "status": "Success",
                  	"msg": "Wait for approval"
                }

  * Response Failed  (if Wallet Balance < 1000):

                {
                "status": "failure",
                  	"msg": "Insufficient amount"
                }





## Mobile Recharge Transaction

* **POST** /api/v1/payment_transactions/recharge `R`
  * Post data:

              {
                  "mobile_recharge":{
                  		"amount": 800,  //Required
                  		"number": "77777777", //Required
                  		"operator":"6" //Required
                  	}
              }

  * Response Success

                {
                  "status": "Success",
                  	"msg": "You can only recharge once in a week"
                }

  * Response Failed  (if Wallet Balance < 300):

                {
                "status": "failure",
                  	"msg": "Insufficient amount"
                }

* Response Failed  (if Wallet Balance More than 300, but recharge same week ):

                {
                "status": "failure",
                  	"msg": "you next recharge will be on DATE"
                }

