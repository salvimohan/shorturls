class ShortUrl < ApplicationRecord
  validates :url, 
	 	presence: true, 
	 	uniqueness: true,
	 	format: { 
	  	with: URI.regexp(%w[http https]), 
	  	message: 'is not a valid URL' 
		}

	has_many :visit_tracks

end
