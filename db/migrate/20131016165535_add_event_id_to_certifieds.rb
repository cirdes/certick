class AddEventIdToCertifieds < ActiveRecord::Migration
  def change
    change_table :certifieds do |t|
      t.integer :event_id

      
    end
  end
end
