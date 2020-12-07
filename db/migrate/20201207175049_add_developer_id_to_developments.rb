class AddDeveloperIdToDevelopments < ActiveRecord::Migration[6.0]
  def change
    add_column :developments, :developer_id, :integer
  end
end
