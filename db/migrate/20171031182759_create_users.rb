class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, primary_key: :user_id do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
