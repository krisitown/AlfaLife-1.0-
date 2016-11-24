class AddViewsAndImageToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :views, :integer
    add_column :videos, :thumbnail, :string
  end
end
