require "menthol/provider"
require "menthol/account"

module Menthol
  class UOBAM < Provider
    private

    def login_url
      "https://echannel.uobam.co.th/fundcyber/Account/Login"
    end

    def login
      sleep 1

      submit_credentials({
        username: "UserName",
        password: "Password",
        button:   browser.button(id: "btnLogin"),
      })

      button = browser.button(id: "btnOkTermCondition")
      browser.scroll.to :bottom
      button.click
      button.wait_while_present
    end

    def find_amount(type)
      case type
      when :ltf then ltf
      end
    end

    def logout
      button = browser.link(href: /logout/)
      sleep 1
      button.click
      button.wait_while_present
    end

    def ltf
      row  = browser.tr(css: "#grid100125031720 tbody tr")
      cell = row[3]
      cell.text
    end
  end
end
