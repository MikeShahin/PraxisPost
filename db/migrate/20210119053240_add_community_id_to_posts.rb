class AddCommunityIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :community_id, :integer
  end
end
