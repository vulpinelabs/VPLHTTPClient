$: << File.expand_path('../../../rxcode/lib', __FILE__)
$: << File.expand_path('../../../speckle/lib', __FILE__)
require 'speckle/spec_helper'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[ File.expand_path("../support/**/*.rb", __FILE__) ].each { |f| require f }

Speckle.framework('VPLHTTPClient')

RSpec.configure do |config|
  config.before(:suite) do
    VPLHTTPClient.setNetworkRequestsEnabled(false)
  end
end
