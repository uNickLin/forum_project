class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :topic_id, :index => true
      t.integer :user_id, :index => true
      t.timestamps
    end
  end
end
