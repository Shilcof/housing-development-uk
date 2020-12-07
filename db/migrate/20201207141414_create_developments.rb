class CreateDevelopments < ActiveRecord::Migration[6.0]
  def change
    create_table :developments do |t|
      t.string :title
      t.string :content
    end
  end
end
