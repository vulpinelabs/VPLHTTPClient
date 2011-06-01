# VPLHTTPClient

VPLHTTPClient is a high-level, test-drivable HTTP interface for Objective-C. When test-driving code that uses a web service, for example, you do not want to actually contact external resources. Instead, VPLHTTPClient allows you to:

* Block all external HTTP requests, causing an exception to be thrown if a test attempts to contact a remote web server.

* Register mock/pre-canned responses for URLs your test code is expected to contact.

VPLHTTPClient was inspired by the [FakeWeb](http://fakeweb.rubyforge.org/) ruby gem, and uses [ASIHTTPRequest](http://allseeing-i.com/ASIHTTPRequest/) to handle all HTTP traffic.

## License

VPLHTTPClient is distributed under a BSD-style license, as is ASIHTTPRequest. ASIHTTPRequest is copyright (c) 2007-2011, All-Seeing Interactive, and it's license is available here: https://github.com/pokeb/asi-http-request/blob/master/LICENSE

