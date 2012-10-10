class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |table|
      table.string  :display_name
      table.string  :email
      table.boolean :anonymous_by_default, :default => true
      table.string  :locale, :default => 'en_GB'

      table.timestamps
    end
  end
  
  def self.down
    drop_table :users
  end
end