# Rails 8 + AMS 0.8.3 Compatibility Test

This repository demonstrates that **Active Model Serializers (AMS) 0.8.3** works correctly with **Rails 8.1.1**.

## Environment

- **Rails:** 8.1.1
- **AMS:** 0.8.3
- **Ruby:** 3.3+

## Test Results

### Setup

The test creates:
- **4 users** with active/inactive states
- **2 tasks** in assigned state
- **4 bids** (accepted and pending)

### Single Object Serialization with `embed :ids`

```json
{
  "users": [
    {
      "id": 5,
      "name": "John Doe",
      "email": "john@example.com",
      "badge_name": "Active Member"
    },
    {
      "id": 6,
      "name": "Jane Smith",
      "badge_name": "Inactive"
    }
  ],
  "bids": [
    {
      "id": 5,
      "amount": "120.0",
      "state": "accepted",
      "user_id": 6
    },
    {
      "id": 6,
      "amount": "140.0",
      "state": "pending",
      "user_id": 5
    }
  ],
  "task": {
    "id": 3,
    "title": "Clean my house",
    "description": "Need someone to clean a 3-bedroom house",
    "price": "150.0",
    "state": "assigned",
    "formatted_price": "$150.0",
    "status_message": "This task has been assigned",
    "user_id": 5,
    "bid_ids": [5, 6]
  }
}
```

### Collection Serialization

```json
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
    "bid_ids": [1, 2]
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
    "bid_ids": [3, 4]
  }
]
```

## Validation Results

All AMS 0.8.3 patterns work correctly:

| Test | Status |
|------|--------|
| Root 'task' key exists | ✅ PASS |
| Sideloaded 'users' array exists | ✅ PASS |
| Sideloaded 'bids' array exists | ✅ PASS |
| Task has 'user_id' (embed :ids) | ✅ PASS |
| Task has 'bid_ids' array (embed :ids) | ✅ PASS |
| Custom method 'formatted_price' works | ✅ PASS |
| Conditional 'status_message' included | ✅ PASS |
| Nested bid has 'user_id' | ✅ PASS |

## Features Tested

### ✅ Root Keys
The serializer creates root keys for the main object and sideloaded associations:
- `task` - the main object
- `users` - sideloaded user records
- `bids` - sideloaded bid records

### ✅ Embed IDs Pattern
Using `embed :ids` correctly generates:
- `user_id` on the task (belongs_to association)
- `bid_ids` array on the task (has_many association)
- `user_id` on each bid (nested belongs_to association)

### ✅ Custom Methods
The `formatted_price` method demonstrates custom serializer methods work correctly.

### ✅ Conditional Attributes
The `status_message` attribute uses conditional inclusion and renders properly.

### ✅ Collection Serialization
`ActiveModel::ArraySerializer` correctly serializes arrays of objects without sideloading.

## Running the Tests

```bash
# Setup
bundle install
rails db:create db:migrate

# Run the test script
ruby test_ams.rb
```

## Conclusion

✅ **AMS 0.8.3 WORKS with Rails 8.1.1**

All core AMS 0.8.3 features are functional and compatible with Rails 8.1.1.
