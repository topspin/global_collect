require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder do
  it "should set ORDERTYPE to '4' when not provided" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["ORDERTYPE"].should == "4"
  end

  it "should set ORDERTYPE to '4' when it is set to something invalid" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "ORDERTYPE"    => "1123",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["ORDERTYPE"].should == "4"
  end

  it "should set ORDERTYPE to '4' when it is set to the wrong thing" do
    model = GlobalCollect::RequestModels::InsertOrderWithPayment::RecurringOrder.new(
      "ORDERID"      => "1",
      "ORDERTYPE"    => "1",
      "AMOUNT"       => "1",
      "CURRENCYCODE" => "USD",
      "LANGUAGECODE" => "en",
      "COUNTRYCODE"  => "US"
    )
    model["ORDERTYPE"].should == "4"
  end
end