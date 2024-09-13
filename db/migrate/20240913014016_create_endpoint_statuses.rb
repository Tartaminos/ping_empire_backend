class CreateEndpointStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :endpoint_statuses do |t|
      t.references :endpoint, null: false, foreign_key: true
      t.datetime :request_sent_date
      t.datetime :request_return_date
      t.string :status

      t.timestamps
    end
  end
end
