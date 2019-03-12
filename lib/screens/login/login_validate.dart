class LoginValidate {

  static String validateServer(String server) {
    if (server.isEmpty) {
      return "Server is required.";
    }

    if(!server.contains("http")){
      return "You must inform http:// or https://";
    }

    return null;
  }

  static String validateToken(String token) {
    if (token.isEmpty) {
      return "Token is required.";
    }
    return null;
  }

}