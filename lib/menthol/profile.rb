require "yaml"
require "money"

module Menthol
  class Profile
    def initialize(providers)
      @providers = providers
    end

    attr_reader :providers

    def self.configure(config_file_path)
      configuration = YAML.load(File.read(config_file_path))

      providers = configuration.map do |c|
        Menthol.const_get(c["provider"]).new(
          c["name"],
          c["username"],
          c["password"],
          c["accounts"]
        )
      end

      new(providers)
    end

    def sync_all!
      @providers.each(&:sync!)
    end

    def amount
      @providers.map(&:amount).reduce(Money.new(0, "THB"), &:+)
    end
  end
end
