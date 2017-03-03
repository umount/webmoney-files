module WebmoneyFiles
  module Requests
    module InstanceMethods
      def connection=(connection)
        @connection = connection
      end

      def connection
        @connection
      end

      def file
        instanse = WebmoneyFiles::Requests::FileRequest.new
        instanse.connection = @connection
        instanse
      end

      def folder
        instanse = WebmoneyFiles::Requests::FolderRequest.new
        instanse.connection = @connection
        instanse
      end
    end

    class Class
      include WebmoneyFiles::Requests::InstanceMethods

      def initialize(connect)
        self.connection = connect

        self
      end
    end
  end
end
