Factory.define :user do |f|
  f.sequence(:email) {|n| "user#{n}@example.com"}
  f.first_name "John"
  f.last_name "Dark"
  f.zip_code "64110"
  f.password "secret"
  f.language LANGUAGES[:en]
end

Factory.define :post do |f|
  f.title "New Salon Job"
  f.description "<h1>New Description</h1>"
  f.address_street "12345 College Blvd"
  f.address_city "Overland Park"
  f.address_state "KS"
  f.address_zip "66210"
  f.business_name "Happy Salon"
end