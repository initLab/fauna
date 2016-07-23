class Author < ActiveRecord::Base
	validates :first_name, :presence => true, allow_blank: false
	validates :last_name, :presence => true, allow_blank: false
end
