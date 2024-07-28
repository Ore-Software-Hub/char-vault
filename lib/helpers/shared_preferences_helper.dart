// snackbar_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static void removeMany(List<String> list) async {
    for (var item in list) {
      removeData(item);
    }
  }

  static void removeData(String tag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tag);
  }

  /// Função que salva uma informação no shared preferences
  ///
  /// Params:
  ///
  /// [tipo] nome do tipo "bool", "int", "string" ou "double"
  ///
  /// [tag] nome da tag para salvar a informação
  ///
  /// [valor] dado a ser salvo
  ///
  /// Return: void
  static void setData(String tipo, String tag, dynamic valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (tipo) {
      case "bool":
        prefs.setBool(tag, valor);
        break;
      case "int":
        prefs.setInt(tag, valor);
        break;
      case "double":
        prefs.setDouble(tag, valor);
        break;
      case "string":
        prefs.setString(tag, valor);
        break;
    }
  }

  static dynamic getData(String tipo, String tag) async {
    /// Função que busca uma informação no shared preferences
    ///
    /// Params:
    ///
    /// [tipo] nome do tipo "bool", "int", "string" ou "double"
    ///
    /// [tag] nome da tag para buscar a informação
    ///
    /// Return: o dado do tipo especificado ou null
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (tipo) {
      case "bool":
        return prefs.getBool(tag);
      case "int":
        return prefs.getInt(tag) ?? 0;
      case "double":
        return prefs.getDouble(tag) ?? 0;
      case "string":
        return prefs.getString(tag) ?? "";
    }
  }
}
