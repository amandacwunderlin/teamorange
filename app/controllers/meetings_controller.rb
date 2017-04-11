class MeetingsController < ApplicationController
    def new
       @meeting = Meeting.new 
       #@meetings = Meeting.find(:all)
    end
    
    def create
        @meeting = Meeting.new(params[:meeting])
        if @meeting.save
            redirect_to new_meeting_path
        end
    end
    
    private
    def meeting_params
      params.require(:meeting).permit(:startdate, :enddate)
    end
    
    
    
end
