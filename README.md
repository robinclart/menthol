# Menthol

**Warning**: This project is a work in progress.

Install with:

```
gem install menthol
```

Menthol is a web scraper that fetch your Thai bank account balances and sum
them for you in your terminal.

Store your configuration under `~/.mentholrc` and run with `menthol fetch`.

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

You'll also need Chrome installed and [chrome-webdriver][1] somewhere on
your PATH.

If you run on a linux box in only a terminal you can install the optional `headless` gem and let it run without the need for a screen to be attached.

[1]: https://sites.google.com/a/chromium.org/chromedriver/downloads
