class AddInfoToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :info, :string
  end
end
