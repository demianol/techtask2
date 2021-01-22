# Sensyne - iOS technical test - Demo app

I have added accessibility identifiers for all elements on Main.storyboard and also HospitalListCustomCell.swift and HospitalListViewController.swift
I have automated all basic / critical scenarios for the App
To run test
- make sure project is building (as per instruction attached to iOS->source-> README.md)
- select ‘tech-test’ app and select any iPhone simulator 
- one way to run all tests is to hit command+U (or Product->Test) it will run all UI and Unit test
- another way is to navigate to tech_testUITests.swift and select diamond next to class name 

I also performed manual testing and found couple of bugs as below: 

Tests performed for Hospital List Screen:

Search text field: 
- It looks like searched text is case sensitive when I type in “east” instead of “East” it won’t show any results. I would consider this as a bug 
- The there is no search results e.g after typing “Eastern”  it is showing empty screen, I would consider adding here notification informing user “no search results” this is not a bug but rather missing requirement  
Hospital Card: 
 - there was a bug on hospital card it was not displaying phone number but the phone was in the database Hospital.csv, my UI Tests was failing because of this issue so I fixed it. The problem was in HospitalListCustomCell.swift file, hospitalPhone.text was listed twice in the ‘configure’ function. 
Pull to refresh: I don’t really understand why refreshing is necessary on the list ? all the values are static labels fetched from the Hospital.csv file. 

Scrolling on the hospital list: fine 
Tests performed for Hospital Details Screen
- Address on hospital details is cutoff e.g for East Riding Community Hospital (in landscape view it is fine) 
- When on email alert I select ‘Yes’ nothing happens (but I believe this is not a bug - email is not setup on the simulator so probably that is the reason why it is not working - I would double check it on the device) 
- When I tap on the phone number I don’t see an prompt (requirement was that user should see the prompt before making a call)
- Web link is fine
- Map and hospital location is tested and it is fine 

Other tests: 
Dark Mode: App does not support dark mode
Rotation/landscape/portrait view: fine
Offline scenarios: app is not connected to network so it is working fine in offline mode
Background scenarios: fine


Requirements iOS 13+ , Xcode 11+

## Installation and running

Prerequisites: CocoaPods (to install run `brew install cocoapods` for example)

1. Clone repo (`develop` branch is default)
2. Run `pod install`
3. Open workspace in Xcode and run `tech-test` target on any device/simulator running iOS13+

## Using the app

When the app starts it lands on the screen (Hospital List). The Hospital List screen contains:
    - Filter bar - the User can search for hospitals by their name using the search bar on the top. As the User types, the list is filtered by the query in the search bar.  When using filter keyboard is presented and it is dismissed on scroll or Search button
    - List of all hospitals from downloaded data or CSV file
    - pull to refresh option

The User can tap on a particular hospital in the list which results in presenting the Hospital Detail Screen. The Detail Screen contains:
    1. all data from CSV file, map with the pin on the hospital address and all data from the CSV data source.
    2. a map with the pin on the hospital address - the user can tap pin and it will be redirected to Apple Maps navigation
    3. if phone number is available when the user tap on label it will be asked to make a call
    4. if email is available when the user tap on label it will be asked to send email
    5. if website is available when the user tap on label it will be redirected to web browser
    6. support for landscape mode

## Implementation

- App architecture: MVVM
- 3rd party library:
    1. CSV Swift (https://github.com/yaslab/CSV.swift) - used for CSV manipulation
    2. SnapKit (https://github.com/SnapKit/SnapKit) - used for auto layout
    3. Realm (https://realm.io/docs/swift/latest#installation) - used for local database
- Unit tests - added exemplary test for Models, Services and View Models
- UI tests - added exemplary test for Hospital List, Hospital Detail, Search bar text filter and Hospital Detail - open website
- Data fetch flow - the app will try to download CSV data from provided URL. If succeeds it will save data to Realm DB for future application launches. If it fails, it will try to use Realm database and parse data. If database is empty or parsing data fails it will use local copy of Hospital.csv file to parse data from there.

## TODO
- More unit and UI tests
- Dark Mode support
- UI enhancements

08 Nov 2020, Robert Majtan

