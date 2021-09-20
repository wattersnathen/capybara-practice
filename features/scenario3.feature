Feature: Terms of Use

    Background:
        Given Open the app url
        When user clicks "TERMS OF USE"
    
    Scenario: Terms of Use page can be displayed
        Then date is up to date

    Scenario: Terms of Use can be viewed in multiple languages
        When user clicks on the language drop-down
        Then drop-down should contain
            | Français |Deutsch | 中文 | 日本語 | Español | Italiano |
