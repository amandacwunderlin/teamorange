class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :startdate
      t.string :enddate
      t.string :summary

      t.timestamps null: false
    end
  end
end
