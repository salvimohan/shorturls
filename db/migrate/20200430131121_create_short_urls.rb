class CreateShortUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :short_urls do |t|
      t.text :url
      t.string :url_short_code
      t.timestamps
    end
  end
end
