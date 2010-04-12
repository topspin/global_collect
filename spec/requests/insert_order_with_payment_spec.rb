require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "the insert order with payment request" do
  before(:each) do
    @request = GlobalCollect::Requests::InsertOrderWithPayment.new(
      [
        GlobalCollect::RequestModels::InsertOrderWithPayment::Order.new(
          "ORDERID"                        => "1234567890",
          "AMOUNT"                         => "1234",
          "CURRENCYCODE"                   => "USD",
          "LANGUAGECODE"                   => "en",
          "COUNTRYCODE"                    => "US",
          "MERCHANTREFERENCE"              => "ASDASDASD"
        ), 
        GlobalCollect::Builders::InsertOrderWithPayment::Order
      ],
      [
        GlobalCollect::RequestModels::InsertOrderWithPayment::Payment.new(
          "PAYMENTPRODUCTID" => "1",
          "AMOUNT"           => "1234",
          "CURRENCYCODE"     => "USD",
          "LANGUAGECODE"     => "en",
          "COUNTRYCODE"      => "US"
        ), 
        GlobalCollect::Builders::InsertOrderWithPayment::Payment
      ]
    )
  end
  it "should have the correct action" do
    xml = @request.to_xml
    xml.should match_xpath("/XML/REQUEST/ACTION", "INSERT_ORDERWITHPAYMENT")
  end
end