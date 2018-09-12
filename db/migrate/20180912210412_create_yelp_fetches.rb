class CreateYelpFetches < ActiveRecord::Migration[5.2]
  def change
    create_table :yelp_fetches do |t|
      t.string :location
      t.string :search_term

      t.timestamps
    end
  end
end
