class Validation {
  static String? required(String value) {
    if (value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }

    return null;
  }

  static String? phone(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 'الرجاء ادخال رقم الهاتف';
    }
    if (value.length != 9 ||
        !(value.startsWith('77') ||
            value.startsWith('78') ||
            value.startsWith('73') ||
            value.startsWith('71') ||
            value.startsWith('70'))) {
      return 'الرجاء ادخال رقم هاتف صحيح';
    }

    return null;
  }

  static String? intNumbers(String value) {
    value = value.trim();

    if (value.isEmpty ||
        int.tryParse(value) == null ||
        int.tryParse(value)! <= 0) {
      return 'الرجاء ادخال رقم صحيح';
    }

    return null;
  }

  static String? emptyIntNumbers(String value) {
    value = value.trim();

    if (value.isNotEmpty &&
        (int.tryParse(value) == null || int.tryParse(value)! <= 0)) {
      return 'الرجاء ادخال رقم صحيح';
    }

    return null;
  }

  static String? password(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return 'الرجاء ادخال كلمة السر';
    }
    if (value.length < 5) {
      return 'الحد الأدنى لكلمة السر هو 5 احرف او ارقام او رموز';
    }

    return null;
  }

  static String? confirmPassword(String value, String password) {
    value = value.trim();

    if (value.isEmpty) {
      return 'الرجاء تأكيد كلمة السر';
    }
    if (password.trim() != value) {
      return 'يجب أن يكون هذا الحقل مطابقاً لكلمة السر أعلاه';
    }

    return null;
  }

  static String? fullName(String value) {
    if (value.isEmpty || !value.contains(' ')) {
      return 'الرجاء ادخال الاسم الكامل';
    }

    return null;
  }
}