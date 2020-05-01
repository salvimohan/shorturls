require 'open-uri'
class UpdateVisitCountry
	attr_reader :visit_track
	def self.perform(id)
		@visit_track = VisitTrack.find_by_id(id)
		return unless @visit_track.present?

		begin
			response = JSON.parse(open("https://www.iplocate.io/api/lookup/"+@visit_track.ip).read)
			if response.present? && response["country"].present?
				@visit_track.update_column("country", response["country"])
			end
		rescue
			puts "Country is  not updated"
		end
  end
end