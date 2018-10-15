require "menthol/provider"
require "menthol/account"

module Menthol
  class UOB < Provider
    private

    def login_url
      "https://pib.uobthailand.com/PIBLogin/Public/processPreCapture.do?keyId=lpc&lang=en_TH"
    end

    def login
      sleep 1
      submit_credentials({
        username: "userName",
        password_locator: :id,
        password: "PASSWORD1",
        button:   browser.button(id: "btnSubmit"),
      })
    end

    def find_amount(type)
      case type
      when :savings then savings
      end
    end

    def logout
      button = browser.link(href: /logout\.do/)
      sleep 1
      button.click
      button.wait_while_present
    end

    def savings
      row  = browser.div(class: "account-summary-tables")
      cell = browser.span(class: ["currency", "small-cr"]).wait_until_present
      cell.text.to_s.delete(" ")
    end
  end
end
