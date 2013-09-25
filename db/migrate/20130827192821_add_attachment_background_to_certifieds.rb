class AddAttachmentBackgroundToCertifieds < ActiveRecord::Migration
  def self.up
    change_table :certifieds do |t|
      t.attachment :background
    end
  end

  def self.down
    drop_attached_file :certifieds, :background
  end
end
