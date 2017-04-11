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
  
  
      
      
      event = Google::Apis::CalendarV3::Event.new{
        summary: 'Google I/O 2015',
        location: '800 Howard St., San Francisco, CA 94103',
        description: 'A chance to hear more about Google\'s developer products.',
        start: {
          date_time: '2015-05-28T09:00:00-07:00',
          time_zone: 'America/Los_Angeles',
        },
        end: {
          date_time: '2015-05-28T17:00:00-07:00',
          time_zone: 'America/Los_Angeles',
        },
        recurrence: [
          'RRULE:FREQ=DAILY;COUNT=2'
        ],
        attendees: [
          {email: 'lpage@example.com'},
          {email: 'sbrin@example.com'},
        ]
        
      }
      
      service = client.insert_event('primary', event)
      redirect_to events_url(calendar_id: params['primary'])

      
    end
    
    def create_event
    end
end
