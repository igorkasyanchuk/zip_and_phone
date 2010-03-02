class AddLinksIndex < ActiveRecord::Migration
  def self.up
  	add_index :links, :id
  end

  def self.down
  	remove_index :links, :id
  end
end
