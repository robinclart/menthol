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

    def find_amount(type)
      case type
      when :savings then savings
      when :ltf     then ltf
      end
    end

    def logout
      button = browser.link(href: "javascript:IMG2_onclick();")
      sleep 1
      button.click
      button.wait_while_present
    end

    def savings
      browser.goto("https://ibanking.bangkokbank.com/workspace/16AccountActivity/wsp_AccountSummary_AccountSummaryPage.aspx")
      cell = browser.span(id: "ctl00_ctl00_C_CW_gvDepositAccts_ctl02_lblAcctAvailBal").wait_until_present
      cell.text
    end

    def ltf
      browser.goto("https://ibanking.bangkokbank.com/workspace/05Investment/wsp_Investment_TC.aspx")
      sleep 1
      button = browser.input(type: "submit", name: "ctl00$ctl00$C$CW$btnAccept")
      button.click
      button.wait_while_present
      row  = browser.tr(css: "#ctl00_ctl00_C_CW_pnlMain .RowMFGridViewAll")
      cell = row[6]
      cell.text
    end
  end
end
