require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe "the DO_PAYMENT recurring payment model" do
  it "should not allow blank EFFORT_ID" do
    GlobalCollect::RequestModels::DoPayment::RecurringPayment.new({
      "MERCHANTREFERENCE" => "aasfd",
      "ORDERID"           => "123",
      "PAYMENTPRODUCTID"  => "1",
      "AMOUNT"            => "123",
      "CURRENCYCODE"      => "USD"
    }).validate.should be_false
  end
end