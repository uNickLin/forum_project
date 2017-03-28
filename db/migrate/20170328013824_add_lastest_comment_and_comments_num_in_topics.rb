class AddLastestCommentAndCommentsNumInTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :latest_comment, :integer
    add_column :topics, :comments_num, :integer
  end
end
