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
It took me about 3-4 hours.  I took my time and thought a few things through and went back and forth on names and routes.  I was having some real fun with it until I looked up at the clock.

I spent a bit of time grooming the commit log too.  I really believe in organized commits that leave a paper trail that link back to whatever project management software you are using. It helps future readers undertand context and why some decisions were made.  Future me always wants to ask past me questions, but that's impossible, so  a good paper trail is the next best thing.
* What would you add to your solution if you had more time? Note - you should feel free to add comments in the code to point out these opportunities as well .
I really would have liked to take the time to use Turbo. I disabled Turbo for the sake of getting all the work done in a timely manner.  I've been real curious aobut it and have played with it before, but I definitely would not have been able to get this done in a timely manner if I decided to try to use it. I suspect using Turbo frames to mount all the views would have made for a slick SPA experience.

I also would have liked to interview whoever the product owner should have been for this feature so I could nail down some more desired behaviors instead of making stuff up and leaving the user on the verification page at the end.

On the testing side of things it would have been great to take the time to get FactoryBot set up. I suspect I would have been a bit quicker if I set up FactoryBot instead of struggling to remember how to make a valid instance of a Model on the fly.
Some end to end test would have been great too in order to show off how I think when I test UIs and workflows. For example, it would have shown how I target what I think are the most important parts of a happy and sad path workflows with keeping in mind how the end to end tests I write affect the speed of the test suite.  No one likes extremely long build times that lead to ridiculous pull request cycles.

## Setup Instructions

This is a standard Rails 7 application with a SQLite DB and rspec installed.  We've provided a basic view which isn't hooked up to anything to get you started.

If you would like to modify the encrypted secrets, please see
aabhay@pm.me for the RAILS_MASTER_KEY environment variable value.
