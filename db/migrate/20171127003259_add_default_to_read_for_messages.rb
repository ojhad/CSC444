class AddDefaultToReadForMessages < ActiveRecord::Migration[5.1]
  def change
    change_column_default :messages, :read, false
  end
end
