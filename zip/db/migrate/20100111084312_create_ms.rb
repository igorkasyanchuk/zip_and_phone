class CreateMs < ActiveRecord::Migration
  def self.up
    create_table :ms do |t|
      t.string :name_uk
      t.string :name_en
      t.string :name_ru
      t.integer :o_id
      t.integer :r_id
      t.string :code
      t.string :code1
      t.string :old_code
      t.string :old_code1
    end
    add_index :ms, :o_id
    add_index :ms, :r_id
    add_index :ms, [:o_id, :r_id]
  end

  def self.down
    remove_index :ms, :o_id
    remove_index :ms, :r_id
    remove_index :ms, [:o_id, :r_id]
    drop_table :ms
  end
end
