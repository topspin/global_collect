require 'builder'
require 'httparty'
require 'find'
require 'logger'
require 'benchmark'

module GlobalCollect;end
module GlobalCollect::Builders;end
module GlobalCollect::RequestModels;end
module GlobalCollect::Responses;end

lib_dir = File.dirname(__FILE__)
[
  %w[api_client]                                                                       ,
  %w[builders do_refund payment]                                                       ,
  %w[builders do_refund credit_card_payment]                                           ,  
  %w[builders insert_order_with_payment order]                                         ,    
  %w[builders insert_order_with_payment payment]                                       ,      
  %w[builders insert_order_with_payment credit_card_online_payment]                    ,                         
  %w[builders insert_order_with_payment hosted_credit_card_online_payment]             ,                                
  %w[builders set_payment payment]                                                     ,
  %w[const payment_product]                                                            ,
  %w[const payment_status]                                                             ,
  %w[const order_status]                                                               ,
  %w[field_validator]                                                                  ,
  %w[request_models base]                                                              ,
  %w[request_models insert_order_with_payment order]                                   ,
  %w[request_models insert_order_with_payment payment]                                 ,
  %w[request_models insert_order_with_payment credit_card_online_payment]              ,  
  %w[request_models insert_order_with_payment hosted_credit_card_online_payment]       ,  
  %w[request_models do_refund payment]                                                 ,
  %w[request_models do_refund credit_card_payment]                                     ,
  %w[request_models set_payment payment]                                               ,
  %w[requests base]                                                                    ,
  %w[requests simple]                                                                  ,
  %w[requests composite]                                                               ,
  %w[requests insert_order_with_payment]                                               ,
  %w[requests get_order_status]                                                        ,
  %w[requests test_connection]                                                         ,
  %w[requests cancel_order]                                                            ,
  %w[requests do_refund]                                                               ,
  %w[requests set_payment]                                                             ,
  %w[requests process_challenged]                                                      ,
  %w[responses base]                                                                   ,
  %w[responses success_row]                                                            ,
  %w[responses insert_order_with_payment credit_card_online_payment_response_methods]  ,
  %w[responses insert_order_with_payment hosted_merchant_link_payment_response_methods],
  %w[responses do_refund response_methods]

].each do |f|
  require File.join(lib_dir, 'global_collect', *f)
end

module GlobalCollect
  extend self
  
  attr_accessor :merchant_id
  attr_accessor :authentication_scheme
  attr_accessor :ip_address # only used if authentication_scheme is :ip_check
  attr_accessor :environment
  attr_accessor :api_version
  attr_accessor :wire_log_file
  attr_accessor :wire_logger

  def merchant_link_client
    GlobalCollect::ApiClient.new(:merchant_link, environment, authentication_scheme)
  end
  
  def wire_logger
    @wire_logger ||= if self.wire_log_file
      Logger.new(self.wire_log_file)
    else
      Logger.new(STDOUT)
    end
  end
end

GlobalCollect.api_version ||= "1.0"