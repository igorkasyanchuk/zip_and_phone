class CreateOs < ActiveRecord::Migration
  def self.up
    create_table :os do |t|
      t.string :name_uk
      t.string :name_en
      t.string :name_ru
    end
    add_index :os, :id
  end

  def self.down
    remove_index :os, :name
    drop_table :os
  end
end
