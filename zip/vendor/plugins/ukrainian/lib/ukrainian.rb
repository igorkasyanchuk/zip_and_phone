require File.join(File.dirname(__FILE__), 'ukrainian/backend/simple')
require 'i18n'

module Ukrainian
  extend self

  def init_i18n
    I18n.load_path.unshift(*locale_files)
  end

  protected
  def locale_path
    File.join(File.dirname(__FILE__), 'ukrainian', 'locale', '**/*')
  end

  def locale_files
    Dir[locale_path]
  end
end

Ukrainian.init_i18n
