# Menthol

**Warning**: This project is a work in progress.

Menthol is a web scraper that fetch your Thai bank account balances and sum
them for you in your terminal.

Store your configuration under `~/.mentholrc` and run with `exe/mentholrc sync`.

Here's a sample `~/.mentholrc` configuration file:

    - provider: Krungsri
      accounts:
        - name: Savings
          currency: THB
      username: johndoe
      password: 1dk49fncH93JsKKJ8

    - provider: Local
      name: LH Bank
      accounts:
        - name: Fixed
          amount: 10000000
          currency: THB

This library currently support:

  - Krungsri
  - Bangkokbank
  - Kasikornbank
  - Local (the amount must be given in the configuration file as the
    smallest currency subunit)

You'll need to instal the `watir` gem. You'll also need Chrome installed and
`chrome-webdriver` somewhere on your PATH.

TODO:

  - store accounts in redis
  - add web server to display balances and their history
