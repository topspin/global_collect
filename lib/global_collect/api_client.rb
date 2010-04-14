module GlobalCollect
  class ApiClient
    include HTTParty
    # WDL §4 specifies the body should be xml
    format :xml
    # WDL §3.1 specifies the content type
    headers "Content-Type" => "text/xml; charset=utf-8"
    # WDL §3.6 recommends this timeout
    DEFAULT_TIMEOUT = 70
    # Net::HTTP warns that debug_output should not be set in production
    # because it is a security problem.
    debug_output(nil)

    def initialize(service, environment, authentication)
      @service_url = ApiClient.service_url(service, environment, authentication)
    end

    def make_request(request, add_mixins=true)
      xml = request.to_xml
      GlobalCollect.wire_logger.info("POST [#{request.action}] => [#{@service_url}] with XML body:\n#{xml}")
      
      response = nil
      request_time = Benchmark.realtime do
        response = self.class.post(@service_url,
          :body     => xml,
          :timeout  => DEFAULT_TIMEOUT
        )
      end
      raise "Request failed! No response!" unless response
      GlobalCollect.wire_logger.info("#{response.code} - #{request_time} s - Response body:\n#{response.body}")
      
      base = GlobalCollect::Responses::Base.new(response.delegate)
      raise "Malformed response! Body: '#{response.body}'" if base.malformed?
      request.suggested_response_mixins.each{|m| base.extend(m) } if add_mixins
      base
    end
    
    private
    
    def self.service_url(service, environment, authentication)
      # WDL §§3.4-5 specify the allowed arguments
      raise ArgumentError.new("Only [Hosted] Merchant Link is currently supported!") unless [:merchant_link].include?(service)
      raise ArgumentError.new("Only :test and :production are valid environemnts!") unless [:test, :production].include?(environment)
      raise ArgumentError.new("Only :ip_check and :client_auth are valid authentication schemes!") unless [:ip_check, :client_auth].include?(authentication)
      {
        :merchant_link => {
          # WDL §3.4 specifies the test environment urls
          :test       => {
            :ip_check     => "https://ps.gcsip.nl/wdl/wdl",
            :client_auth  => "https://ca.gcsip.nl/wdl/wdl"
          },
          # WDL §3.5 specifies the prodution environment urls
          :production => {
            :ip_check     => "https://ps.gcsip.com/wdl/wdl",
            :client_auth  => "https://ca.gcsip.com/wdl/wdl"
          }
        }
      }[service][environment][authentication]
    end
  end
end