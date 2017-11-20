class CreateSearchItems < ActiveRecord::Migration
  def change
    create_table :search_items, primary_key: :search_item_id do |t|
      t.integer :job_id, null: false
      t.string :search_term, null: false
      t.string :potential_matches
      t.string :confirmed_matches
      t.string :status, null: false
      t.timestamps null: false
    end
  end
end
