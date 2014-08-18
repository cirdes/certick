class Certified < ActiveRecord::Base
	belongs_to :user
	attr_accessor :event

	validates :event_id, :presence => true

	has_attached_file :background, :styles => { :default => "1024x768", :medium => "300x300>", :small => "70x70>" ,:thumb => "35x35>" }, :default_url => "/images/:style/missing.png"

	validates_attachment :background, :presence => true,
  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] }
end
