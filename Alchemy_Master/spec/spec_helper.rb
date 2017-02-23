$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'alchemy_api'
require 'spec'
require 'spec/autorun'

AlchemyApi.api_key = 'f88fe4143807b814c20cb1d6688bea446d8aa9f6'

require 'typhoeus_spec_cache'

Spec::Runner.configure do |config|
  config.include(Typhoeus::SpecCacheMacros::InstanceMethods)
  config.extend(Typhoeus::SpecCacheMacros::ClassMethods)

  def fixture_for(path)
    File.read(fixture_path(path))
  end

  def fixture_path(path)
    File.expand_path(File.dirname(__FILE__) + "/fixtures/#{path}")
  end
end
