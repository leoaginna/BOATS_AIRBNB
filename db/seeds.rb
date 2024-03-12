require 'faker'

puts 'Creating a boat...'

10.times do
  puts 'Creating a boat...'
  user = User.new(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  user.save!
  boat = Boat.new(
    name: Faker::Name.female_first_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.decimal(l_digits: 2),
    available: Faker::Boolean.boolean,
    address: Faker::Address.full_address,
    user_id: 1
  )
  boat.save!
end
