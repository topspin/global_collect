require 'rubygems'
require File.join(File.dirname(__FILE__), '..', "lib", "global_collect")

GlobalCollect.merchant_id           = ""
GlobalCollect.authentication_scheme = :ip_check
GlobalCollect.environment           = :test
GlobalCollect.ip_address            = ""
#GlobalCollect.wire_log_file         = File.join(File.dirname(__FILE__), "gc.log")

client    = GlobalCollect.merchant_link_client

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
p response.success?