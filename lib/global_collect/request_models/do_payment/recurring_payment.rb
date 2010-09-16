module GlobalCollect::RequestModels::DoPayment
  class RecurringPayment < Payment
    def suggested_response_mixins
      super + [GlobalCollect::Responses::DoPayment::CreditCardResponseMethods]
    end
    def fields
      # A recurring payment will never have the default EFFORTID of '1', hence
      # it is a required field.
      super.merge({
        "EFFORTID" => ["N5", "R"]
      })
    end
  end
end


