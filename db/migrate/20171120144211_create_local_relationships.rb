class CreateLocalRelationships < ActiveRecord::Migration
  def change
    create_table :local_relationships do |t|

      t.timestamps null: false
    end
  end
end
