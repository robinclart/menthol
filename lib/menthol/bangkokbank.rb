require "menthol/provider"
require "menthol/account"

module Menthol
  class Bangkokbank < Provider
    private

    def login_url
      "https://ibanking.bangkokbank.com/SignOn.aspx"
    end

    def login
      submit_credentials({
        username: "txtID",
        password: "txtPwd",
        button:   browser.input(name: "btnLogOn"),
      })
    end

    def find_amount(name)
      case name
      when "Savings"
        cell = browser.span(id: "ctl00_ctl00_C_CW_gvDepositAccts_ctl02_lblAcctAvailBal").wait_until_present
        cell.text
      end
    end

    def logout
      button = browser.link(href: "javascript:IMG2_onclick();")
      button.click
      button.wait_while_present
    end
  end
end