require 'spec_helper'

describe "UserSignups" do
  it "does not sign up new user with invalid data" do
    user = Factory(:user)
    visit new_user_registration_path
    fill_in "Email", :with => user.email
    click_on "Sign Up"
    current_path.should include(new_user_registration_path)
  end
end
