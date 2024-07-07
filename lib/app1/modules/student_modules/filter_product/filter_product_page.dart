import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_canteen/app1/cons/colors.dart';
import 'package:connect_canteen/app1/cons/style.dart';
import 'package:connect_canteen/app1/model/product_model.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/menue/utils/menue_shrimmer.dart';
import 'package:connect_canteen/app1/modules/student_modules/filter_product/product_filter_controller.dart';
import 'package:connect_canteen/app1/widget/product_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class FilterProductPage extends StatelessWidget {
  final String title;
  final String image;
  FilterProductPage({super.key, required this.image, required this.title});
  final productFilterController = Get.put(ProductFilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        // back icons as ios icon
        leading: kIsWeb
            ? null
            : IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
        backgroundColor: AppColors.backgroundColor,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // container of the 4/10 of the screen width to show the image.
            Container(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // text of all proudcts
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("All Products",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: AppPadding.screenHorizontalPadding,
              child: StreamBuilder<List<ProductResponseModel>>(
                stream: productFilterController.getAllMenue(
                    "texasinternationalcollege", title),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return MenueShrimmer();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    final menueProducts = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: menueProducts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ProductCard(
                            productId: menueProducts[index].productId,
                            active: true,
                            type: menueProducts[index].type,
                            name: menueProducts[index].name,
                            imageUrl: menueProducts[index].proudctImage,
                            price: menueProducts[index].price,
                          ),
                        );
                      },
                    );

                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2, // Number of columns in the grid
                    //     crossAxisSpacing: 20.0, // Spacing between columns
                    //     mainAxisSpacing: 5.sp, // Spacing between rows
                    //     childAspectRatio:
                    //         0.7, // Aspect ratio of grid items (width/height)
                    //   ),
                    //   itemCount: menueProducts.length,
                    //   itemBuilder: (context, index) {
                    //     return GestureDetector(
                    //       child: ProductCard(
                    //         productId: menueProducts[index].productId,
                    //         active: true,
                    //         type: menueProducts[index].type,
                    //         name: menueProducts[index].name,
                    //         imageUrl: menueProducts[index].proudctImage,
                    //         price: menueProducts[index].price,
                    //       ),
                    //     );
                    //   },
                    // );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
