require 'faker'

FactoryGirl.define do
  
  sequence :title do |n|
    "#{n} Yo-Yo"
  end

  sequence :email do |n|
    "andyglass#{n}@livingsocial.com"
  end

  sequence :username do |n|
    "#{n}andyglass"
  end

  factory :order do
    id 1
    name "Andy"
    email "andy@andy.com"
    address "123 Andy Street, Andy, AK 200001"
    cc_number 1234567890
    cc_expiry "12/12"
    user
  end

  factory :line_item do
    cart
  end

  factory :cart do
  end

  factory :order_item do
    order_id 1
  end

  factory :product do
    # id 1
    title "yo-yo"
    description "A fun and cheap toy!"
    price 2.45
    photo "http://photo.jpg"
  end

  factory :category do
    name "robots"
    id 1
  end

  factory :user do |f|
    f.full_name { "#{Faker::Name.first_name} #{Faker::Name.last_name}"}
    f.password "password"
    f.email { "#{Faker::Name.first_name}@#{Faker::Name.last_name}.com"}
  end

  factory :category_assignment do
    id 1
    product
    category
  end

end