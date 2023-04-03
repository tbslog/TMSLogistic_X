import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tbs_logistics_tms/app/change_password/controller/change_password_controller.dart';
import 'package:tbs_logistics_tms/config/core/data/color.dart';
import 'package:tbs_logistics_tms/config/core/data/validate.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends GetView<ChangePassController> {
  ChangePasswordScreen({
    super.key,
  });

  final String routes = "/CHANGE_PASSWORD__FULL_SCREEN";
  @override
  var controller = Get.put(ChangePassController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thay đổi mật khẩu",
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        backgroundColor: CustomColor.backgroundAppbar,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) => Validate().username(value),
                  controller: controller.username,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Nhập UserName',
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.orangeAccent,
                      ),
                      prefixText: ' ',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) => Validate().password(value),
                  controller: controller.passwordOld,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Nhập mật khẩu cũ',
                      labelText: 'Mật khẩu cũ',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.orangeAccent,
                      ),
                      prefixText: ' ',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) => Validate().password(value),
                  controller: controller.passwordNew,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Nhập mật khẩu mơi',
                      labelText: 'Mật khẩu mới',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.orangeAccent,
                      ),
                      prefixText: ' ',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) => Validate().rePassword(value),
                  controller: controller.rePasswordNew,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Nhập lại mật khẩu mới',
                      labelText: 'Nhập lại mật khẩu mới',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.orangeAccent,
                      ),
                      prefixText: ' ',
                      suffixStyle: const TextStyle(color: Colors.green)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: size.width * 0.6,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<BeveledRectangleBorder>(
                          BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColorDark),
                    ),
                    child: const Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
