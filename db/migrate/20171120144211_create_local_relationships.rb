class CreateLocalRelationships < ActiveRecord::Migration
  def change
    create_table :local_relationships do |t|
      t.string :RXCUI1
      t.string :RXAUI1
      t.string :STYPE1
      t.string :REL
      t.string :RXCUI2
      t.string :RXAUI2
      t.string :STYPE2
      t.string :RELA
      t.string :RUI
      t.string :SRUI
      t.string :SAB
      t.string :SL
      t.string :DIR
      t.string :RG
      t.string :SUPPRESS
      t.string :CVF
      t.timestamps null: false
    end
  end
end
