# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

if Gem::VERSION >= "1.3.6"
  module Rails
    class GemDependency
      def requirement
        r = super
        (r == Gem::Requirement.default) ? nil : r
      end
    end
  end
end  

DEFAULT_TIME_ZONE = 'uk'

Rails::Initializer.run do |config|
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  config.frameworks -= [ :action_mailer, :active_resource ]

  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Kyev' 

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = DEFAULT_TIME_ZONE.to_sym
end

date_time_formats = {
  :day_month_year => '%d-%m-%y',
  :day_month_year_with_time => '%H:%M %d-%m-%y',
  :with_time => '%H:%M'
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(date_time_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(date_time_formats)

require "#{Rails.root}/lib/utils.rb"
require "#{Rails.root}/lib/routing.rb"
require "#{Rails.root}/lib/transliterate.rb"

Haml::Template::options[:ugly] = true if Rails.env == 'production'

$KCODE = 'u'
require 'jcode'

WillPaginate::ViewHelpers.pagination_options[:previous_label] = I18n.t('prev_page')
WillPaginate::ViewHelpers.pagination_options[:next_label] = I18n.t('next_page')
WillPaginate::ViewHelpers.pagination_options[:first_label] = I18n.t('first_page')
WillPaginate::ViewHelpers.pagination_options[:last_label] = I18n.t('last_page')

begin
  require 'unicode'
  String.class_eval  'def downcase
     Unicode::downcase(self)
   end
   def downcase!
     self.replace downcase
   end

   def upcase
     Unicode::upcase(self)
   end
   def upcase!
     self.replace upcase
   end
   def capitalize
     Unicode::capitalize(self)
   end

   def capitalize!
     self.replace capitalize
   end'
rescue LoadError
   puts "NO GEM!!"
end