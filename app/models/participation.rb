class Participation < ActiveRecord::Base
  belongs_to :startup
  belongs_to :event
end
