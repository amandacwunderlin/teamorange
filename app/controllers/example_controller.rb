class ExampleController < ApplicationController
    def redirect
        client = Signet::OAuth2::Client.new({
          client_id: Rails.application.secrets.google_client_id,
          client_secret: Rails.application.secrets.google_client_secret,
          authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
          scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
          redirect_uri: callback_url
        })

        redirect_to client.authorization_uri.to_s
    end
end
