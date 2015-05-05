class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :favgenre, :string
  end
end
