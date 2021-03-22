class CreateUrlInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :url_instances do |t|
      t.string :longhand
      t.string :shorthand

      t.timestamps
    end
  end
end
