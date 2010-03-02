class Contact < ActiveRecord::Base
  default_scope :order => 'contacts.created_at DESC' 
  named_scope :pending, :conditions => { :archived => false }
  named_scope :archive, :conditions => { :archived => true }
  
  validates_presence_of :name
  validates_presence_of :body
  validates_presence_of :email
  
  def archive!
    self.archived = true
    self.save
  end
  
  def archived?
    self.archived
  end
  
end
