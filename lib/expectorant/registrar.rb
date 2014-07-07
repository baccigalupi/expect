module Expectorant
  class Registrar
    def add(keys, klass)
      cache << Finder.new(keys.map(&:to_sym), klass)
    end

    def cache
      @cache ||= []
    end

    def clear
      cache.clear
    end

    def get(key)
      match = cache.reverse.detect{|finder| finder.match?(key)}
      match && match.klass
    end

    def keys
      cache.map(&:keys).flatten
    end

    class Finder < Struct.new(:keys, :klass)
      def match?(key)
        keys.include?(key.to_sym)
      end
    end
  end
end
