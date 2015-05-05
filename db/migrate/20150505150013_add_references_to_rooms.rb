class AddReferencesToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :user, index: true, foreign_key: true
    add_reference :users, :room, index: true, foreign_key: true
  end
end
