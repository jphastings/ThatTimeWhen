class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |table|
      table.integer :user_id
      table.integer :story_id

      table.timestamps
    end
  end
  
  def self.down
    drop_table :likes
  end
end