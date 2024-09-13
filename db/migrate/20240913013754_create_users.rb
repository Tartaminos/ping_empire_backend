class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :user_active, default: true
      t.datetime :last_login

      t.timestamps
    end
  end
end
