# eTour Flutter module

iTour Flutter module to be integrated in eTour iOS and Android applications.

## Development and running locally

This project is a Flutter module.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


1. Follow the instructions above for installing Flutter and a desired IDE
2. Clone this repository
3. Build the project with command ```$ flutter run```

Note that even though you can run this module as a standalone, in order to get the beacon discovery working, it needs to be integrated to a native app that has the Method Channel for discovering beacons implemented. More info below.

### Related projects

In order to get the system running, you also need to set up these projects:
1. Backend: https://github.com/Beacon-eTour/eTour-NextJS. Once this is set up, adjust the ```baseUrl``` in [etour_config](./lib/constants/etour_config.dart) accordingly.
2. Android: https://github.com/Beacon-eTour/eTour-Android
3. iOS: https://github.com/Beacon-eTour/eTour-iOS


## Application Architecture

### State management
The application uses [cubit](https://pub.dev/documentation/flutter_cubit/latest/) library for state management. This is a lightweight version of [bloc](https://pub.dev/packages/flutter_bloc). Architecture is described below.

![Cubit state management](https://i2.wp.com/resocoder.com/wp-content/uploads/2020/07/cubit_architecture_full.png)

### Code Structure

The application uses following libraries and methodologies (among others):
1. [Floor Persistence Library](https://pub.dev/packages/floor)
    - Entities, DAO and database definition is located in [database folder](./lib/persistence)
2. [Retrofit](https://pub.dev/packages/retrofit)
    - Networking related models, repositories and utilities are located in [networking folder](./lib/networking)

## Internationalization

The localizations are loaded dynamically from the backend on app start. If the fetch fails, or the localizations are not available, backups are store in [i18n](./i18n) folder.
