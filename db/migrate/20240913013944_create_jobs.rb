class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :endpoint, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :finish_at
      t.string :status

      t.timestamps
    end
  end
end
