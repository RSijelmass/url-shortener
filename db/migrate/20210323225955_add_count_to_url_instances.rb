class AddCountToUrlInstances < ActiveRecord::Migration[6.0]
  def change
    add_column :url_instances, :count, :integer, default: 0
  end
end
