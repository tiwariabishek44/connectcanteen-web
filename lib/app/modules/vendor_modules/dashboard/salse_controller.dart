import 'package:connect_canteen/app/config/api_end_points.dart';
import 'package:connect_canteen/app/repository/grete_repository.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:connect_canteen/app/models/order_response.dart';
import 'package:nepali_utils/nepali_utils.dart';

import 'dart:developer';

import 'package:connect_canteen/app/service/api_client.dart';

class ProductWithQuantity {
  final String productName;
  final String image; // Add image field
  final int price;
  final int totalQuantity;

  ProductWithQuantity({
    required this.productName,
    required this.image,
    required this.price,
    required this.totalQuantity,
  });
}

class SalsesController extends GetxController {
  final GreatRepository grandTotalRepo = GreatRepository();

  final Rx<ApiResponse<OrderResponse>> salseOrderResponse =
      ApiResponse<OrderResponse>.initial().obs;

  final RxMap<String, int> totalQuantitySalseOrder = <String, int>{}.obs;

  final RxBool isLoading = false.obs;

  final grandTotal = 0.obs;

  var calenderDate = ''.obs;

  @override
  void onInit() {
    super.onInit();

    fetchTotalOrder();
    fetchTotalSales();
  }

//-------------to fetch  the total salse of the day ------------
  Future<void> fetchTotalSales() async {
    try {
      isLoading(true);

      final filters = {
        "date": calenderDate.value,
        "checkout": "true",

        'orderType': 'regular',
        // Add more filters as needed
      };
      salseOrderResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult = await grandTotalRepo.getFromDatabase(
          filters, OrderResponse.fromJson, ApiEndpoints.orderCollection);
      if (orderResult.status == ApiStatus.SUCCESS) {
        salseOrderResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);
        log('Orders have been fetched');
        log("Number of products in the response: " +
            salseOrderResponse.value.response!.length.toString());

        // Calculate total quantity after fetching orders
        calculateTotalQuantity(orderResult.response!);
        calculateGrandTotal();
      }
    } catch (e) {
      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

//-----------to retrive the each product with the respective total quantity
  final RxList<ProductWithQuantity> productWithQuantity =
      <ProductWithQuantity>[].obs;

  void calculateTotalQuantity(List<OrderResponse> orders) {
    totalQuantitySalseOrder.clear();

    // Create a map to store image URLs by product name
    final Map<String, String> productImages = {};

    orders.forEach((order) {
      totalQuantitySalseOrder.update(
        order.productName,
        (value) => value + order.quantity,
        ifAbsent: () => order.quantity,
      );

      // Populate product images
      if (!productImages.containsKey(order.productName)) {
        productImages[order.productName] = order.productImage;
      }
    });

    // Convert map to list of ProductQuantity objects
    productWithQuantity.value = totalQuantitySalseOrder.entries
        .map((entry) => ProductWithQuantity(
              productName: entry.key,
              image: productImages[entry.key] ?? '', // Get image URL
              price: calculateTotalPrice(entry.key, orders), // Calculate price
              totalQuantity: entry.value,
            ))
        .toList();
  }

  int calculateTotalPrice(String productName, List<OrderResponse> orders) {
    return orders
        .where((order) => order.productName == productName)
        .map((order) => order.quantity * order.price)
        .fold(0, (previousValue, price) => previousValue + price.toInt());
  }

  void calculateGrandTotal() {
    grandTotal.value = 0;
    productWithQuantity.forEach((element) {
      log("the items is ${element.productName}");
      grandTotal.value += element.price;
    });
  }

  ///----------------to calculate the total order value ---------------

  final Rx<ApiResponse<OrderResponse>> totalOrderResponse =
      ApiResponse<OrderResponse>.initial().obs;

  final RxMap<String, int> totalOrderQuantity = <String, int>{}.obs;

  final totalorderGRandTotal = 0.obs;

  Future<void> fetchTotalOrder() async {
    try {
      isLoading(true);

      final filters = {
        "date": calenderDate.value,
      };
      totalOrderResponse.value = ApiResponse<OrderResponse>.loading();
      final orderResult = await grandTotalRepo.getFromDatabase(
          filters, OrderResponse.fromJson, ApiEndpoints.orderCollection);
      if (orderResult.status == ApiStatus.SUCCESS) {
        totalOrderResponse.value =
            ApiResponse<OrderResponse>.completed(orderResult.response);

        // Calculate total quantity after fetching orders
        calculateTotalOrderQuantity(orderResult.response!);
        calculateOrderGrandTotal();
      }
    } catch (e) {
      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }

  final RxList<ProductWithQuantity> totalOrderquantity =
      <ProductWithQuantity>[].obs;

  void calculateTotalOrderQuantity(List<OrderResponse> orders) {
    totalOrderQuantity.clear();

    // Create a map to store image URLs by product name
    final Map<String, String> productImages = {};

    orders.forEach((order) {
      totalOrderQuantity.update(
        order.productName,
        (value) => value + order.quantity,
        ifAbsent: () => order.quantity,
      );

      // Populate product images
      if (!productImages.containsKey(order.productName)) {
        productImages[order.productName] = order.productImage;
      }
    });

    // Convert map to list of ProductQuantity objects
    totalOrderquantity.value = totalOrderQuantity.entries
        .map((entry) => ProductWithQuantity(
              productName: entry.key,
              image: productImages[entry.key] ?? '', // Get image URL
              price: calculateTotalOrderPrice(
                  entry.key, orders), // Calculate price
              totalQuantity: entry.value,
            ))
        .toList();
  }

  int calculateTotalOrderPrice(String productName, List<OrderResponse> orders) {
    return orders
        .where((order) => order.productName == productName)
        .map((order) => order.quantity * order.price)
        .fold(0, (previousValue, price) => previousValue + price.toInt());
  }

  void calculateOrderGrandTotal() {
    totalorderGRandTotal.value = 0;
    totalOrderquantity.forEach((element) {
      log("the items is ${element.productName}");
      totalorderGRandTotal.value += element.price;
    });
  }
}
