import 'package:flutter/material.dart';

class SignUpControllers {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
