class CreateVisitTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_tracks do |t|
      t.string :ip
      t.string :country
      t.integer :visits_count, :default => 0
      t.integer :short_url_id
      t.timestamps
    end
  end
end
