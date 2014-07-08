module Expectorant
  def self.register *args
    klass = args.last
    keys = args[0...-1]
    registrar.add(keys, klass)
  end

  def self.registrar
    @registrar ||= Registrar.new
  end

  def self.register_defaults
    register :equal, :equals, :==,       Asserter::Equalizer
    register :exist, :exists,            Asserter::Existential
    register :empty, :include, :contain, Asserter::Collector
    register :within, :close_to,         Asserter::Proximal
    register :instance_of, :an, :a,      Asserter::Typetastic
    register :match, :matches,           Asserter::Matcher
    register :change,                    Asserter::Cambiarse
    register :greater_than, :greater_than_or_equal,
             :>, :>=,
             :less_than, :less_than_or_equal,
             :<, :<=,                    Asserter::Comparitor
  end
end

Expectorant.register_defaults
