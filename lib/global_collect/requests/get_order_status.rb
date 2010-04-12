module GlobalCollect::Requests
  class GetOrderStatus < GlobalCollect::Requests::Simple
    # WDL §5.23
    def initialize(order_id)
      super("GET_ORDERSTATUS", { "ORDERID" => order_id })
    end
    
    def wrapper; "ORDER"; end
    
    def fields
      {
        "ORDERID" => ["N10", "R"]
      }
    end
  end
end