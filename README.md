# Flutter Top News App

Flutter application implement list and details page using newsapi.org

## Setup

* download the reporsity

* open the project

* run command `flutter pub get`

* run command `flutter run -device`


## IOS Setup

please add 

```plist
<key>CFBundleLocalizations</key>
     <array>
         <string>en_US</string>
         <string>ar</string>
    </array>
```

into ios/Runner/Info.plist before run the app


## Pattern used

Bloc for the DataModel and  State Management
cubit, intl and shard prefernces for Local change
Block_test and Mocktail for the unit testing


## Code Structure

- bloc => containe the bloc classes, events , states

- ui => containe the UI elements views and widgets

- model => containe all the data model

- l10n => containe the languages data

- client => containe the Api Client data

- genereted => the genereted classes for the localizations

- test => containes all the test files for the project



****



###End
