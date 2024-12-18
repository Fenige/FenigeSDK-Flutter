
## Usage

```dart
var redirectUrl = RedirectUrl("https://paytool.fenige.pl/demo/?success=1", "https://paytool.fenige.pl/demo/?success=0");
var sender = Sender("First Name", "Last Name", Address("country code", "city", "postal code", "street", "house number"));
Navigator.push(context, MaterialPageRoute(builder: (context) => FenigeSDK.createPayment(
"api key",
"transaction id",
"amount in cents",
"currency code",
"Payment description",
"merchant url",
"order number",
"language code e.g. 'en'",
redirectUrl,
sender,
true))).then((value) {
  
//receive transaction id

},);
```
| Field                      | Type   | Description                                                                                                                                                                                                  |
|----------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| apiKey                     | String | This is the value you receive from the payment gateway provider for production and staging environment. It is necessary to be identified in our system                                                       |
| currencyCode               | String | Currency for transaction (in accordance with ISO-4217), example: USD                                                                                                                                         |
| amount                     | Int    | The total transfer amount (in pennies - 1PLN = 100)                                                                                                                                                          |
| description                | String | Description of the transaction, which indicates what the user is paying for                                                                                                                                  |
| merchantUrl                | String | URL address of merchant web system                                                                                                                                                                           |
| orderNumber                | String | Declarative number of order that is just purchased by cardholder, set by merchant, should be unique                                                                                                          |
| formLanguage               | String | Language of transaction process in web browser in accordance with ISO 3166-1 Alpha-2, use only lowercas                                                                                                      |
| redirectUrl.successUrl     | String | URL of merchant web service to forward after successful payment flow                                                                                                                                         |
| redirectUrl.failureUrl     | String | URL of merchant web service to forward after failure payment flow                                                                                                                                            |
| sender.firstName           | String | Cardholder's first name                                                                                                                                                                                      |
| sender.lastName            | String | Cardholder's last name                                                                                                                                                                                       |
| sender.address.countryCode | String | Two character ISO 3166-1 alpha-2 code of country                                                                                                                                                             |
| sender.address.city        | String | Name of the cardholder city                                                                                                                                                                                  |
| sender.address.postalCode  | String | Postal code of this address                                                                                                                                                                                  |
| sender.address.street      | String | Street name in the city                                                                                                                                                                                      |
| sender.address.houseNumber | String | House number with optional flat number                                                                                                                                                                       |
| transactionId              | String | Terminal’s unique uuid to process payment                                                                                                                                                                    |
| autoClear                  | Bool   | Automatically this parameter is on true. It mean that transaction will be cleared automatically by Fenige in few hours. You can set this parameter as false but you must remember to clear your transaction. |

