class RemovePaypalFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users , :paypal
  end
end
