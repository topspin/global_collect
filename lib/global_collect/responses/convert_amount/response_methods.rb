module GlobalCollect::Responses::ConvertAmount
  # WDL §5.7.2 specifies the possible return keys
  module ResponseMethods
    def converted_amount
      success_data["CONVERTEDAMOUNT"]
    end
  end
end