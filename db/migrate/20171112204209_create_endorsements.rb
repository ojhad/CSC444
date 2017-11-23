class CreateEndorsements < ActiveRecord::Migration[5.1]
  def change
    create_table :endorsements do |t|
      t.text :body
      t.integer :author_id
      t.timestamps
    end
    add_reference :endorsements, :user, foreign_key: true
  end
end


