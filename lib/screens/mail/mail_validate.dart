class MailValidate {

  static String validateSubject(String value) {
    if (value.trim().isEmpty) {
      return 'Subject is required.';
    }

    return null;
  }

  static String validateEmail(String value) {
    if (value.trim().isEmpty) {
      return 'Email is required.';
    }

    return null;
  }


  static String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is required.';
    }

    return null;
  }

  static String validateRecipient(String value) {
    if (value.trim().isEmpty) {
      return 'Recipient is required.';
    }

    return null;
  }

  static String validateBody(String value) {
    if (value.trim().isEmpty) {
      return 'Body is required.';
    }

    return null;
  }

  static String validateSMTP(String value) {
    if (value.trim().isEmpty) {
      return 'SMTP is required.';
    }

    return null;
  }

  static String validatePort(String value) {
    if (value.trim().isEmpty) {
      return 'Port is required.';
    }

    return null;
  }

}