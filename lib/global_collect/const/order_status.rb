module GlobalCollect::Const
  module OrderStatus
    def status(code)
      code = code.to_i
      raise ArgumentError.new("Invalid order status code!") unless STATUSES.key?(code)
      Status.new(code, *STATUSES[code])
    end

    private

    STATUSES = {
      0  => ["ORDER CREATED"               , "Order is created."                                               ],
      5  => ["REFUND CREATED"              , "A non-WebCollect order for doing a refund is created."           ],
      10 => ["ORDER WITH ATTEMPT"          , "A (failed) payment attempt has been made on this order."         ],
      15 => ["REFUND FAILED"               , "A failed refund attempt has been made on a non-WebCollect order."],
      20 => ["ORDER WITH SUCCESFUL ATTEMPT", "A successful payment attempt has been made on this order."       ],
      40 => ["ORDER SUCCESFUL"             , "The non recurring order was successful."                         ],
      45 => ["REFUND SUCCESFUL"            , "The order created for a refund was successful."                  ],
      60 => ["ORDER OPEN"                  , "The variable amount recurring order is open for new payments."   ],
      90 => ["ENDED BY MERCHANT"           , "The recurring order has been ended on request of the merchant."  ],
      91 => ["ENDED AUTOMATICALLY"         , "The recurring order has been ended automatically."               ],
      98 => ["REJECTED BY MERCHANT"        , "The merchant has rejected the order."                            ],
      99 => ["CANCELLED BY MERCHANT"       , "The merchant has cancelled the order."                           ]
    }
    class Status < Struct.new(:code, :name, :description)
    end
  end
end
