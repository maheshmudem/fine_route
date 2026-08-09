
API :
Request URL : https://finroute01.pythonanywhere.com/api/v1/app/calculator/
Request Method : POST


Payload :
{"amount":50000,"interest_rate":24,"interest_type":"flat_percentage","frequency":"daily","duration":30}



{
    "success": true,
    "message": "Success.",
    "data": {
        "principal_amount": 50000.0,
        "interest_rate": 24.0,
        "interest_type": "flat_percentage",
        "total_interest": 12000.0,
        "total_payable": 62000.0,
        "installment_amount": 2066.67,
        "frequency": "daily",
        "duration": 30,
        "schedule": [
            {
                "installment_number": 1,
                "due_date": "2026-08-10",
                "installment_amount": 2066.67,
                "remaining_balance": 59933.33
            },
            {
                "installment_number": 2,
                "due_date": "2026-08-11",
                "installment_amount": 2066.67,
                "remaining_balance": 57866.66
            },
            {
                "installment_number": 3,
                "due_date": "2026-08-12",
                "installment_amount": 2066.67,
                "remaining_balance": 55799.99
            },
            {
                "installment_number": 4,
                "due_date": "2026-08-13",
                "installment_amount": 2066.67,
                "remaining_balance": 53733.32
            },
            {
                "installment_number": 5,
                "due_date": "2026-08-14",
                "installment_amount": 2066.67,
                "remaining_balance": 51666.65
            },
            {
                "installment_number": 6,
                "due_date": "2026-08-15",
                "installment_amount": 2066.67,
                "remaining_balance": 49599.98
            },
            {
                "installment_number": 7,
                "due_date": "2026-08-16",
                "installment_amount": 2066.67,
                "remaining_balance": 47533.31
            },
            {
                "installment_number": 8,
                "due_date": "2026-08-17",
                "installment_amount": 2066.67,
                "remaining_balance": 45466.64
            },
            {
                "installment_number": 9,
                "due_date": "2026-08-18",
                "installment_amount": 2066.67,
                "remaining_balance": 43399.97
            },
            {
                "installment_number": 10,
                "due_date": "2026-08-19",
                "installment_amount": 2066.67,
                "remaining_balance": 41333.3
            },
            {
                "installment_number": 11,
                "due_date": "2026-08-20",
                "installment_amount": 2066.67,
                "remaining_balance": 39266.63
            },
            {
                "installment_number": 12,
                "due_date": "2026-08-21",
                "installment_amount": 2066.67,
                "remaining_balance": 37199.96
            },
            {
                "installment_number": 13,
                "due_date": "2026-08-22",
                "installment_amount": 2066.67,
                "remaining_balance": 35133.29
            },
            {
                "installment_number": 14,
                "due_date": "2026-08-23",
                "installment_amount": 2066.67,
                "remaining_balance": 33066.62
            },
            {
                "installment_number": 15,
                "due_date": "2026-08-24",
                "installment_amount": 2066.67,
                "remaining_balance": 30999.95
            },
            {
                "installment_number": 16,
                "due_date": "2026-08-25",
                "installment_amount": 2066.67,
                "remaining_balance": 28933.28
            },
            {
                "installment_number": 17,
                "due_date": "2026-08-26",
                "installment_amount": 2066.67,
                "remaining_balance": 26866.61
            },
            {
                "installment_number": 18,
                "due_date": "2026-08-27",
                "installment_amount": 2066.67,
                "remaining_balance": 24799.94
            },
            {
                "installment_number": 19,
                "due_date": "2026-08-28",
                "installment_amount": 2066.67,
                "remaining_balance": 22733.27
            },
            {
                "installment_number": 20,
                "due_date": "2026-08-29",
                "installment_amount": 2066.67,
                "remaining_balance": 20666.6
            },
            {
                "installment_number": 21,
                "due_date": "2026-08-30",
                "installment_amount": 2066.67,
                "remaining_balance": 18599.93
            },
            {
                "installment_number": 22,
                "due_date": "2026-08-31",
                "installment_amount": 2066.67,
                "remaining_balance": 16533.26
            },
            {
                "installment_number": 23,
                "due_date": "2026-09-01",
                "installment_amount": 2066.67,
                "remaining_balance": 14466.59
            },
            {
                "installment_number": 24,
                "due_date": "2026-09-02",
                "installment_amount": 2066.67,
                "remaining_balance": 12399.92
            },
            {
                "installment_number": 25,
                "due_date": "2026-09-03",
                "installment_amount": 2066.67,
                "remaining_balance": 10333.25
            },
            {
                "installment_number": 26,
                "due_date": "2026-09-04",
                "installment_amount": 2066.67,
                "remaining_balance": 8266.58
            },
            {
                "installment_number": 27,
                "due_date": "2026-09-05",
                "installment_amount": 2066.67,
                "remaining_balance": 6199.91
            },
            {
                "installment_number": 28,
                "due_date": "2026-09-06",
                "installment_amount": 2066.67,
                "remaining_balance": 4133.24
            },
            {
                "installment_number": 29,
                "due_date": "2026-09-07",
                "installment_amount": 2066.67,
                "remaining_balance": 2066.57
            },
            {
                "installment_number": 30,
                "due_date": "2026-09-08",
                "installment_amount": 2066.57,
                "remaining_balance": 0.0
            }
        ]
    },
    "errors": null
}