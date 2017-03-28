class AbandonLatestCommentAddLatestCommentTimeColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :latest_comment_time, :date
  end
end
