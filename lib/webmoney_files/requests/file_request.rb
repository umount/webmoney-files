module WebmoneyFiles
  module Requests
    class FileRequest
      attr_accessor :connection

      def upload(file_path, options={})
        response = connection['fast_upload'].post({
          file: File.new(file_path, 'rb')
        }.merge(options))

        WebmoneyFiles::Response.result(response)
      end

      def delete(id)
        response = connection['folders/bulk.json'].patch({
          operation: 'delete',
          file_ids: [id]
        })

        response.code == 200 ? true : false
      end

      def shared(id)
        url_path = "/files/#{id}.json"
        response = connection[url_path].patch({
          file: { shared: true }
        })

        WebmoneyFiles::Response.result(response)
      end
    end
  end
end
