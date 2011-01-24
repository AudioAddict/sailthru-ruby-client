require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'uri'

gem 'fakeweb', ">= 1.2.6"
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sailthru'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
  def setup
    FakeWeb.clean_registry
  end

  def fixture_file(filename)
    return '' if filename == ''
    file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
    File.read(file_path)
  end

  def sailthru_api_base_url(url)
    url
  end

  def sailthru_api_call_url(url, action)
    url += '/' if !url.end_with?('/')
    sailthru_api_base_url(url + action)
  end

  def stub_get(url, filename)
    options = { :body => fixture_file(filename), :content_type => 'application/json' }
    FakeWeb.register_uri(:get, URI.parse(url), options)
  end

  def stub_post(url, filename)
    FakeWeb.register_uri(:post, URI.parse(url), :body => fixture_file(filename), :content_type => 'application/json')
  end
end