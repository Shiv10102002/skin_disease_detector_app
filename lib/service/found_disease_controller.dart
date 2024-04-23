import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;

class FoundDiseaseController extends GetxController {
  final d.Dio _dio = d.Dio();
  final RxBool uploading = false.obs;
  final RxMap resData = {}.obs;

  Future<void> fetchData(File pickedImage) async {
    uploading.value = true;
    try {
      // URL for fetching data
      const String url = 'https://skindiseasesdetect-3.onrender.com/detect';

      // FormData with picked image
      var formData = d.FormData.fromMap({
        'im': await d.MultipartFile.fromFile(pickedImage.path,
            filename: 'image.jpg'),
      });

      // Send POST request
      final response = await _dio.post(url, data: formData);

      // Check response and handle accordingly
      if (response.statusCode == 200) {
        // If successful response
        resData.value = response.data;
      } else {
        // Handle other status codes or errors
        debugPrint('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      debugPrint('Error: $error');
    } finally {
      uploading.value = false;
    }
  }
}
