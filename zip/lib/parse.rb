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

file = File.open("index.dat", 'r')
lines = file.readlines
puts "Total: #{lines.size}"

t = Google::Translator.new

obls = lines.in_groups_of(7).collect{|info| info[0].strip}.flatten.compact.uniq
puts "Oblasts: #{obls.size}"
regions = lines.in_groups_of(7).collect{|info| info[1].strip}.flatten.compact.uniq
puts "Regions: #{regions.size}"
cities = lines.in_groups_of(7).collect{|info| info[2].strip}.flatten.compact.uniq
puts "Cities: #{cities.size}"

translation_hash = {
  :ru => {},
  :en => {}
}

if false 
  n = 0
  cities.in_groups_of(20).each do |cinfo|
    q = cinfo.join("|")
    ru = t.translate('uk', 'ru', q).strip.split("|")
    en = t.translate('uk', 'en', q).strip.split("|")
    q.each_with_index do |city, index|
      city = city.strip.gsub("|", '')
      city_ru = ru[index]
      city_en = en[index]
      city_ru = city if city_ru.nil?
      city_en = city if city_en.nil?
      city_ru.gsub!("|", '')
      city_en.gsub!("|", '')
      translation_hash[:ru][city] = city_ru
      translation_hash[:en][city] = city_en
    end
    n+=20
    puts 100 * (n+0.0)/cities.size
  end
  save_file('translations_new2', translation_hash)
end

translation_hash = load_file('translations_new2')

if false
  n = 0
  obls.in_groups_of(10).each do |o|
    q = o.join('|')
    ru = t.translate('uk', 'ru', q).strip.split("|")
    en = t.translate('uk', 'en', q).strip.split("|")
    o.each_with_index do |city, index|
      next if city.nil?
      city = o[index]
      city_ru = ru[index]
      city_en = en[index]
      city_ru = city if city_ru.nil?
      city_en = city if city_en.nil?
      city_ru.gsub!("|", '')
      city_en.gsub!("|", '')
      translation_hash[:ru][city] = city_ru
      translation_hash[:en][city] = city_en
    end
    n+=10
    puts 100 * (n+0.0)/obls.size
  end
  regions.in_groups_of(15).each do |o|
    q = o.join('|')
    ru = t.translate('uk', 'ru', q).strip.split("|")
    en = t.translate('uk', 'en', q).strip.split("|")
    o.each_with_index do |city, index|
      next if city.nil?
      city = o[index]
      city_ru = ru[index]
      city_en = en[index]
      city_ru = city if city_ru.nil?
      city_en = city if city_en.nil?
      city_ru.gsub!("|", '')
      city_en.gsub!("|", '')
      puts "Write with key: *#{city}*"
      puts "city_ru: *#{city_ru}*"
      puts "city_en: *#{city_en}*"
      translation_hash[:ru][city] = city_ru
      translation_hash[:en][city] = city_en
    end
    n+=15
    puts 100 * (n+0.0)/regions.size
  end
  save_file('translations_new_full', translation_hash)
end

translation_hash = load_file('translations_new_full')

#O.destroy_all
#R.destroy_all
#M.destroy_all

index = 0
lines.in_groups_of(7).each do |info|
  obl_name = info[0].strip.gsub("|", '')
  reg_name = info[1].strip.gsub("|", '')
  city_name = info[2].strip.gsub("|", '')
  o = O.find_by_name_uk obl_name
  # if o.nil?
    #   o = O.new
    #   o.name_uk = obl_name
    #   o.name_en = translation_hash[:en][obl_name]
    #   o.name_ru = translation_hash[:ru][obl_name]
    #   o.save
    # end
    puts "reg_name: *#{reg_name}*"
  puts "reg_name en: #{translation_hash[:en][reg_name]}"
  puts "reg_name ru: #{translation_hash[:ru][reg_name]}"
  r = R.find_by_name_uk reg_name
  #if r.nil?
    #r = o.rs.build
    #r.o_id = o.id
    r.name_uk = reg_name
    r.name_en = translation_hash[:en][reg_name]
    r.name_ru = translation_hash[:ru][reg_name]
    r.save
  #end
  # m = r.ms.find_or_create_by_name_uk_and_o_id city_name, o.id
  # m.name_ru = translation_hash[:ru][city_name]
  # m.name_en = translation_hash[:en][city_name]
  # m.code = info[3]
  # m.code1 = info[4]
  # m.old_code = info[5]
  # m.old_code1 = info[6]
  # m.save
   puts 100 * (index+0.0)/lines.size*7 if (index%10 == 0)
   index += 1 
end