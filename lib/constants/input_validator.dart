String? emailValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل البريد الاكتروني !";
  } else if (!(value.endsWith("@gmail.com") ||
      value.endsWith("@admin.com") ||
      value.endsWith("@yahoo.com") ||
      value.endsWith("@outlook.com"))) {
    return "ادخل بريد الكتروني صحيح!";
  } else {
    return null;
  }
}

String? regPasswordValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل كلمة المرور !";
  } else if (value.length < 9) {
    return "يجب الا تقل كلمة المرور عن 9 رموز !";
  } else {
    return null;
  }
}

String? userNameValidator(value) {
  if (value.isEmpty) {
    return 'من فضلك ادخل اسم المستخدم !';
  } else if (value.length < 6) {
    return "يجب الا يقل اسم المستخدم  عن 6 احرف او ارقام !";
  } else {
    return null;
  }
}
