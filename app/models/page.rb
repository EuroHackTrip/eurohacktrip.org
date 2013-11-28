class Page < ActiveRecord::Base
	is_impressionable
	extend FriendlyId
	friendly_id :name, use: [:slugged, :history]
end
