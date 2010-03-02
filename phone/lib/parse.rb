$KCODE = 'UTF8'

require "rubygems"
require 'yaml'
require 'ya2yaml'
require 'google_translate'
require '../config/environment.rb'


def save_file(fnm, h)
  File.open(fnm, 'w') do |out|
    out.write h.ya2yaml
  end
end

def load_file(fnm)
  YAML::load_file(fnm)
end

@converter = Iconv.new('UTF-8', '866')

file = File.open("KOD.txt", 'r')
lines = file.readlines
puts "Total: #{lines.size}"

t = Google::Translator.new

cities = lines.collect{|info| info.split("|")[0]}.flatten.compact.uniq
puts cities.first
puts "Cities: #{cities.size}"

translation_hash = {
  :uk => {},
  :en => {}
}

if false
  n = 0
  cities.in_groups_of(25).each do |cinfo|
    q = cinfo.join("|")
    puts q
    uk = t.translate('ru', 'uk', q).strip.split("|")
    en = t.translate('ru', 'en', q).strip.split("|")
    cinfo.each_with_index do |city, index|
      city = cinfo[index]
      next if city.nil?
      city_uk = uk[index]
      city_en = en[index]
      city_uk = city if city_uk.nil?
      city_en = city if city_en.nil?
      city_uk.gsub!("|", '')
      city_en.gsub!("|", '')
      translation_hash[:uk][city] = city_uk
      translation_hash[:en][city] = city_en
    end
    n+=20
    puts 100 * (n+0.0)/cities.size
  end
  save_file('phones.txt', translation_hash)
end

translation_hash = load_file('phones.txt')

Phone.destroy_all

index = 0
lines.each do |line|
  info = line.split("|")
  city_name = info[0].strip.gsub("|", '')
  code = info[1].strip.gsub("|", '')
  inf = info[2].strip.gsub("|", '').split(',')[0]
  help = info[3].strip.gsub("|", '').split(',')[0]
  p = Phone.find_or_create_by_name_ru_and_code city_name, code
  p.name_uk = translation_hash[:uk][city_name]
  p.name_en = translation_hash[:en][city_name]
  p.information = inf
  p.help = help
  p.save
  puts 100 * (index+0.0)/lines.size if (index%10 == 0)
  index += 1 
end