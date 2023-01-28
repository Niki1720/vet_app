class AddUserIdToAnimals < ActiveRecord::Migration[7.0]
  def change
    add_column :animals, :user_id, :int
  end
end
