require 'rest-client'
require 'json'

require 'webmoney_files/version'
require 'webmoney_files/authorize'
require 'webmoney_files/response'
require 'webmoney_files/requests/file_request'
require 'webmoney_files/requests/folder_request'

module WebmoneyFiles
  module ClassMethods
    def new(config)
      @connection ||= WebmoneyFiles::Authorize.new(
        configure.merge(config)
      )

      self
      #WebmoneyFiles::Requests.new(@connection)
    end

    def configure(config={})
      @config = {
        host: 'https://files.webmoney.ru',
        webmoney_instance: false
      }.merge!(config)
    end

    def connection(connection=nil)
      @connection = connection || @connection || WebmoneyFiles::Authorize.new(@config)
    end

    def connection=(connection)
      @connection = connection
    end

    def file
      instanse = WebmoneyFiles::Requests::FileRequest.new
      instanse.connection = connection
      instanse
    end

    def folder
      instanse = WebmoneyFiles::Requests::FolderRequest.new
      instanse.connection = connection
      instanse
    end
  end

  extend ClassMethods
end
