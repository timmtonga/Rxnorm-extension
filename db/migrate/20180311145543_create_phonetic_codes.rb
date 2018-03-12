class CreatePhoneticCodes < ActiveRecord::Migration
  def change
    create_table :phonetic_codes do |t|
      t.string :RXCUI
      t.string :RXAUI
      t.text :STR
      t.text :soundex
      t.timestamps null: false
    end
  end
end
