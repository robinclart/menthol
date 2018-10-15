require "menthol/provider"
require "menthol/account"

module Menthol
  class Kasikornbank < Provider
    private

    def login_url
      "https://online.kasikornbankgroup.com/K-Online/login.jsp?lang=en&type="
    end

    def login
      submit_credentials({
        username: "userName",
        password: "password",
        button:   browser.button(id: "loginBtn"),
      })
    end

    def find_amount(type)
      case type
      when :savings
        frame = browser.iframe(id: "ssoIFrame1")
        cell  = frame.element(class: "inner_table_right").wait_until_present
        cell.text
      end
    end

    def logout
      button = browser.span(text: "Logout")
      button.click
      browser.alert.ok
      button.wait_while_present
    end
  end
end
