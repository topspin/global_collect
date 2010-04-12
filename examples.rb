require 'rubygems'
require File.join(File.dirname(__FILE__), "lib", "global_collect")

GlobalCollect.merchant_id           = ""
GlobalCollect.authentication_scheme = :ip_check
GlobalCollect.environment           = :test
GlobalCollect.ip_address            = ""
#GlobalCollect.wire_log_file         = File.join(File.dirname(__FILE__), "gc.log")

client    = GlobalCollect.merchant_link_client

# Example 1: TestConnection
response = client.make_request(GlobalCollect::Requests::TestConnection.new)
p response.success?

# Example 2: InsertOrderWithPayment
response  = client.make_request(
  GlobalCollect::Requests::InsertOrderWithPayment.new(
    [
      GlobalCollect::RequestModels::Order.new(
        "ORDERID"           => "54",
        "AMOUNT"            => "100",
        "LANGUAGECODE"      => "en",
        "CURRENCYCODE"      => "USD",
        "COUNTRYCODE"       => "US",
        "MERCHANTREFERENCE" => "1"
      ),
      GlobalCollect::Builders::Order
    ],
    [
      GlobalCollect::RequestModels::HostedCreditCardOnlinePayment.new(
        "PAYMENTPRODUCTID" => "54",
        "AMOUNT"           => "100",
        "CURRENCYCODE"     => "USD",
        "LANGUAGECODE"     => "en",
        "COUNTRYCODE"      => "US"
      ),
      GlobalCollect::Builders::HostedCreditCardOnlinePayment
    ]
  )
)

# Example 3: ProcessChallenged
response  = client.make_request(GlobalCollect::Requests::ProcessChallenged.new("51"))

# Example 4: GetOrderStatus (v2.0)
req = GlobalCollect::Requests::GetOrderStatus.new("54")
req.version = "2.0"
response  = client.make_request(req)
