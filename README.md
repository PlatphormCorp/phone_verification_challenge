# README

Thank you for taking the time to complete our coding challenge!  The challenge has two parts:
* A coding challenge
* Follow-up Questions

## Coding Challenge

Please start by forking this repository. When you are ready to submit your code please submit a PR that includes any setup instructions that may be required.

Everclear has an API that takes a US or Canadian telephone number and sends it a text message if it is a valid mobile number.  The URL can be found in your invitation email.

The API accepts the following parameters:
```
client: Please use 'PhoneVerificationChallenge'
authorization_code: Provided via email with your challenge invitation
phone_number: Please provide as a 10 digit number, i.e. '8451231234'
message: Any string, note that messages longer than 160 characters are split up into multiple messages
```

## Task Requirements
Feel free to spend as much or as little time on the exercise as you like as long as the following requirements have been met.

* Please complete the task described below.
* Feel free to persist data however you like.  This project is configured to use SQLite if you need a database.
* Please include some tests. Complete test coverage is not required.
 
## Task Description
As a user of the application I would like to verify with Everclear that my phone number belongs to me, and that I am able to receive text messages from the Everclear service. I would also like to receive confirmation from Everclear when my phone number has been verified.

### Acceptance Criteria
* Users who provide a valid phone number receive a text message with verification instructions.
* Users are informed when their phone number has been verified.

## Followup Questions
Please answer the following questions when you submit your code:

* How long did you spend on the coding challenge?
* What would you add to your solution if you had more time? Note - you should feel free to add comments in the code to point out these opportunities as well .

## Setup Instructions

This is a standard Rails 7 application with a SQLite DB and rspec installed.  We've provided a basic view which isn't hooked up to anything to get you started. 