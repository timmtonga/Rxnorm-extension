class CreateLocalSats < ActiveRecord::Migration
  def change
    create_table :local_sats do |t|

      t.timestamps null: false
    end
  end
end
