class AddAvatarDimensionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_height, :integer
    add_column :users, :avatar_width, :integer
  end
end
