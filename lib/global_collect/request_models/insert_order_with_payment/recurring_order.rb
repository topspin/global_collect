module GlobalCollect::RequestModels::InsertOrderWithPayment
  class RecurringOrder < Order
    def initialize(attributes)
      super(attributes)
      # WDL Appendix F specifies the recurring order type as '4'
      @attributes["ORDERTYPE"] = "4"
    end
  end
end