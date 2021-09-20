Feature: Forgot Password

    Background:
        Given Open the app url
        When user clicks forgot password

    Scenario: Email should be required when submitting reset password form
        When user submits forgot password form with email ""
        Then form validation error is presented to the user "Error: Email address required"
    
    Scenario: Email should be a valid format when submitted reset password form
        When user submits forgot password form with email "abcd"
        Then form validation error is presented to the user "Error: Invalid email address"