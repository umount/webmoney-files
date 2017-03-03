module WebmoneyFiles
  module Authorize
    module ClassMethods
      def client(config)
        resource = RestClient::Resource.new(config[:host])
        response = resource['login.json'].get(content_type: :json, accept: :json)
        session_id = JSON.parse(response.body)['session']['session_id']

        webmoney_instance = config[:webmoney_instance]
        sign_string = "#{session_id}#{webmoney_instance.wmid}"
        sign_session = webmoney_instance.sign(sign_string)

        request_params = {wmid: webmoney_instance.wmid, sign: sign_session}.to_json
        response = resource['authenticate.json'].post(request_params, {
          content_type: :json,
          accept: :json,
          cookies: {
            session_id: session_id
          }
        })

        client = RestClient::Resource.new(config[:host], cookies: {
          session_id: JSON.parse(response.body)['session']['session_id']
        }, headers: { accept: :json })
      end
    end

    extend ClassMethods
  end
end
