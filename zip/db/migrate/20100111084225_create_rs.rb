class CreateRs < ActiveRecord::Migration
  def self.up
    create_table :rs do |t|
      t.string :name_uk
      t.string :name_en
      t.string :name_ru
      t.integer :o_id
    end
    add_index :rs, :o_id
  end

  def self.down
  	remove_index :rs, :o_id
    drop_table :rs
  end
end
