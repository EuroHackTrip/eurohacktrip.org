class Country < ActiveRecord::Base
	has_many :cities, dependent: :destroy
	has_many :people, dependent: :destroy
end
