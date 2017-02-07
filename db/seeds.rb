# frozen_string_literal: true
puts "  - Loading..."

## Administrators
puts "  - Administrators"
Administrator.create({
  first_name: 'Canvas',
  last_name: 'Admin',
  email: 'admin@canvas.is',
  password: 'password',
  confirmed_at: Time.zone.now
})
