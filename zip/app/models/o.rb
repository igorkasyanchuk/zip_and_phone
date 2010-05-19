class O < ActiveRecord::Base
  default_scope :order => 'name_uk'
  has_many :rs
  has_many :ms
  def name
    self.send("name_#{I18n.locale}")
  end
end
