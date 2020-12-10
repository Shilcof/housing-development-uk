class CreateFollowerDevelopers < ActiveRecord::Migration[6.0]
  def change
    create_table :follower_developers do |t|
      t.integer :follower_id
      t.integer :developer_id
    end
  end
end
