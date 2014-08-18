class AddAttachmentBackgroundToCertifieds < ActiveRecord::Migration
  def self.up
    add_attachment :certifieds, :background
  end

  def self.down
    remove_attachment :certifieds, :background
  end
end
