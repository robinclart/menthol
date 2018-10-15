require "money"

module Menthol
  class Account
    def initialize(provider, name, amount, type, currency)
      @provider = provider
      @name     = name
      @type     = type.to_sym
      @currency = Money::Currency.find(currency)
      @amount   = Money.new(amount || 0, @currency.iso_code)
    end

    def self.open(provider, configuration)
      new(
        provider,
        configuration["name"],
        configuration["amount"],
        configuration["type"],
        configuration["currency"]
      )
    end

    attr_reader :provider

    attr_reader :name

    attr_reader :type

    attr_reader :amount

    attr_reader :currency

    def parse_amount(raw_amount)
      amount          = raw_amount.gsub(/[^\d\.]/, "").to_f
      amount_subunit  = amount * @currency.subunit_to_unit

      @amount = Money.new(amount_subunit, @currency.iso_code)
    end
  end
end
