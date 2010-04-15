require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "the base response" do
  describe "on a successful response" do
    before(:each) do
      @hash = Crack::XML.parse(load_canned_response('successful_iowp_response.xml'))
    end

    it "should identify success" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.success?.should == true
    end

    it "should identify meta fields correctly" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.request_id.should == "3000852"
      response.response_datetime.should == Time.parse("Fri Apr 09 02:03:09 -0700 2010")
    end
    
    it "should give you the raw hash to access" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.hash.should_not be_blank
    end
    
    it "should not provide the errors" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.errors.should be_nil
    end
  end
  
  describe "on an unsuccessful response" do
    before(:each) do
      @hash = Crack::XML.parse(load_canned_response('unsuccessful_iowp_response.xml'))
    end

    it "should identify success" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.success?.should == false
    end

    it "should identify meta fields correctly" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.request_id.should == "3000854"
      response.response_datetime.should == Time.parse("Fri Apr 09 02:03:28 -0700 2010")
    end
    
    it "should provide the errors" do
      response = GlobalCollect::Responses::Base.new(@hash)
      response.errors.should be_a(Array)
      response.errors.first.code.should_not be_blank
      response.errors.first.message.should_not be_blank
    end
  end
end