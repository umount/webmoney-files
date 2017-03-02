module WebmoneyFiles
  class Authorize
    def initialize(config)
      resource = RestClient::Resource.new(config['host'])
      response = resource['login.json'].get(content_type: :json)
      session_id =  JSON.parse(response.body)['session']['session_id']

      sign_string = "#{session_id}#{config['webmoney_instance'].wmid}"
      sign_session = config['webmoney_instance'].sign(sign_string)

      request_params = {wmid: wmid, sign: sign_session}.to_json
      response = resource['authenticate.json'].post(request_params, {
        content_type: :json,
        accept: :json,
        cookies: {
          session_id: session_id
        }
      })

      RestClient::Resource.new(config['host'], cookies: {
        session_id: JSON.parse(response.body)['session']['session_id']
      }, headers: { accept: :json })
    end
  end
end
