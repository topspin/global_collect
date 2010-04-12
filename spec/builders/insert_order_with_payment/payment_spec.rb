require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe "the payment builder" do
  before(:each) do
    @node = Builder::XmlMarkup.new
  end
  it "should not build unknown keys" do
    @builder = GlobalCollect::Builders::InsertOrderWithPayment::Payment.new('foo' => 'bar')
    @builder.build(@node)
    xml = @node.target!
    
    xml.should have_xpath("/PAYMENT")
    xml.should_not have_xpath("/PAYMENT/foo")
  end
  
  it "should build known keys" do
    fields = %w[
      PAYMENTPRODUCTID
      AMOUNT
      AMOUNTSIGN
      CURRENCYCODE
      LANGUAGECODE
      COUNTRYCODE
      HOSTEDINDICATOR
      RETURNURL
    ]
    @builder = GlobalCollect::Builders::InsertOrderWithPayment::Payment.new(
      Hash[*fields.zip(fields)]
    )
    @builder.build(@node)
    xml = @node.target!
    
    xml.should have_xpath("/PAYMENT")
    fields.each do |field|
      xml.should match_xpath("/PAYMENT/#{field}", field)
    end
  end
end