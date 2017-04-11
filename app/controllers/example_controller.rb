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
    
    def callback
        client = Signet::OAuth2::Client.new({
          client_id: Rails.application.secrets.google_client_id,
          client_secret: Rails.application.secrets.google_client_secret,
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
          redirect_uri: callback_url,
          code: params[:code]
        })
    
        response = client.fetch_access_token!
    
        session[:authorization] = response
    
        redirect_to calendars_url
    end
    
    
    def calendars
        client = Signet::OAuth2::Client.new({
          client_id: Rails.application.secrets.google_client_id,
          client_secret: Rails.application.secrets.google_client_secret,
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
        })
    
        client.update!(session[:authorization])
    
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
    
        @calendar_list = service.list_calendar_lists
        @event_list = service.list_events('primary')


        
    end
    
    def events
      client = Signet::OAuth2::Client.new({
        client_id: Rails.application.secrets.google_client_id,
        client_secret: Rails.application.secrets.google_client_secret,
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
      })
  
      client.update!(session[:authorization])
  
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
  
      @event_list = service.list_events(params[:calendar_id])
    end
    
    
    def new_event
      client = Signet::OAuth2::Client.new({
        client_id: Rails.application.secrets.google_client_id,
        client_secret: Rails.application.secrets.google_client_secret,
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
      })
  
      client.update!(session[:authorization])
  
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
  
      today = Date.today
  
      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
        end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
        summary: 'New event!'
      })
  
      service.insert_event(params['primary'], event)
  
      redirect_to events_url(calendar_id: params['primary'])
    end
    
    def create_event
    end
end
