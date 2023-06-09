// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:tbs_logistics_tms/config/core/constants/constants.dart';
import 'package:tbs_logistics_tms/config/model/tms_orders_model.dart';

import 'package:tbs_logistics_tms/config/share_preferences/share_preferences.dart';

class StartDetailTmsController extends GetxController {
  Rx<TmsOrdersModel> detailOrder = TmsOrdersModel().obs;
  TextEditingController contNoController = TextEditingController();

  RxList<String> items = ['Item 1', 'Hello 2', 'Win 3', 'Item 4'].obs;

  @override
  void onInit() {
    var orDerDriver = Get.arguments as TmsOrdersModel;
    detailOrder.value = orDerDriver;
    super.onInit();
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }

  void postSetRuning({required int id}) async {
    var dio = Dio();
    Response response;
    var tokens = await SharePerApi().getToken();
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBase}/api/Mobile/ChangeStatusHandling?id=$id&maChuyen=${detailOrder.value.maChuyen}";
    try {
      response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);
        Get.snackbar(
          "",
          "",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: const Text(
            "Bắt đầu chuyến đi thành công !",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        );

        detailOrder.value;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        if (e.response!.data["message"] == "Vui lòng cập nhật ContNo") {
          getSnack(message: e.response!.data["message"]);
        } else {
          Get.defaultDialog(
            title: "Thông báo",
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Nhập contNo",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: contNoController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orangeAccent,
                      ),
                    ),
                    hintText: "Nhập contNo",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
              ],
            ),
            confirm: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  updateContNo(
                    maChuyen: detailOrder.value.maChuyen!,
                    contNo: contNoController.text,
                  );
                },
                child: const Text(
                  "Xác nhận",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            cancel: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Hủy",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
  }

  void updateContNo({required String maChuyen, required String contNo}) async {
    var tokens = await SharePerApi().getToken();
    var dio = Dio();
    Response response;
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: "Bearer $tokens"
    };
    var url =
        "${AppConstants.urlBase}/api/Mobile/UpdateContNo?maChuyen=$maChuyen&contNo=$contNo";
    try {
      response = await dio.post(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        var data = response.data;

        Get.back(result: true);
        Get.snackbar(
          "Thông báo",
          "Lỗi thực thi",
          backgroundColor: Colors.white,
          titleText: const Text(
            "Thông báo",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          messageText: Text(
            "${response.data["message"]}",
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  void getSnack({required String message}) {
    Get.snackbar(
      "",
      "",
      backgroundColor: Colors.white,
      titleText: const Text(
        "Thông báo",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
