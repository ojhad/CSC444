class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.decimal :hours
      t.decimal :amount
      t.datetime :date

      t.timestamps
    end
  end
end
