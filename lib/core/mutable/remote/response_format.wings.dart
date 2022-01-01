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
