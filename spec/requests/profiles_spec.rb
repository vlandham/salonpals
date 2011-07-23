require 'spec_helper'

describe "Profiles" do

  describe "GET /profiles" do
    it "works! (now write some real specs)" do
      user = Factory(:user)
      visit new_user_session_path
      fill_in "Email", :with => user.email      
    end
  end
end
