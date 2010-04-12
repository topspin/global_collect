module GlobalCollect::Responses
  # This is one of the classes of response that you can get from the API, which
  # if successful returns a structure like:
  # <RESPONSE>
  #     <META>...</META>
  #     <RESULT>...</RESULT>
  #     <ROW> RELEVANT NODES HERE </ROW>
  # </RESPONSE>
  module SuccessRow
    def success_data
      return nil unless success?
      response['ROW']
    end
  end
end