class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.string :image
      t.integer :topic_id
      t.integer :comment_id

      t.timestamps
    end
  end
end