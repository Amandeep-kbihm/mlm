# v1 Limit API Documentation

## Limit PPC

* **PATCH** /api/v1/limits/ppc.json `R`

  * Response Success

                {
                  {
                  	"status": true,
                  	"ppc": 1
                  }
                }


 * Response Failed  (if limit PPC > 10):

                {
                  "status": false
                }


## Limit PPV

* **PATCH** /api/v1/limits/ppv.json `R`

  * Response Success

                {
                  {
                  	"status": true,
                  	"ppV": 1
                  }
                }


 * Response Failed  (if limit PPV > 10):

                {
                  "status": false
                }


## Limit PPI

* **PATCH** /api/v1/limits/ppi.json `R`

  * Response Success

                {
                  {
                  	"status": true,
                  	"ppi": 1
                  }
                }

## Check Limit

* **GET** /api/v1/limits.json`R`

  * Response Success

                {
                	"limit": {
                		"id": 2,
                		"user_id": 5,
                		"ppc": 0,
                		"ppv": 0,
                		"ppi": 0,
                		"created_at": "2017-05-02T05:35:30.000Z",
                		"updated_at": "2017-05-02T05:35:30.000Z"
                	}
                }

