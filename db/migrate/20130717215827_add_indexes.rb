class AddIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :user_id
    add_index :comments, :link_id
    add_index :comments, :parent_comment_id
    add_index :link_subs, :link_id
    add_index :link_subs, :sub_id
    add_index :links, :user_id
    add_index :subs, :moderator
    add_index :user_votes, :user_id
    add_index :user_votes, :link_id
    add_index :user_votes, :updown
  end
end
