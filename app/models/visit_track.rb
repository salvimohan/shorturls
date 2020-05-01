class VisitTrack < ApplicationRecord
	validates :ip, 
		presence: true , 
		uniqueness: {:scope => :short_url_id}

	after_create :increment_visit!
	after_create :api_call_for_country_update

	def increment_visit!
    self.update_column("visits_count", (self.visits_count.to_i+1))
  end

  def api_call_for_country_update
     UpdateVisitCountry.delay.perform(self.id)
  end

end
