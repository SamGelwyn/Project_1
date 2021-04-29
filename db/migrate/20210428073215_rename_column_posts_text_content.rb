class RenameColumnPostsTextContent < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :text, :content
  end
end
