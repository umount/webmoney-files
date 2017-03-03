require 'rest-client'
require 'json'

require 'webmoney_files/version'
require 'webmoney_files/authorize'
require 'webmoney_files/response'
require 'webmoney_files/requests'
require 'webmoney_files/requests/file_request'
require 'webmoney_files/requests/folder_request'

module WebmoneyFiles
  module ClassMethods
    def new(config)
      connection = WebmoneyFiles::Authorize.client(
        configure.merge(config)
      )

      WebmoneyFiles::Requests::Class.new(connection)
    end

    def configure(config={})
      @config = {
        host: 'https://files.webmoney.ru',
        webmoney_instance: false
      }.merge!(config)
    end

    def connection(connection=nil)
      @connection = connection || @connection || WebmoneyFiles::Authorize.client(@config)
    end

    def connection=(connection)
      @connection = connection
    end
  end

  extend ClassMethods
end
