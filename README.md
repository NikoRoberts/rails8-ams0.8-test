Rails 8.1.1
AMS 0.8.3
==================================================

Creating test data...
Created: 4 users, 2 tasks, 4 bids

==================================================
Testing TaskSerializer with embed :ids...
==================================================

Serialized JSON:
{
  "users": [
    {
      "id": 3,
      "name": "John Doe",
      "email": "john@example.com",
      "badge_name": "Active Member"
    },
    {
      "id": 4,
      "name": "Jane Smith",
      "badge_name": "Inactive"
    }
  ],
  "bids": [
    {
      "id": 3,
      "amount": "120.0",
      "state": "accepted",
      "user_id": 4
    },
    {
      "id": 4,
      "amount": "140.0",
      "state": "pending",
      "user_id": 3
    }
  ],
  "task": {
    "id": 2,
    "title": "Clean my house",
    "description": "Need someone to clean a 3-bedroom house",
    "price": "150.0",
    "state": "assigned",
    "formatted_price": "$150.0",
    "status_message": "This task has been assigned",
    "user_id": 3,
    "bid_ids": [
      3,
      4
    ]
  }
}

==================================================
Validating AMS 0.8.3 Patterns:
==================================================
✅ PASS: Root 'task' key exists
✅ PASS: Sideloaded 'users' array exists
✅ PASS: Sideloaded 'bids' array exists
✅ PASS: Task has 'user_id' (embed :ids)
✅ PASS: Task has 'bid_ids' array (embed :ids)
✅ PASS: Custom method 'formatted_price' works
✅ PASS: Conditional 'status_message' included
✅ PASS: Nested bid has 'user_id'

==================================================
Testing Collection Serialization...
==================================================

Collection JSON:
[
  {
    "id": 1,
    "title": "Clean my house",
    "description": "Need someone to clean a 3-bedroom house",
    "price": "150.0",
    "state": "assigned",
    "formatted_price": "$150.0",
    "status_message": "This task has been assigned",
    "user_id": 1,
    "bid_ids": [
      1,
      2
    ]
  },
  {
    "id": 2,
    "title": "Clean my house",
    "description": "Need someone to clean a 3-bedroom house",
    "price": "150.0",
    "state": "assigned",
    "formatted_price": "$150.0",
    "status_message": "This task has been assigned",
    "user_id": 3,
    "bid_ids": [
      3,
      4
    ]
  }
]

==================================================
RESULT: AMS 0.8.3 ✅ WORKS with Rails 8.1.1
==================================================
