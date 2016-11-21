require "money"
require "menthol/provider"

module Menthol
  class Provider
    def initialize(name, username, password, accounts)
      @name     = name
      @username = username
      @password = password
      @accounts = accounts.map { |a| Account.open(self.name, a) }
    end

    attr_reader :accounts

    def name
      @name || self.class.name.split("::").last
    end

    def amount
      @accounts.map(&:amount).reduce(Money.new(0, "THB"), &:+)
    end

    def sync!
      browser.goto(login_url)

      login
      synchronize_accounts
      logout

      browser.quit
      @browser = nil
    end

    private

    def submit_credentials(username:, password:, button:)
      browser.text_field(name: username).set(@username)
      browser.text_field(name: password).set(@password)
      button.click
      button.wait_while_present
    end

    def browser
      @browser ||= Watir::Browser.new(:chrome)
    end

    def login
      raise NotImplementedError
    end

    def synchronize_accounts
      @accounts.each do |account|
        account.parse_amount(find_amount(account.name))
      end
    end

    def logout
      raise NotImplementedError
    end
  end
end
