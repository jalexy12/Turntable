class AddInroomToUser < ActiveRecord::Migration
  def change
    add_column :users, :inroom, :boolean
  end
end
