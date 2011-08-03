require 'spec_helper'

module PostSpecHelper
  def valid_post_attributes
    {
      :title => "New Salon Job",
      :description => "<h1>New Description</h1>",
      :address_street => "12345 College Blvd",
      :address_city => "Overland Park",
      :address_state => "KS",
      :address_zip => "66210",
      :business_name => "Happy Salon",
      :kind => "job"
    }
  end
end


describe Post do
  include PostSpecHelper
  describe "validations" do
    before(:each) do
      @post = Post.new
    end
    
    it "should be invalid without title" do
      @post.attributes = valid_post_attributes.except(:title)
      @post.valid?.should == false
      @post.should have(1).error_on(:title)
      @post.title = "A title"
      @post.valid?.should == true
    end
    
    it "should require description" do
      @post.attributes = valid_post_attributes.except(:description)
      @post.valid?.should == false
      @post.should have(1).error_on(:description)
      @post.description = "A description"
      @post.valid?.should == true
    end
    
    it "should require address_street" do
      @post.attributes = valid_post_attributes.except(:address_street)
      @post.valid?.should == false
      @post.should have(1).error_on(:address_street)
      @post.address_street = "343 Main"
      @post.valid?.should == true
    end
    
    it "should require address_city" do
      @post.attributes = valid_post_attributes.except(:address_city)
      @post.valid?.should == false
      @post.should have(1).error_on(:address_city)
      @post.address_city = "Houston"
      @post.valid?.should == true
    end
    
    it "should require address_state" do
      @post.attributes = valid_post_attributes.except(:address_state)
      @post.valid?.should == false
      @post.should have(1).error_on(:address_state)
      @post.address_state = "TX"
      @post.valid?.should == true
    end
    
    it "should require address_zip" do
      @post.attributes = valid_post_attributes.except(:address_zip)
      @post.valid?.should == false
      @post.should have(1).error_on(:address_zip)
      @post.address_zip = "TX"
      @post.valid?.should == true
    end
    it "should require business_name" do
      @post.attributes = valid_post_attributes.except(:business_name)
      @post.valid?.should == false
      @post.should have(1).error_on(:business_name)
      @post.business_name = "Roadhouse Nails"
      @post.valid?.should == true
    end
  end

  
  describe "price" do
    let(:post) {Factory(:post)}
    
    it "should cost 30 bucks" do
      post.price.should == 30.0
    end  
  end
  
  describe "address_changed?" do
    let(:post) {Factory(:post)}
    
    before(:each) do
      post.address_changed?.should == false
    end
    
    it "change if zip changes" do
      post.address_zip = "65656"
      post.address_changed?.should == true
    end
    
    it "change if street changes" do
      post.address_street = "1234 main"
      post.address_changed?.should == true
    end  

    it "should not change if description changes" do
      post.description = "new dexpc"
      post.address_changed?.should == false
    end  
    
  end
  

end
