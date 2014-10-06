# Author:: Hemant Verma <fameoflight@gmail.com>
# Copyright:: 2014 Hemant Verma
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'uri'
require 'net/https'
require 'json'

module Optimizely
  # This class is used to instantiate a Optimizely Client object. It is expected to be thread safe.
  #
  # @example
  #  # Create a client with your Optimizely API key:
  #  client = Optimizely::Client.new 'YOUR_API_KEY'
  class Client
    class OptimizelyError < StandardError; end

    # Creates a Optimizely Client object. The second parameter is a hash for overriding defaults.
    #
    # @return [Client]
    # @example
    #  # Create a client with your Optimizely API key:
    #  client = Optimizely::Client.new 'YOUR_API_KEY'
    def initialize(api_key, opts={})
      @api_key           = api_key
      @uri               = URI.parse opts[:api_uri] || API_URI
      @https             = Net::HTTP.new @uri.host, @uri.port
      @https.use_ssl     = true

      # Option to disable certificate validation in extraordinary circumstance.  NOT recommended for production use
      @https.verify_mode = opts[:insecure] == true ? OpenSSL::SSL::VERIFY_NONE : OpenSSL::SSL::VERIFY_PEER

    end

    # Makes a GET call to the Optimizely API.
    # @return [Hash]
    def get(path)
      request(Net::HTTP::Get, path)
    end

    # Makes a POST call to the Optimizely API.
    # @return [Hash]
    def post(path, params={})
      request(Net::HTTP::Post, path, params)
    end

    def put(path, params={})
      request(Net::HTTP::Put, path, params)
    end

    def delete(path, params={})
      request(Net::HTTP::Delete, path, params)
    end

    private

    def request(request_klass, path, params=nil)
      request  = make_request(request_klass, path, params)
      response = @https.request(request)
      return JSON.parse(response.body)
    rescue => e
      fail OptimizelyError, "Optimizely Request Error: #{e}"
    end

    def make_request(request_klass, path, params)
      request_klass.new(@uri.path + '/' + path).tap do |r|
        r['Token']                =  @api_key
        r['User-Agent']           =  USER_AGENT
        r['Content-Type']         =  'application/json'
        r.body = params.to_json if params
      end
    end
  end
end
