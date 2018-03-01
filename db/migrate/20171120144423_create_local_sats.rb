class CreateLocalSats < ActiveRecord::Migration
  def change
    create_table :local_sats do |t|
      t.string :RXCUI
      t.string :LUI
      t.string :SUI
      t.string :RXAUI
      t.string :STYPE
      t.string :CODE
      t.string :ATUI
      t.string :SATUI
      t.string :ATN
      t.string :SAB
      t.string :ATV
      t.string :SUPPRESS
      t.string :CVF
      t.timestamps null: false
    end
  end
end
