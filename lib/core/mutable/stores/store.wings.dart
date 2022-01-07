/// You can store data that you want to store and retrieve during the app life cycle
class WingsStore {
  static WingsStore? _instance;

  static WingsStore get instance {
    _instance ??= WingsStore();

    return _instance!;
  }

// add your data
}
