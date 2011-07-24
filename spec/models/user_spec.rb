require 'spec_helper'

describe User do
  describe "#test" do
    let(:user) {Factory(:user)}
    
    it "has a full name" do
      user.first_name = "Sam"
      user.last_name = "Beam"

      user.name.should == "Sam Beam"
    end
    
  end
  
end
