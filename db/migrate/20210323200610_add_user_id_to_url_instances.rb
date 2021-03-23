class AddUserIdToUrlInstances < ActiveRecord::Migration[6.0]
  def change
  add_column :url_instances, :user_id, :integer
  add_index  :url_instances, :user_id
  end
end
