import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  // Login (Server, Token)
  setServerSharedPreferences(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("server", server.toString());
  }

  Future<String> getServerFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spServer = (prefs.getString('server'));
    return spServer;
  }

  setTokenSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token.toString());
  }

  Future<String> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spToken = (prefs.getString('token'));
    return spToken;
  }

  // Send Mail (Email, SMTP, Port)
  setEmailSharedPreferences(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", server.toString());
  }

  Future<String> getEmailFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spEmail = (prefs.getString('email'));
    return spEmail;
  }

  setSMTPSharedPreferences(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("smtp", server.toString());
  }

  Future<String> getSMTPFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spSMTP = (prefs.getString('smtp'));
    return spSMTP;
  }

  setPortSharedPreferences(String server) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("port", server.toString());
  }

  Future<String> getPortFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spPort = (prefs.getString('port'));
    return spPort;
  }

}