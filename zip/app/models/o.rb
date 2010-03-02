class O < ActiveRecord::Base
  default_scope :order => 'name_uk'
  has_many :rs
  has_many :ms
  def name
    self.send("name_#{I18n.locale}")
  end
  def to_param
    "#{id}-#{(name  || "").gsub(/[^a-z0-9а-яА-ЯіІїЇєЄ]+/i, '-')}"
  end
end
