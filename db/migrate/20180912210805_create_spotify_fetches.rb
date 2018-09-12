class CreateSpotifyFetches < ActiveRecord::Migration[5.2]
  def change
    create_table :spotify_fetches do |t|
      t.string :business_name
      t.string :artist_name
      t.string :song_name
      t.string :url

      t.timestamps
    end
  end
end