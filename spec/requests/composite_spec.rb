require File.join(File.dirname(__FILE__), '..', 'spec_helper')

class TestModel
  attr_reader :validate
  def initialize(valid);@validate=valid;end
  def suggested_response_mixins;[];end
  def errors; {}; end
end
class TestModelBuilder
  def initialize(model);end
  def build(node)
    node.tag!("FOO_NODE")
  end
end

describe "the composite request" do
  it "should build properly from model-builder pairs" do
    pair = [TestModel.new(true), TestModelBuilder]
    request = GlobalCollect::Requests::Composite.new("FOO_ACTION", [pair])
    xml = request.to_xml
    xml.should have_xpath("/XML/REQUEST/PARAMS/FOO_NODE")
  end
  
  it "should fail on an invalid model" do
    pair = [TestModel.new(false), TestModelBuilder]
    request = GlobalCollect::Requests::Composite.new("FOO_ACTION", [pair])
    lambda { request.to_xml }.should raise_error(Exception, /Invalid model/)
  end
end