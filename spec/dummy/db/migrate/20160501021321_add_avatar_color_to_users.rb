class AddAvatarColorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_dominant_color, :string
  end
end
