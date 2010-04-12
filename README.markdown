## Getting Started
* Get your GlobalCollect API credentials out, then

        gem install globall_collect

* See examples.rb, fill in your merchant id, and authentication scheme and then run the first example, which is a TEST_CONNECTION call to make sure everything is nominally OK.

## Notes:

### On documentation:

All documentation references in the source code refer to the "GlobalCollect WDL Programmers Guide -- 17 November 2009" document, which you'll have to get from GlobalCollect.

### On GC API versions:

* 1.0 - All calls are supported. (all requests default to v 1.0)
* 2.0 - Only certain calls under certain services are provided:
    * Get Order Status (all services)
    * Insert Order (CustomerLink allows a v2.0)
    Hence, you must explicitly set the version of the request to '2.0' before passing it to the ApiClient. (see Example #4 in examples.rb)
    
    _Also: The request key sets seem to be invariant under versions. However, the response keys can vary significantly between versions._

### On GC responses:
#### They are divided into four groups:
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
The response augmented by mix-in modules suggested by the suggested_response_mixins method of the request.

### On wire logging:
If you specify
        GlobalCollect.wire_log_file = "mylog.log"
the raw XML of all requests and responses will be logged to that file *unsanitized*. Be sure to keep these secure if you choose that option as they could contain addresses, emails, credit card numbers, etc. If no file is specified, logging will be done to STDOUT.

