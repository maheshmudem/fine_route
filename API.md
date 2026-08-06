Log in :

API :
Request URL :
https://finroute01.pythonanywhere.com/api/v1/auth/login/

Request Method :
POST

PayLoad :
{"identifier":"+919441778297","password":"Test@2580"}

Response : 
{
    "success": true,
    "message": "Login successful.",
    "data": {
        "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzg2MDM1MTI1LCJpYXQiOjE3ODYwMzMzMjYsImp0aSI6IjY1MTU4ODBiYzdhMjRiOWU4NWEyZmJmMzdhZTVjNWMzIiwidXNlcl9pZCI6IjIiLCJhY2NvdW50X3R5cGUiOiJndWVzdCJ9.3Ki89EiITS-ctIeEZiQ0Q7RJ3yWQBsnPpMHQRpWkfgY",
        "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4NjYzODEyNSwiaWF0IjoxNzg2MDMzMzI1LCJqdGkiOiIwY2FlYzMyNjA1OTU0ZjViYjNlNTk2NjUzNDc1YjdhZCIsInVzZXJfaWQiOiIyIiwiYWNjb3VudF90eXBlIjoiZ3Vlc3QifQ.29qzsUmB9981YRXW_tFkB13YypeyUbFkqSvPiFFbRaY",
        "user": {
            "public_id": "5ba61e26-c761-45ad-96ac-6ecc8f453230",
            "full_name": "Manusha Lakshmi Penke",
            "mobile_number": "+919441778297",
            "account_type": "guest",
            "is_mobile_verified": true
        },
        "workspace": {
            "public_id": "fdd89f4d-830b-4dc7-8e52-f2209060c552",
            "name": "vinay test Finance",
            "plan": "free",
            "status": "active"
        }
    },
    "errors": null
}
