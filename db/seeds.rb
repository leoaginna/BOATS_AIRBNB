require 'faker'
require 'cloudinary'
require 'open-uri'

10.times do
  p "creating 1 stuff..."
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
    available_from: Faker::Date.between(from: 2.days.ago, to: 2.days.from_now),
    available_until: Faker::Date.between(from: 2.days.from_now, to: 1.month.from_now),
    user_id: user.id
  )

  # Upload Cloudinary images

  boat.save!

  3.times do
    image_url = Faker::LoremFlickr.image(size: "500x300", search_terms: ['boat'])
    io = URI.open(image_url)

    boat.photos.attach(io:, filename: "boat_#{Time.now.to_i}.jpg", content_type: 'image/jpg')
  end

  10.times do
    rental = Rental.new(
      start_time: Faker::Date.between(from: 2.days.ago, to: 2.days.from_now),
      end_time: Faker::Date.between(from: 2.days.from_now, to: 1.month.from_now),
      user_id: user.id,
      boat_id: boat.id
    )
    rental.save!
  end
end
