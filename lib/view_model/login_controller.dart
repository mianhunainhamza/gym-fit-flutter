import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passController = TextEditingController().obs;
  Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;
  RxBool isObscure = true.obs;

  changeObscure(){
    isObscure.value = !isObscure.value;
  }


}
