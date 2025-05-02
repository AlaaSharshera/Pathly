import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoading() {
  Get.dialog(
    barrierDismissible: false,
    const Center(child: CircularProgressIndicator()),
  );
}

void hideLoading() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
