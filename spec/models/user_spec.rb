require 'spec_helper'

module UserSpecHelper
  def valid_user_attributes
    { :email => 'jacky_boy@bloggs.com',
      :first_name => 'Jacky',
      :last_name => 'Boy',
      :password => 'abcdefg',
       }
  end
end

describe User do
  include UserSpecHelper
  describe "validations" do
    before(:each) do
      @user = User.new
    end
    
    it "should be invalid without email" do
      @user.attributes = valid_user_attributes.except(:email)
      @user.valid?.should == false

      @user.should have(1).error_on(:email)
      @user.email = 'someusername@email.com'
      @user.valid?.should == true
    end
    
    it "should not allow invalid emails" do
      @user.attributes = valid_user_attributes.except(:email)
      @user.email = "not valid@gmail.com"
      @user.should have(1).error_on(:email)
      @user.email = "valid@gmail.com"
      @user.should have(0).error_on(:email)
      @user.email = "invalidgmail.com"
      @user.should have(1).error_on(:email)
      @user.email = "valid@gmail.com"
      @user.should have(0).error_on(:email)
    end
    
    it "should not allow missing name" do
      @user.attributes = valid_user_attributes.except(:first_name,:last_name)
      @user.valid?.should == false
      @user.should have(1).error_on(:first_name)
      @user.first_name = "Alister"
      @user.valid?.should == false
      @user.should have(1).error_on(:last_name)
      @user.last_name = "Smith" 
      @user.valid?.should == true
    end
    
    it "should require password" do
      @user.attributes = valid_user_attributes.except(:password)
      @user.valid?.should == false
      @user.should have(1).error_on(:password)
      @user.password = "123asdf"
      @user.valid?.should == true
    end
  end
  
  describe "#name" do
    let(:user) {Factory(:user)}
    
    it "has a full name" do
      user.first_name = "Sam"
      user.last_name = "Beam"

      user.name.should == "Sam Beam"
    end    
  end
  
  describe "#owns_posts?" do
    let(:user) {Factory(:user)}
    let(:post) {Factory(:post)}
    
    it "owns posts" do
      user.owns_posts?.should == false
      user.posts << post
      user.owns_posts?.should == true
    end
  end
  
  describe "#owns_post?" do
    let(:user) {Factory(:user)}
    let(:owned_post) {Factory(:post)}
    let(:unowned_post) {Factory(:post)}
    
    it "owns posts" do
      user.owns_post?(owned_post).should == false
      user.posts << owned_post
      user.owns_post?(owned_post).should == true
      user.owns_post?(unowned_post).should == false
    end
  end
  
  
end
