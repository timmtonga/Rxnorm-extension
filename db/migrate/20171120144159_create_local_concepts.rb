class CreateLocalConcepts < ActiveRecord::Migration
  def change
    create_table :local_concepts do |t|
      t.string :RXCUI
      t.string :LAT
      t.string :TS
      t.string :LUI
      t.string :STT
      t.string :SUI
      t.string :ISPREF
      t.string :RXAUI
      t.string :SAUI
      t.string :SCUI
      t.string :SDUI
      t.string :SAB
      t.string :TTY
      t.string :CODE
      t.string :STR
      t.string :SRL
      t.string :SUPPRESS
      t.string :CVF
      t.string :SUI
      t.timestamps null: false
    end
  end
end
