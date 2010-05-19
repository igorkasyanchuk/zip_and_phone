class R < ActiveRecord::Base
  default_scope :order => 'name_uk'
  belongs_to :o
  has_many :ms
  def name
    self.send("name_#{I18n.locale}")
  end
end
