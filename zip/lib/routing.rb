require 'routing_filter/base'

module RoutingFilter
  class Locale < Base

    # remove the locale from the beginning of the path, pass the path
    # to the given block and set it to the resulting params hash
    def around_recognize(path, env, &block)
      locale = nil
      path.sub! %r(^/([a-zA-Z]{2})(?=/|$)) do locale = $1; '' end
      returning yield do |params|
        params[:locale] = locale || DEFAULT_TIME_ZONE
      end
    end

    def around_generate(*args, &block)
      locale = args.extract_options!.delete(:locale) || DEFAULT_TIME_ZONE
      returning yield do |result|
        if locale != DEFAULT_TIME_ZONE
          result.sub!(%r(^(http.?://[^/]*)?(.*))){ "#{$1}/#{locale}#{$2}" }
        end 
      end
    end

  end
end