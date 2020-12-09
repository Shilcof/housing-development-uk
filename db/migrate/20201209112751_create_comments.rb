class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :development_id
      t.string :body
      t.integer :rating
    end
  end
end
