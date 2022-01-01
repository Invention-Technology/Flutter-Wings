**Flutter** : **Wings File Structure**

- [About Wings](#about-wings)
- [installation](#installation)
- [simple use](#Simple-Use)
- [Advance Use](#Advance-Use)

# About Wings

Wings is an MVC file structure build with [getx](https://github.com/jonataslaw/getx) for [flutter](https://github.com/flutter/flutter) projects. to reduce the time of development  and increase the programmer productivity.

## File Structure

- core

  - immutable

    > this folder contains the core of Wings and should not be edited 

  - mutable

    - [helpers](#helpers)
    - [remote](#remote)
    - [statics](#statics)
    - [store](#store)
    - [theme](#theme)
    - [translations](#translations)
    - [widgets](#widgets)

- features

  > here you can add your app features as the recommended structure (MVC)

  - featureName
    - controller
    - model
    - view

# Installation

clone the project to your device 

`git clone https://github.com/jonataslaw/getx.git`

go to the project directory and run `flutter pub get` to install all the dependencies 

# Simple Use

1- inside feature folder create new folder and name it as your feature should be called, we will call it here home

2- create three folders with the following names: controller, model and view.

3- open model folder and create a new file with the name: `home.model.dart` and add the following code inside it:

```dart
import 'package:wings/core/immutable/base/models/model.wings.dart';

class HomeModel implements WingsModel {
  dynamic id; // add all the properties that will be fetched from the API and will be used inside the view
  dynamic title;

  HomeModel({
    this.id,
    this.title,
  });

  @override
  List<WingsModel> fromJsonList(List<dynamic> json) {
    List<HomeModel> models = [];

    for (var element in json) {
      models.add(HomeModel.fromJson(element));
    }

    return models;
  }

  factory HomeModel.fromJson(Map<String, dynamic> json) {
      // add all the properties that you added above to assign the data that came from json to this instance
    return HomeModel(id: json['id'], title: json['title']);
  }

  @override
  WingsModel fromJson(Map<String, dynamic> json) {
    return HomeModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
      // Map the data of this instance to json object to be send to the API
    return {
      'id': id,
      'title': title,
    };
  }
}
```



4- open controller folder and create a new file with the name: `home.controller.dart` and add the following code inside it:

```dart
import 'package:wings/core/immutable/base/controllers/controller.wings.dart';
import 'package:wings/core/immutable/providers/remote/request.wings.dart';
import 'package:wings/core/mutable/remote/urls.wings.dart';
import 'package:wings/features/index/model/index.model.dart';

class HomeController extends WingsController {
  List<HomeModel> get posts => data;

  @override
  void onInit() async {
    model = HomeModel(); // the model that coresponsidng to this feature

    request = WingsRequest(url: WingsURL.home, shouldCache: true); // request data using REST API with the option caching the response

    super.onInit();
  }
}
```



5- open view folder and create a new file with the name: `home.view.dart` and add the following code inside it:

```dart
import 'package:flutter/material.dart';
import 'package:wings/core/immutable/base/views/view.wings.dart';

class HomeView extends WingsView<HomeController> {
  HomeView({Key? key}) : super(key: key, controller: HomeController());

  @override
  Widget successState(BuildContext context) {
    return Text(controller.posts[0].title); // Title of the first post that came from the API
  }
}
```



**For more information, please see the provided example inside feature folder.**

# Advance Use

## Theme

   You can customize your theme by going to the `core/mutable/themes/theme.wings.dart` and customize it as you want



## Translations

   Wings support translation using GetX translation for two languages by default `ar`, `en`

- Add new file for each language with the name `your_file.en.dart` and `your_file.ar.dart`.

- your files should have the following structure:

  ```dart
  // each key should start with the file name capitalized camel case  then : then the key capitalized camel case
  final Map<String, String> errorEn = {
    'Error:ServerException': "Oops! We couldn't connect to the server",
    'Error:CacheException': 'No Internet Connection',
  };
  ```

- Add the variable that you just added to the file `_en.trans.dart`:

  ```dart
  import 'common.en.dart';
  import 'error.en.dart';
  import 'feedback.en.dart';
  
  // add the variable name for each file ex: errorEn with spread operator
  final Map<String, String> en = {
    ...errorEn,
    ...commonEn,
    ...feedbackEn,
  };
  ```

- Now you can add the translation keys to your project but don't delete the existent translation while you can change the translation itself

- You can change the default language by changing the default language:

  ```dart
  Wings.instance.defaultLanguage = WingsLanguage(locale: const Locale('ar'), textDirection: TextDirection.rtl);
  ```



## States

 Wings comes with variation of states for each use: `Loading`, `Error`, `Success`, `ErrorFlushBar`, `SuccessFlushBar` with the ability to customize each one.

 you can change the design for each one inside `emutable/widgets/state` and `emutable/helper/snack_bar` and you can add your custom widget or helper and   override the default states inside `mutable/widgets/states/app_state.wings.dart`

```dart
import 'package:flutter/material.dart';

import '../../../immutable/providers/errors/error.model.wings.dart';
import '../../helpers/snack_bar/error_snack_bar.helper.wings.dart'
    as error_snack_bar;
import '../../helpers/snack_bar/success_snack_bar.helper.wings.dart'
    as success_snack_bar;
import 'error_state.widget.wings.dart';
import 'loading_state.widget.wings.dart';

class WingsAppState {
  static Widget defaultWidgetState() {
    return loading();
  }

  static Widget errorState({onRefresh, error}) {
    return WingsErrorState(
      onRefresh: onRefresh,
      error: error,
    );
  }

  static Widget loading() {
    return const LoadingState();
  }

  static void successSnackBar({String message = '', String title = ''}) {
    success_snack_bar.successSnackBar(message: message, title: title);
  }

  static void errorSnackBar({ErrorModel? error}) {
    error_snack_bar.errorSnackBar(error: error);
  }
}
```



## Remote

> **Wings** use [REST API](https://restfulapi.net/) without patch request cause not all servers supports patch request

you can add your API URLs in `mutable/remote/urls.wings.dart` 

```dart
class WingsURL {
  static String get baseURL => 'https://jsonplaceholder.typicode.com/';

  static String get posts => 'posts';
}
```

if you have a custom response format where the data come with extra info you can add your roles in `mutable/remote/response_format.wings.dart` 

```dart
import 'dart:convert';

class WingsResponseFormat {
  static String? key;

  /// This function will check if the response is valid
  /// according to the json structure that has been agreed on between
  /// the backend and the flutter developer
  ///
  /// The default wings validated response is according to JSON-API:
  /// {"data": {...}}
  ///
  /// This function require back-end api to always fill the data parameter
  /// in the json response
  ///
  /// if you don't like this json response,
  /// please change this function to always return true without checking any code
  /// static bool validatedResponse(String response) { return true; }
  static bool validatedResponse(String response) {
    return true; // TODO: uncomment this line if you don't have custom format
    try {
      key = 'data';

      var data = jsonDecode(response);

      if (data[key].toString().isEmpty) {
        return false;
      }

      return true;
    } catch (exception) {
      return false;
    }
  }
}
```

to send a any request you have to use `WingsRequest` class to specify the request information `url`,`body`,`header`,`queryString`

```dart
 request = WingsRequest(
  url: url,
  shouldCache: true,
  body: {
    "email":'test@email.com',
    'password':"password"
  },
);
```

in your `controller` you can get/send data using `getData()`,`sendData()`. Those methods will read the `request` variable and do the rest for you.

```dart
void login(){
  request = WingsRequest(
    url: WingsURL.login,
    body: {
      "email":'test@email.com',
      'password':"password"
    },
  );

  sendData();
}
```

you can access more methods using `provider` . you have four methods to deal the the requests `provider.get(request: request)`,`provider.insert(request: request)`,`provider.delete(request: request)`,`provider.update(request: request)`.



## Statics

the goal from statics is to avoid misspelling when using string in more than one place 

> Wings structure uses `WingsFeedback`,`WingsErrorAssets` as statics

### Customize request messages/assets

you can can customize your request messages (success and failures) and assets

- to customize request message go to `mutable/statics/feedback.static.dart`

```dart
class WingsFeedback {
  static String insertSuccess = 'Success:Insert'.tr;
}
```

- to customize request exceptions icons and images go `mutable/statics/error_asset.static.wings.dart`

```dart
class WingsErrorAssets {
    // Just in case that some icons or images deleted or not found, use those default values to handle the errors that may arise
    static String defaultImage = 'assets/images/error.png';
    static String defaultIcon = 'assets/icons/error.svg';
  
    static String unexpectedErrorImage = '';
    static String unexpectedErrorIcon = '';
      
   //................   
  }
```



## Store 

> You can store data that you want to store and retrieve during the app life cycle

```dart
class WingsStore {
  // add your data
}
```

## Helpers

> All the helper functions that are commonly used throughout the project and it has a dependent task can be moved here.

## Widgets

> All the widgets that are commonly used throughout the project and it has a dependent task can be moved here.

### States

> Wings uses the widgets inside `mutable/widgets/states` because they're commonly used throughout the structure. and can be customized by the developer.



** **

# 										Developed by [Invention Technology](https://invention-technology.com/)
