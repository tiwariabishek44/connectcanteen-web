import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_canteen/app1/model/category_model.dart';
import 'package:connect_canteen/app1/modules/student_modules/filter_product/filter_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalGridView extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: categoryController.getAllMenue("texasinternationalcollege"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //shrimmer
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            itemCount: 4, // Number of shimmer items
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No data available'), // Handle case where data is empty
          );
        } else {
          final menueProducts = snapshot.data!;

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            itemCount: menueProducts.length, // Number of items in the grid
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              () => FilterProductPage(
                                    image: menueProducts[index].image!,
                                    title: menueProducts[index].name!,
                                  ),
                              transition: Transition.cupertinoDialog);
                        },
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Opacity(
                                opacity: 0.8,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.red,
                                  child: Container(),
                                ),
                              ),
                              imageUrl: menueProducts[index].image! ?? '',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error_outline, size: 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        menueProducts[index].name!,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<CategoryModel>> getAllMenue(
    String schoolrefrence,
  ) {
    return _firestore
        .collection("categories")
        .where('school', isEqualTo: schoolrefrence)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromMap(doc.data()))
              .toList(),
        );
  }
}
