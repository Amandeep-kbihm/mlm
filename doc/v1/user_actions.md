# v1 UserActions API Documentation

* **POST** api/v1/user-actions `R`

    * Request 
    
            {
                "user_action": {
                    "category": 1,
                    "user_id": 1,
                    "paid": true
                }
            }
            
    * Response  `Success`
            
            {
            	"status": "success"
            }
            
    * Response `Failed`
            
            {
            	"status": "failed",
            	"errors": {
            		"category": [
            			"can't be blank"
            		],
            		"user_id": [
            			"can't be blank"
            		]
            	}
            }