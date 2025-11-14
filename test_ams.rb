#!/usr/bin/env ruby
require_relative 'config/environment'

puts "Rails #{Rails.version}"
ams_version = Gem.loaded_specs['active_model_serializers']&.version || 'unknown'
puts "AMS #{ams_version}"
puts "=" * 50

# Create test data
puts "\nCreating test data..."
user1 = User.create!(name: "John Doe", email: "john@example.com", active: true)
user2 = User.create!(name: "Jane Smith", email: "jane@example.com", active: false)

task = Task.create!(
  title: "Clean my house",
  description: "Need someone to clean a 3-bedroom house",
  price: 150.00,
  state: "assigned",
  user: user1
)

bid1 = Bid.create!(amount: 120.00, state: "accepted", task: task, user: user2)
bid2 = Bid.create!(amount: 140.00, state: "pending", task: task, user: user1)

puts "Created: #{User.count} users, #{Task.count} tasks, #{Bid.count} bids"

# Test serialization
puts "\n" + "=" * 50
puts "Testing TaskSerializer with embed :ids..."
puts "=" * 50

serializer = TaskSerializer.new(task)
json_output = serializer.as_json

puts "\nSerialized JSON:"
puts JSON.pretty_generate(json_output)

# Check for expected AMS patterns
puts "\n" + "=" * 50
puts "Validating AMS 0.8.3 Patterns:"
puts "=" * 50

validations = {
  "Root 'task' key exists" => json_output.key?(:task),
  "Sideloaded 'users' array exists" => json_output.key?(:users),
  "Sideloaded 'bids' array exists" => json_output.key?(:bids),
  "Task has 'user_id' (embed :ids)" => json_output[:task]&.key?(:user_id),
  "Task has 'bid_ids' array (embed :ids)" => json_output[:task]&.key?(:bid_ids),
  "Custom method 'formatted_price' works" => json_output[:task]&.key?(:formatted_price),
  "Conditional 'status_message' included" => json_output[:task]&.key?(:status_message),
  "Nested bid has 'user_id'" => json_output[:bids]&.first&.key?(:user_id),
}

validations.each do |test, result|
  status = result ? "✅ PASS" : "❌ FAIL"
  puts "#{status}: #{test}"
end

# Test collection serialization
puts "\n" + "=" * 50
puts "Testing Collection Serialization..."
puts "=" * 50

tasks = Task.includes(:user, :bids => :user).all
collection_json = ActiveModel::ArraySerializer.new(
  tasks,
  each_serializer: TaskSerializer
).as_json

puts "\nCollection JSON:"
puts JSON.pretty_generate(collection_json)

puts "\n" + "=" * 50
puts "RESULT: AMS 0.8.3 #{validations.values.all? ? '✅ WORKS' : '❌ HAS ISSUES'} with Rails #{Rails.version}"
puts "=" * 50
