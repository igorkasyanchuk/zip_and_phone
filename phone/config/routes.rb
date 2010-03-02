ActionController::Routing::Routes.draw do |map|
  map.filter 'locale'
  map.resources :phones
  map.resources :contacts, :only => [:new, :create, :destroy, :index], :controller => 'feedback'
  map.resources :feedbacks, :only => [:new, :create, :destroy, :index], :controller => 'feedback'
  map.root :controller => 'home', :action => 'index'
  map.site_map '/site_map', :controller => 'sitemap', :action => 'seo_site_map'
  map.connect "sitemap.xml", :controller => "sitemap", :action => "sitemap", :format => 'xml'
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'   
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format' 
  map.connect '*path', :controller => 'home', :action => 'index'
end
