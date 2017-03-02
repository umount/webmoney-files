module WebmoneyFiles
  module Requests
    class FolderRequest
      attr_accessor :connection

      def create(folder_name)
        response = connection['folders.json'].post({
          folder: {name: folder_name}
        })

        WebmoneyFiles::Response.result(response)
      end

      def delete(id)
        response = connection['folders/bulk.json'].patch({
          operation: 'delete',
          folder_ids: [id]
        })

        response.code == 200 ? true : false
      end
    end
  end
end
