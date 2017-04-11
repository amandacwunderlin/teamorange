class MeetingsController < ApplicationController
    def new
       @meeting = Meeting.new 
       #@meetings = Meeting.find(:all)
    end
    
    def create
        @meeting = Meeting.new(params.require(:meeting).permit(:startdate, :enddate, :summary))
        render text: @meeting.inspect 
    end
    
    
    
    
    
end
