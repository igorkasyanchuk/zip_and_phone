class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :name_uk
      t.string :name_ru
      t.string :name_en
      t.string :code
      t.string :information
      t.string :help
    end
    add_index :phones, :id
  end

  def self.down
    remove_index :phones, :id
    drop_table :phones
  end
end
