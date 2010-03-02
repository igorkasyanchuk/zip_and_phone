# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  self.allow_forgery_protection = true
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :ssl_required?
  helper_method :set_locale
  helper_method :available_locales
  before_filter :set_locale
  
  def available_locales
    AVAILABLE_LOCALES
  end
  
  def set_locale
    locale = params[:locale] || cookies[:locale]
    I18n.locale = locale.to_s
    cookies[:locale] = locale unless (cookies[:locale] && cookies[:locale] == locale)
  end
  
  def default_url_options(options={})
    { :locale => I18n.locale } 
  end
  
  def self.add_pagination!(pages = 10)
    class_eval %(
      protected
        def collection
          get_collection_ivar || set_collection_ivar(end_of_association_chain.paginate(:page => params[:page], :per_page => #{pages}))
        end)
  end
  
end
