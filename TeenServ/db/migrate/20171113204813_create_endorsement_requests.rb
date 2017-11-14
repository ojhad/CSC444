class CreateEndorsementRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :endorsement_requests do |t|
      t.references :user
      t.references :invitee
      t.timestamps
    end
    add_foreign_key :endorsement_requests, :users, column: :user_id, primary_key: :id
    add_foreign_key :endorsement_requests, :users, column: :invitee_id, primary_key: :id
  end
end
