class M < ActiveRecord::Base
  include Pacecar
  default_scope :order => 'name_uk'
  belongs_to :o
  belongs_to :r
  
  def name
    self.send("name_#{I18n.locale}")
  end
  def to_param
    "#{id}-#{(name  || "").gsub(/[^a-z0-9а-яА-ЯіІїЇєЄ]+/i, '-')}"
  end
  def post_index
    unless self.code1.blank?
      unless self.code1 == '-1'
        "#{self.code}-#{self.code1}"
      else
        "#{self.code}"
      end
    else
      "#{self.code}"
    end
  end
  def old_post_index_exists?
    !self.old_code.include?('-1')
  end
  def old_post_index
    unless self.code1.blank?
      if old_post_index_exists?
        "#{self.old_code}-#{self.old_code1}"
      end
    else
      "#{self.old_code}"
    end
  end  
end
