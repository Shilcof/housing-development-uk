class CreateDevelopments < ActiveRecord::Migration
  def change
    create_table :developments do |t|
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
