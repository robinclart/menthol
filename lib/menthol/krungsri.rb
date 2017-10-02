require "menthol/provider"

module Menthol
  class Krungsri < Provider
    private

    def login_url
      "https://www.krungsrionline.com/BAY.KOL.WebSite/Common/Login.aspx"
    end

    def login
      submit_credentials({
        username: "ctl00$cphForLogin$username",
        password: "ctl00$cphForLogin$password",
        button:   browser.input(name: "ctl00$cphForLogin$lbtnLoginNew")
      })
    end

    def find_amount(name)
      case name
      when "Savings" then savings
      when "LTF"     then ltf
      end
    end

    def logout
      button = browser.link(class: ["header_logout", "menu_link_progress"])
      button.click
      button.wait_while_present
    end
  end

  def savings
    cell = browser.div(css: ".myport_table_column_3 .amc")
    cell.text
  end

  def ltf
    cell = browser.div(css: ".myport_table_column_3_4 .amc")
    cell.text
  end
end
