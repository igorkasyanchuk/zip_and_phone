$KCODE = 'UTF8'

require "rubygems"
require 'yaml'
require 'ya2yaml'
require 'google_translate'
require '../config/environment.rb'

Phone.all.each do |o|
  o.name_uk = o.name_uk.strip.gsub('- ', '-').gsub(' -', '-')
  o.name_en = o.name_en.strip.gsub('- ', '-').gsub(' -', '-')
  o.name_ru = o.name_ru.strip.gsub('- ', '-').gsub(' -', '-')
  o.save
end