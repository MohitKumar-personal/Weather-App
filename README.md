# Weather App

This Flutter-based weather application provides real-time weather updates for any specified city. Users can enter the name of any city to retrieve current weather conditions, including temperature, humidity, and wind speed. The application remembers the last searched city across sessions using shared preferences, ensuring data persistence. Users can refresh the weather data to get the most current information available. With a responsive design, the user interface adapts to different screen sizes and orientations, offering a seamless experience on both phones and tablets. Leveraging the Weather API to fetch and display weather data in a user-friendly interface, this cross-platform application is built with Flutter, making it suitable for both Android and iOS devices.

# **Prerequisites**

To ensure optimal performance and compatibility, specific versions of the SDK and dependencies are required for running this Flutter project. These precise versions enhance the application's stability and functionality. Here are the necessary dependencies and SDK specifications for running the project effectively:

```yaml
environment:
  sdk: '>=3.4.3 <4.0.0'
  
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  buttons_flutter: ^0.0.2+1
  http: ^1.2.1
```

# **Installation**

Before running the project, ensure you have the following installed:

1. Flutter : Follow the instructions on the [official Flutter installation guide](https://docs.flutter.dev/get-started/install) for your operating system.
2. Dart : Install the Dart SDK from the [official Dart SDK Installation](https://dart.dev/get-dart) for your operating system.
3. Make sure you have an IDE like [Android Studio](https://developer.android.com/studio), [Xcode](https://developer.apple.com/documentation/safari-developer-tools/installing-xcode-and-simulators), [VScode](https://code.visualstudio.com/download), [Cursor](https://www.cursor.com/), etc
4. Ensure you run `flutter doctor` in the command prompt or terminal to verify all required conditions are met, confirming your eligibility to run the Flutter application.

# Usage

1. Clone the repository

```bash
$ git clone https://github.com/MohitKumar-personal/Weather-App.git
$ cd .\Weather-App\weather\
```

2. Install Flutter Packages

```bash
$ flutter packages get
```

3. Ensure you sign up on the [WeatherAPI](https://www.weatherapi.com/) website to obtain your API key. Add this API key to the file named `constraints.dart`, located at `Weather-App\weather\lib\constraints.dart`.

```dart
String apiKey = "👉Enter Your API Key👈";
```

4. Run the app

```dart
$ flutter run
```

### APK Installation Directly on Android Device

You can install the application directly from the following location:

```dart
Weather-App\Apk\app-debug.apk
```

Navigate to this location within our repository and proceed with the installation on your Android device.

# Screenshots of the Mobile Application
| Home Screen | With Keyboard | Weather Screen |
| :--: | :--: | :--: |
| ![HomePage](https://github.com/MohitKumar-personal/Weather-App/assets/99556620/91d9b4f1-0122-49c6-9d23-4aca0b555017) | ![Homepage02](https://github.com/MohitKumar-personal/Weather-App/assets/99556620/79608ff2-7dbb-4fa2-bd7e-422fd4ffe7f2) | ![WeatherPage](https://github.com/MohitKumar-personal/Weather-App/assets/99556620/ee8d4ded-e849-464f-ac51-1b0b41a64027) |

## **Contact us**

If you have any questions, feedback, or issues, please feel free to reach out to me:               
 mohitkpersonal@outlook.com, [Linkedin](https://www.linkedin.com/in/mohit-kumar-cse2015192/)

