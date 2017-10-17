class DropPeopleTable < ActiveRecord::Migration[5.1]
  def change
  	remove_reference :reviews, :person
  	drop_table :people
  	add_reference :reviews, :user, foreign_key: true 
  end
end
