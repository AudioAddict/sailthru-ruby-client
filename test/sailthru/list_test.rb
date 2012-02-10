$:.unshift File.join(File.dirname(__FILE__),'..')
require 'test_helper'

class ListTest < Test::Unit::TestCase
  context "API Call: list" do
    setup do
       api_url = 'http://api.sailthru.com'
      @secret = 'my_secret'
      @api_key = 'my_api_key'
      @sailthru_client = Sailthru::SailthruClient.new(@api_key, @secret, api_url)
      @api_call_url = sailthru_api_call_url(api_url, 'list')
    end

    should "be able to get all lists meta data" do
        query_string = create_json_payload(@api_key, @secret, {})
        stub_get(@api_call_url + '?' + query_string, 'list_get_all.json')
        response = @sailthru_client.get_lists()
        assert_equal(response['lists'].length, 2)
        assert_not_nil(response['lists'][0]['name'])
    end

    should "be able to get list information" do
      list = 'list1'
      query_string = create_json_payload(@api_key, @secret, {'list' => list})
      stub_get(@api_call_url + '?' + query_string, 'list_get_valid.json')
      response = @sailthru_client.get_list(list)
      assert_equal(response['list'], list)
      assert_not_nil response['type']
    end
   
    should "get empty response for invalid list in json format" do
      list = 'invalidlistname'
      params = {:list => list} 
      query_string = create_json_payload(@api_key, @secret, params)
      stub_get(@api_call_url + '?' + query_string, 'list_get_invalid.json')
      response = @sailthru_client.get_list(list)
      assert_not_nil response['errormsg']
      assert_not_nil response['error']
    end

    should "be able to save list information" do
        list = 'new-list2'
        primary = 1
        data = {
            'list' => list,
            'primary' => primary
        }
        stub_post(@api_call_url, 'list_save_valid.json')
        response = @sailthru_client.save_list(list, data)
        assert_equal(response['list'], list)
    end

    should "not be able to delete invalid list" do
      list = 'invalid-list'
      params = {'list' => list}
      query_string = create_json_payload(@api_key, @secret, params)
      stub_delete(@api_call_url + '?' + query_string, 'list_delete_invalid.json')
      response = @sailthru_client.delete_list(list)
      assert_not_nil response['error']
    end

    should "be able to delete valid list" do
      list = 'my-list'
      params = {:list => list}
      query_string = create_json_payload(@api_key, @secret, params)
      stub_delete(@api_call_url + '?' + query_string, 'list_delete_valid.json')
      response = @sailthru_client.delete_list(list)
      assert_equal(list, response['list'])
    end
  end
end
