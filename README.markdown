GlobalCollect: A Gem
======================

A relatively bare Ruby library that supplies sane, factored access to the GlobalCollect XML payment API.

## Getting Started
* Get your GlobalCollect API credentials out, then

        gem install globall_collect

* See examples.rb, fill in your merchant id, and authentication scheme and then run the first example, which is a TEST_CONNECTION call to make sure everything is nominally OK.

## Breakdown
### Requests
Requests are the basic unit of communication with the GlobalCollect API. They're mostly the programmatic and XML glue that ties the action and arguments of the call together, generating XML to send to GlobalCollect. They can be found under lib/global_collect/requests/*.rb

Each API call that has been implemented has been implemented as a subclass (directly or indirectly) of
        GlobalCollect::Requests::Base
If an API call accepts multiple "models" in the XML request (PARAMS subnodes with nontrivial subnodes of their own), it is probably a subclass of
        GlobalCollect::Requests::Composite
and is constructed with Model-Builder pairs like this:
        GlobalCollect::Requests::DoRefund.new([payment_request_model, GlobalCollect::Builders::DoRefund::Payment])
_The models and builders are usually paired in their respective module hierarchies:_
        GlobalCollect::RequestModels::DoRefund::Payment
        GlobalCollect::Builders::DoRefund::Payment
In the case where the arguments to the request constructor are models, the validation for the values in the models is encapsulated in the model itself.

If the call accepts a fixed set of non-nested arguments, it will probably be implemented as a subclass of
        GlobalCollect::Requests::Simple
and be constructed with the values of the arguments without and intermediary model. Validation for these members is defined in the request, in this case.

### Builders
Builders simply take hash-like objects (usually a RequestModel or just a hash for simpler calls) and construct the subnodes of the PARAMS XML node in the request. As mentioned above, Builders are paired with their RequestModels by name, simply replacing 'RequestModels' with 'Builders' in the module path.
    
### RequestModels
    As mentioned above, RequestModels are a way of breaking up the multiple conceptual arguments to the API. They are paired to their Builders as mentioned above. They're really just a nice way to get a little sanity into this piece when the XML structures that are used as arguments to the API get a bit hairy. (In the sense that they form a kind of inheritance tree, depending on the payment type, or that they have multiple, large arguments, etc...) However, there has been a conscious effort to eschew this complexity when dealing with API calls that really don't have much relative conceptual complexity. (GetOrderStatus really only has one string as an argument, "ORDERID", even though it is nested in an "ORDER" node.)

### Responses
#### The raw responses from the API are divided into four groups:
* Basic
    * No content besides META, RESULT, or ERROR
* Success Row (Single outcome)
    * Basic + ROW node which contains a roughly fixed set of keys independent of input
    * For instance, CONVERT_AMOUNT returns a fixed set of keys.
* Success Row (Multi-Outcome)
    * Basic + ROW node which contains a basic set of fixed keys with extra keys dependent on input
    * For instance, INSERT_ORDER returns extra keys depending on payment type.
* Complex
    * Basic + multiple subnodes of RESULT that do not follow the ROW/keys format.
    * For instance, GET_ORDERSTATUS (v2.0) and GET_BANK_DETAILS
    
#### The strategy for handling these four groups is as follows:
The base response
        GlobalCollect::Responses::Base
is augmented by mix-in modules suggested by the suggested_response_mixins method of the request. These allow pretty, method-style access to the members. However, if basic hash-style access to the Crack-parsed response is desired, you can easily do so like this:
        response = client.make_request(some_request)
        response.response_hash["XML"]["REQUEST"]["RESPONSE"]["META"]["REQUESTID"] == response.request_id
        # => true

### Validation
The GlobalCollect programmer's guide (see below for specific documentation notes) has specified the data formatting expected in requests, and as such, they appear in this gem in roughly the same data format as they appear there:
        FIELDNAME => [REQUIRED?, FORMAT_STRING]
However, in the cases where a field is required only when using a specific service or product, I have relaxed the requirements for the base model. For instance, see the difference between:
        GlobalCollect::RequestModels::InsertOrderWithPayment::CreditCardOnlinePayment
            vs
                GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment

In the Hosted version, the field definitions for CARDNUMBER and EXPIRYDATE have been changed from "R" (required) to "O" (optional), even though the programmer's guide has them marked as "R" with a superscript indicating they are not required in the particular case of HostedMerchantLink payments.

## Notes
### On documentation:

All documentation references in the source code refer to the "GlobalCollect WDL Programmers Guide -- 17 November 2009" document, which you'll have to get from GlobalCollect.

### On GC API versions:

* 1.0 - All calls are supported. (all requests default to v 1.0)
* 2.0 - Only certain calls under certain services are provided:
    * Get Order Status (all services)
    * Insert Order (CustomerLink allows a v2.0)
    Hence, you must explicitly set the version of the request to '2.0' before passing it to the ApiClient. (see Example #4 in examples.rb)
    
    _Also: The request key sets seem to be invariant under versions. However, the response keys can vary significantly between versions._

### On wire logging:
If you specify
        GlobalCollect.wire_log_file = "mylog.log"
the raw XML of all requests and responses will be logged to that file *unsanitized*. Be sure to keep these secure if you choose that option as they could contain addresses, emails, credit card numbers, etc. If no file is specified, logging will be done to STDOUT.

To assign your own logger to the gem, simply do:
        your_logger = Rails.logger
        GlobalCollect.wire_logger = your_logger
        client = GlobalCollect::ApiClient.new ...
