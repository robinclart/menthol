require "menthol/provider"
require "menthol/account"

module Menthol
  class Kasikornbank < Provider
    private

    def login_url
      "https://online.kasikornbankgroup.com/K-Online/preLogin/popupPreLogin.jsp?lang=en&type="
    end

    def skip_login_popup
      button = browser.input(css: "div[align=center] input")
      button.wait_until_present
      button.click
      button.wait_while_present
    end

    def login
      skip_login_popup
      submit_credentials({
        username: "userName",
        password: "password",
        button:   browser.image(name: "loginBtn"),
      })
    end

    def find_amount(name)
      case name
      when "Savings"
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
