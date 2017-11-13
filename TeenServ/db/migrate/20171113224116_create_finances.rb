class CreateFinances < ActiveRecord::Migration[5.1]
  def change
    create_table :finances do |t|

      t.string :year
      t.string :month
      t.float :amount
      
      t.timestamps
    end
  end
end
