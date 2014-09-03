class Certified < ActiveRecord::Base
	attr_accessor :event
	belongs_to :user

	validates :event_id, :name_color, :background_url, :presence => true
end
