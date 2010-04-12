module GlobalCollect::Requests
  class CancelOrder < GlobalCollect::Requests::Simple
    # WDL §5.23
    def initialize(order_id)
      super("CANCEL_ORDER", { "ORDERID" => order_id })
    end
    
    def wrapper; "ORDER"; end
    
    def fields
      {
        "ORDERID" => ["N10", "R"]
      }
    end
  end
end