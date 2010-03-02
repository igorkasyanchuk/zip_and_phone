class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :url_uk, :length => 500
      t.string :url_ru, :length => 500
      t.string :url_en, :length => 500
      t.string :title_uk
      t.string :title_ru
      t.string :title_en
    end
  end

  def self.down
    drop_table :links
  end
end
