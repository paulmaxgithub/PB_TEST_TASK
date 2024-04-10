# Coding Challenge

✅ - DONE / ☑️ - TODO / ❓ - MORE INFORMATION REQUIRED

✅ A new App named **WorldOfPAYBACK** is planned to be released. One of its first features involves displaying a list of transactions, and a corresponding detail screen for each.

## App - Requirements

* ✅ As a user of the App, I want to see a list of (mocked) transactions. Each item in the list displays `bookingDate`, `partnerDisplayName`, `transactionDetail.description`, `value.amount` and `value.currency`. *(see attached JSON File)*
* ✅ As a user of the App, I want to have the list of transactions sorted by `bookingDate` from newest (top) to oldest (bottom).
* ✅ As a user of the App, I want to get feedback when loading of the transactions is ongoing or an Error occurs. *(Just delay the mocked server response for 1-2 seconds and randomly fail it)*
* ✅ As a user of the App, I want to see an error if the device is offline.
* ✅ As a user of the App, I want to filter the list of transactions by `category`.
* ✅ As a user of the App, I want to see the sum of filtered transactions somewhere on the Transaction-list view. *(Sum of `value.amount`)*
* ✅ As a user of the App, I want to select a transaction and navigate to its details. The details-view should just display `partnerDisplayName` and `transactionDetail.description`.
* ✅ As a user of the App, I like to see nice UI in general. However, for this coding challenge fancy UI is not required.

## App - General Information

* ✅ Attached you will find a JSON File (`PBTransactions.json`) which contains a list of transactions. Just assume that the Backend is not ready yet and the App needs to work with mocked data meanwhile. For now, the Backend-Team has just provided the name of the endpoints for the new Service:

	• Prod Environment: (GET) https://api-test.com (TODO: Add API)
    	• Test Environment: (GET) https://api-test.com (TODO: Add API)

* ✅ The App is planned to be maintained over a long period of time. New Features will be added by a growing Team in the near future.

## MARK: THIS TASK REQUIRES MORE INFORMATION ABOUT WHAT TO DO

* [✅/❓] The App is planned to be available worldwide supporting many different languages and region related formatting (e.g. Date and Number formatting).

* ❓ The Feature you are currently working on is the first out of many. Multiple Teams will add more features in the near future (overall Team size is about 8 Developers and growing). The following list of Features (which are not part of this coding challenge) will give you an idea of what's planned for the upcoming releases.
 
	1. "Feed"-Feature: Displays different, user-targeted content (displayed via webviews, images, ads etc.). **Note:** It is also planned to display the sum of all Transactions from the "Transaction"-Feature.
	2. "Online Shopping"-Feature: Lists PAYBACK Partners and gives the possibility to jump to their App/Website.
	3. "Settings"-Feature: Gives the possibility to adjust general Settings.

## A Environment

* ✅ We are currently in a transition phase of moving from UIKit to SwiftUI.
* ✅ We use Reactive programming and are currently moving from a self built Reactive-Library to Combine. For asynchronous code we are moving to Swift Concurrency.

## MARK: THIS TASK REQUIRES MORE INFORMATION ABOUT WHAT TO 

* ☑️ We try to keep to as few external dependencies as possible. However, we use Swift Package Manager when we need to add a dependency.
* ☑️ We are using Jenkins to build, test and deploy our Apps.

## Disclaimer

✅ This project (code, description) is the property of the developer and is available for use by third parties. 

© Happy Coding 🧑🏽‍💻 🎁 👍🏽
