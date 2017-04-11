class MeetingsController < ApplicationController
    def new
       @meeting = Meeting.new 
       @meetings = Meeting.all
    end
    
    def create
        @meeting = Meeting.new(params.require(:meeting).permit(:startdate, :enddate, :summary))
        if @meeting.save
            redirect_to new_meeting_url
        end
    end
    
    
    
    
    
end
