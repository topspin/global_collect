require File.join(File.dirname(__FILE__), '..', 'spec_helper')
class TestRequestModel < GlobalCollect::RequestModels::Base
  def fields; {"PLACEHOLDER" => ["AN12", "R"]}; end
end

describe "the base model" do
  it "should validate cleanly on good attributes" do
    base = TestRequestModel.new("PLACEHOLDER" => "FOOBAR")
    base.validate.should be_true
  end
  
  it "should not validate on empty attributes" do
    base = TestRequestModel.new({})
    base.validate.should be_false
  end
  
  it "should not validate on bad attributes" do
    base = TestRequestModel.new("PLACEHOLDER" => "FOOBARFOOBARFOOBAR")
    base.validate.should be_false
  end
end