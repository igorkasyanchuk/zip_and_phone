module I18n
  module Backend
    class Simple
      protected
      def pluralize(locale, entry, count)
        return entry unless entry.is_a?(Hash) and count        
        key = :zero if count == 0 && entry.has_key?(:zero)
        locale_pluralize = lookup(locale, :pluralize)
        if locale_pluralize && locale_pluralize.respond_to?(:call)
          key ||= locale_pluralize.call(count)
        else
          key ||= default_pluralizer(count)
        end
        raise InvalidPluralizationData.new(entry, count) unless entry.has_key?(key)
        entry[key]
      end

      def default_pluralizer(count)
        count == 1 ? :one : :other
      end
    end
  end
end

