class Link < ActiveRecord::Base
  named_scope :random_3, :limit => 3, :order => 'rand()'
  def url
    self.send("url_#{I18n.locale}")
  end  
  def title
    self.send("title_#{I18n.locale}")
  end
end
