class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :startdate
      t.string :enddate
      t.string :summary
      t.string :location
      t.string :attendees
      t.string :description
      
      t.timestamps null: false
    end
    
    
  end
end
