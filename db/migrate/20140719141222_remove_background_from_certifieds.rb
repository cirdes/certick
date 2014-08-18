class RemoveBackgroundFromCertifieds < ActiveRecord::Migration
  def self.up
    drop_attached_file :certifieds, :background
  end

  def self.down
    change_table :certifieds do |t|
      t.attachment :background
    end
  end
end
