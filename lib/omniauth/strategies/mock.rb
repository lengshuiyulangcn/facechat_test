module OmniAuth
  module Strategies
    class Mock < OmniAuth::Strategies::OAuth2
      RAW_INFO_URL = 'api/v1/me'

      uid { raw_info['uid'] }

      info do
        {
          email: raw_info['email'],
          name: raw_info['name']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= JSON.parse(access_token.get(RAW_INFO_URL).response.body)
      end
    end
  end
end
