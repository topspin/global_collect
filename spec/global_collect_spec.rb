require 'spec_helper'

describe 'the GC module' do
  it "should default to version 1.0" do
    GlobalCollect.api_version.should == "1.0"
  end
  it "should error on an invalid environment" do
    GlobalCollect.environment = :foo
    lambda { GlobalCollect.merchant_link_client }.should raise_error(ArgumentError)
  end
  it "should error on an invalid auth scheme" do
    GlobalCollect.authentication_scheme = :foo
    lambda { GlobalCollect.merchant_link_client }.should raise_error(ArgumentError)
  end
  it "should return a merchant link client" do
    GlobalCollect.authentication_scheme = :ip_check
    GlobalCollect.environment = :test
    GlobalCollect.merchant_link_client.should_not be_nil
  end
end