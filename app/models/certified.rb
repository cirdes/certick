class Certified < ActiveRecord::Base

	attr_accessor :event

	validates :background, :attachment_presence => true

	validates :event_id, :presence => true

  has_attached_file :background, :styles => { :medium => "300x300>", :small => "70x70>" ,:thumb => "35x35>" }, :default_url => "/images/:style/missing.png"

end
