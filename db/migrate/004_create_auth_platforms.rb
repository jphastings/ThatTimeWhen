class CreateAuthPlatforms < ActiveRecord::Migration
  def self.up
    create_table :auth_platforms do |table|
      table.integer :user_id
      table.string  :provider
      table.string  :uid

      table.timestamps
    end
  end
  
  def self.down
    drop_table :auth_platforms
  end
end