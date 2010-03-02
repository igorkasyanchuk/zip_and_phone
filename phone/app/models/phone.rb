class Phone < ActiveRecord::Base
  include Pacecar
  include TrixyScopes
  default_scope :order => 'name_uk'
  def name
    self.send("name_#{I18n.locale}")
  end
  def to_param
    "#{id}-#{(name  || "").gsub(/[^a-z0-9а-яА-ЯіІїЇєЄ]+/i, '-')}"
  end
end
