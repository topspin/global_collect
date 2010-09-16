module GlobalCollect::Responses::DoPayment
  # WDL §5.13.2 specifies the possible return keys
  module CreditCardResponseMethods
    [
      "CURRENCYCODE"        ,
      "AMOUNT"              ,
      "PAYMENTREFERENCE"    ,
      "ADDITIONALREFERENCE" ,
      "EXTERNALREFERENCE"   ,
      "STATUSID"            ,
      "STATUSDATE"          ,
      "AVSRESULT"           ,
      "CVVRESULT"           ,
      "FRAUDRESULT"         ,
      "FRAUDCODE"           ,
      "FRAUDNEURAL"         ,
      "FRAUDCRF"            ,
      "AUTHORISATIONCODE"
    ].each do |meth|
      define_method meth.downcase.gsub(/\s+/, "_") do
        row[meth.gsub(/\s+/, "")]
      end
    end

    def payment_status
      GlobalCollect::Const::PaymentStatus.from_code(statusid)
    end
  end
end