import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_canteen/app1/cons/api_end_points.dart';
import 'package:connect_canteen/app1/model/order_model.dart';
import 'package:connect_canteen/app1/model/transction_model.dart';
import 'package:connect_canteen/app1/modules/common/wallet/transcton_controller.dart';
import 'package:connect_canteen/app1/widget/payment_succesfull.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

class PenaltyFigureController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final transctionController = Get.put(TransctionController());

  var isCashed = true.obs;
//------------TO GET ALL THE ORDRES OF THE GROUP
  Stream<List<OrderResponse>> getAllOrder() {
    return _firestore
        .collection(ApiEndpoints.productionOrderCollection)
        .where('scrhoolrefrenceid', isEqualTo: "texasinternationalcollege")
        .where('checkout', isEqualTo: 'false')
        .where('orderType', isEqualTo: 'regular')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderResponse.fromJson(doc.data()))
              .toList(),
        );
  }
}
