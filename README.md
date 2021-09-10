# Crypt Query

[App-Link]()  *(It would be available once app is on PlayStore)*
This project is created with aim to increase awareness about cryptocurrencies, their history, current prices, etc. It allows users to choose crypto-currencies with the help of a chat assistant so that they can monitor the added crypto-currencies. All the data is made available through the [Nomics API](https://nomics.com/docs/). Three main features of the app are listed below- 

* **Marketplace** - This is the place which allows user to get the data about all the listed crypto-currencies in rank wise order. This screen is paginated, users can also change the per-page count as well as currency. State manangement is done using [provider](https://pub.dev/packages/provider) package. Users can also view details about cryptocurrencies.
* **Chat Assistant** - App also has a chat assistant which assists user to search for cryptocurrencies using their ids. Also user can interactively add currencies using this chat assistant for the purpose of monitoring.
* **Dashboard** - Cryptocurrencies that are added by user for purpose of monitoring are shown in this place.

## Instructions for usage
* For the purpose recreating the app, or to suggest feature updates or to point out any issues, this github repo can be used as the starting point. After cloning the app, remember to create `config.dart` file inside the `libs` folder. This file contains the API key for the Nomics APIs, and should not be shared. It consists of following code, change accordingly-
```dart
const String API_KEY = "YOUR-API-KEY";
const String BASE_URL = "api.nomics.com";
const String GET_CURRENCIES = "v1/currencies/ticker";
```
* Once the app is uploaded on PlayStore, it can be used from [here]().

## Contribution Best Practices
* Feel free to provide feature suggestions, but make sure they are feasible under with the free version of the Nomics API.
* Single commit per pull request, makes it easier of the contribuor as well as the reviewer. Also attaching screenshots of the changes implemented on the UI.
* Make sure consistency is maintained throughout the app.

