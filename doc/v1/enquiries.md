# v1 Enquiry API Documentation

## Submit enquiry

* **POST** `/enquireis` `U`

     * Request
        
            {
                "enquiry": {
                    "subject": "abc",
                    "enquiry": "fdfd"
                }
            }
            
                
     
     * Response `Failed`
            
                {
                    "status": "failed",
                    "errors": {
                        "enquiry": [
                            "can't be blank"
                        ]
                    }
                }
                
     * Response `success`
                
                {
                	"status": "success",
                	"message": "Your queries sent submit successfully"
                }