import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  static NetworkController get to => Get.find();

  var connectionStatus = Rx<ConnectivityResult?>(null);

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((results) {
      // var result = results.isNotEmpty ? results[0] : ConnectivityResult.none;
      var result = results;
      connectionStatus.value = result;
    });
  }

  Future<void> initConnectivity() async {
    try {
      final result = await Connectivity().checkConnectivity();
      connectionStatus.value = result;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool get isConnected =>
      connectionStatus.value != null &&
      connectionStatus.value != ConnectivityResult.none;
}
