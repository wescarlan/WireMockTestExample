# WireMockTestExample

WireMockTestExample is an example project that demonstrates how to use the [WireMockTest](https://github.com/wescarlan/WireMockTest) framework for iOS UI testing.

**System Requirements:**

* Xcode 11+
* iOS 13+
* Java 7+

## Running with WireMock

1. Run the standalone WireMock server included in the project.
    1. `cd /path/to/WireMockTestExample/WireMock`
    2. `java -jar wiremock.jar`
3. Run the tests in the `TrailerTeaserUITests` scheme.

## Running with the real API

The API that this project is based on is the [Box Office Buz](https://rapidapi.com/boxofficebuz/api/Box%20Office%20Buz) API that is available on [Rapid API](https://rapidapi.com/).

In order to use this API, you will need to create a Rapid API account and get an API key for use with the Box Office Buz API.

1. Obtain an API key.
2. Update the following line of code in `AppDelegate.swift` with your API key:
```swift
configuration = .rapidApi("<Insert API Key>")
```
3. Run the `TrailerTeaser` scheme.
