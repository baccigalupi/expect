require "delegate"
require "forwardable"

require "minitest"

require "expectorant/version"
require "expectorant/expect"
require "expectorant/expector"
require "expectorant/resolver"
require "expectorant/asserter"
require "expectorant/registrar"
require "expectorant/assertion/proximal"
require "expectorant/assertion/equalizer"
require "expectorant/assertion/existential"
require "expectorant/assertion/collector"
require "expectorant/assertion/typetastic"
require "expectorant/assertion/matcher"
require "expectorant/assertion/comparitor"
require "expectorant/assertion/cambiarse"

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
    register :equal, :equals, :==,       Assertion::Equalizer
    register :exist, :exists,            Assertion::Existential
    register :empty, :include, :contain, Assertion::Collector
    register :within, :close_to,         Assertion::Proximal
    register :instance_of, :an, :a,      Assertion::Typetastic
    register :match, :matches,           Assertion::Matcher
    register :change, :by,               Assertion::Cambiarse
    register :greater_than, :greater_than_or_equal,
             :>, :>=,
             :less_than, :less_than_or_equal,
             :<, :<=,                    Assertion::Comparitor
  end
end

Expectorant.register_defaults
