class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id
      t.integer :link_id
      t.boolean :updown

      t.timestamps
    end
  end
end
