class DropTopicAndCommentPitureIdColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :picture_id
    remove_column :comments, :picture_id
  end
end
