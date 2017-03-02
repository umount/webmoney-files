module WebmoneyFiles
  module Response
    module ClassMethods
      def result(response)
        case response.code
        when 400
          JSON.parse(response.body)
        when 200
          JSON.parse(response.body)
        else
          fail "Invalid response #{response.to_str} received."
        end
      end
    end

    extend ClassMethods
  end
end
