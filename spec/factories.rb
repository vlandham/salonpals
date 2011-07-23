Factory.define :user do |f|
  f.sequence(:email) {|n| "user#{n}@example.com"}
  f.first_name "John"
  f.last_name "Dark"
  f.zip_code "64110"
  f.password "secret"
  f.language LANGUAGES[:en]
end