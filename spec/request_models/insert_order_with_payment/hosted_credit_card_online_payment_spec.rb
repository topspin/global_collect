require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe "the hosted credit card online payment model" do
  it "should always set HOSTEDINDICATOR to '1'" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US"
    )
    model["HOSTEDINDICATOR"].should == "1"
  end
  
  it "should always set HOSTEDINDICATOR to '1'" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US",
      "HOSTEDINDICATOR"  => "2"
    )
    model["HOSTEDINDICATOR"].should == "1"
  end
  
  it "should always set HOSTEDINDICATOR to '1'" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment.new(
      "PAYMENTPRODUCTID" => "1",
      "AMOUNT"           => "1",
      "CURRENCYCODE"     => "USD",
      "LANGUAGECODE"     => "en",
      "COUNTRYCODE"      => "US",
      "HOSTEDINDICATOR"  => "212312"
    )
    model["HOSTEDINDICATOR"].should == "1"
  end
end