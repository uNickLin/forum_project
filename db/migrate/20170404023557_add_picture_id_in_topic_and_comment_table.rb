class AddPictureIdInTopicAndCommentTable < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :picture_id, :integer
    add_column :comments, :picture_id, :integer
  end
end
