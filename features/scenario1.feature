Feature: Scenario 1

    Scenario: User is not granted access when invalid credentials are presented
        Given Open the app url
        When user fills out login form with credentials
            | email | password |
            | "bad_email@example" | "bad_password" |
        Then user is presented with an error message
        
