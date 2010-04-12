require 'time'

module GlobalCollect::Responses
  # WDL §4 specifies the generalized response
  # This base class is sufficient for many responses that don't include anything
  # more than the basic META, RESULT and/or ERROR nodes.
  # It is also a useful fallback if you want basic hash access to the actual
  # content of the response with just a few helper methods for traversal.
  class Base
    attr_reader :response_hash
    def initialize(response_hash)
      @response_hash = response_hash
    end
    
    def success?
      RESPONSE_STATUS_SUCCESS[result]
    end
    
    def action
      request['ACTION']
    end
    
    def response_datetime
      Time.parse(meta['RESPONSEDATETIME']) if meta['RESPONSEDATETIME']
    end
    
    def request_id
      meta['REQUESTID']
    end
    
    def version
      meta['VERSION']
    end
    
    def errors
      return nil if success?
      
      errors = nil
      if response['ERROR']
        errors = if response['ERROR'].is_a?(Array)
          response['ERROR']
        else
          [response['ERROR']]
        end
      # WDL §5.23.3 and correspondence with GC suggests that version 2.0
      # GetOrderStatus calls have a nested ERRORS>ERROR format.
      elsif version == "2.0" && action == "GET_ORDERSTATUS"
        errors = if response['ERRORS'].is_a?(Array)
          response['ERRORS'].map{|e| e['ERROR'] }
        else
          [response['ERRORS']['ERROR']]
        end
      end
      
      return nil unless errors
      errors.map do |error|
        OpenStruct.new(
          :code    => error['CODE'],
          :message => error['MESSAGE']
        )
      end
    end
    
    def malformed?
      !response_hash['XML']
    end
    
    protected

    def result
      response['RESULT']
    end
    
    def meta
      response['META']
    end

    # this structure is general to successful and unsuccessful response
    def response
      request['RESPONSE']
    end
    
    def request
      response_hash['XML']['REQUEST']
    end
    
    private
    
    RESPONSE_STATUS_SUCCESS = {
      'OK'  => true,
      'NOK' => false
    }
  end
end