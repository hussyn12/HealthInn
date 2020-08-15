class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :publish
      t.string :categories
      t.datetime :published_at
      t.references :moderator, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
