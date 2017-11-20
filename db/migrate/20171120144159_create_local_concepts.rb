class CreateLocalConcepts < ActiveRecord::Migration
  def change
    create_table :local_concepts do |t|

      t.timestamps null: false
    end
  end
end
