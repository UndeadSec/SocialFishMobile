class LaunchAttackValidate {

  static String validateClone(String value) {
    if (value.trim().isEmpty) {
      return 'Clone is required.';
    }

    return null;
  }

  static String validateRedirection(String value) {
    if (value.trim().isEmpty) {
      return 'Redirection is required.';
    }

    return null;
  }

}