class MeetingsController < ApplicationController
    def new
       @meeting = Meeting.new 
       @meetings = Meeting.all
    end
    
    def create
      @meeting = Meeting.new(params.require(:meeting).permit(:startdate, :enddate, :summary))
        if @meeting.save  
            client = Signet::OAuth2::Client.new({
                client_id: Rails.application.secrets.google_client_id,
                client_secret: Rails.application.secrets.google_client_secret,
                token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
            })
          
            client.update!(session[:authorization])
          
            service = Google::Apis::CalendarV3::CalendarService.new
            service.authorization = client
              
            
        
            event = Google::Apis::CalendarV3::Event.new({
            start: Google::Apis::CalendarV3::EventDateTime.new(date: @meeting.startdate),
            end: Google::Apis::CalendarV3::EventDateTime.new(date: @meeting.enddate),
                summary: @meeting.summary
              })
              
              
            result = service.insert_event('primary', event)
            redirect_to root_url
                
        end
    
        
    end
    
    
    
    
    
end
