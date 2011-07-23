require 'spec_helper'

describe "UserSignups" do
  it "signs up new user with valid data" do
    user = Factory(:user)
    visit new_user_registration_path
    fill_in "Email", :with => user.email
    click_button "Sign Up"
    current_path.should eq(root_path)
  end
end
