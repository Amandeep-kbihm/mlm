# v1 Manual App API Documentation

* **GET** /api/v1/manual-app `R`

    * Response
    
            {
                "status": "success",
                "manual_apps": [
                    {
                        "id": 1,
                        "name": "example manual",
                        "link": "example.com",
                        "user_attribute": "attribute name",
                        "caps": 0,
                        "active": true,
                        "created_at": "2017-04-05T06:31:54.141Z",
                        "updated_at": "2017-04-05T06:31:54.141Z"
                    }
                ]
            }