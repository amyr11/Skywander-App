# Skywander App

## How to contribute

### Clone this repo
```
https://github.com/amyr11/Simple-Flutter-Boilerplate.git
```

### Fetch branches
```
git fetch --all
```

### Pull from dev branch
```
git pull origin dev
```

### Go to your task's branch
```
git switch <your-task's-branch>
```
for example,
```
git switch login
```

### Create your own branch based on your task's branch
```
git checkout -b <your-name>/<your-task's-branch>
```
for example,
```
git checkout -b amyr/login
```

### Install packages
```
flutter pub get
```

### Create pull request
After you are done with your task, create a PR from your branch to your task's branch.

## Folder Structure
```
assets/
lib/
├── models/
├── screens/
├── services/
    ├── api/
    ├── database/
├── utils/
├── widgets/
├── constants.dart
├── routes.dart
├── styles.dart
├── main.dart
```

### assets/
Contains all the assets of the app. For example, images, icons, etc.

### lib/models/
Contains data models used in the app and their attributes. For example, a user model with a username and password.

### lib/screens/
Contains the UI screens of the app. For instance, home.dart and sample.dart are sample screen files.

### lib/services/
Contains the service classes responsible for handling API calls and database operations. It includes subdirectories like api/ for API-related services and database/ for database-related services. You can also add your own folder for the business logic of your app.

### lib/utils/
Contains utility classes and functions. For example, shared_pref_helper.dart could be a helper class for managing shared preferences. You can remove the shared_pref_helper.dart if your app doesn't use shared preferences.

### lib/widgets/
Contains custom widgets used throughout the app. For example, custom_button.dart and custom_text_field.dart could be reusable widgets.

### lib/constants.dart
Contains constant values used across the app.

### lib/routes.dart
Contains the routing configuration of the app, mapping routes to screen widgets. This project uses go_router for routing. For more information, visit https://pub.dev/packages/go_router.

### lib/styles.dart
Contains the styles and themes used in the app, such as text styles, color schemes, and themes.

### lib/main.dart
The entry point of the Flutter app, where the app is initialized and run.
