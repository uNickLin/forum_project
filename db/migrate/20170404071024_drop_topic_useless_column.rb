class DropTopicUselessColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :topics, :latest_comment
  end
end
