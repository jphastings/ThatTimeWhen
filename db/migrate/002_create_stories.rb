class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |table|
      table.integer :user_id
      
      table.string  :title
      table.text    :body
      table.boolean :draft, :default => true
      table.boolean :anonymous, :default => true
      table.integer :flagged, :default => 0

      table.timestamps
    end
  end
  
  def self.down
    drop_table :stories
  end
end