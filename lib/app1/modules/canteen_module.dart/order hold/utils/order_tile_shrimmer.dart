import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app/modules/vendor_modules/dashboard/demand_supply.dart';
import 'package:connect_canteen/app1/cons/colors.dart';
import 'package:connect_canteen/app1/model/order_model.dart';
import 'package:connect_canteen/app1/modules/common/login/login_controller.dart';
import 'package:connect_canteen/app1/modules/student_modules/order/hold_your_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CanteenOrderTilesShrimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenHorizontalPadding,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 231, 232, 235),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(8.0),
          // margin: EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.shrimmerColorText,
                      child: Text(
                        " order.productName",
                        style: TextStyle(
                          color: AppColors.shrimmerColorText,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Container(
                          color: AppColors.shrimmerColorText,
                          child: Text(
                            '"NPR {order.price}"',
                            style: TextStyle(
                                fontSize: 16.0.sp,
                                color: AppColors.shrimmerColorText,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Container(
                          color: AppColors.shrimmerColorText,
                          child: Icon(
                            Icons.alarm_outlined,
                            size: 17.sp,
                            color: AppColors.shrimmerColorText,
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          color: AppColors.shrimmerColorText,
                          child: Text(
                            '{order. }',
                            style: TextStyle(
                                fontSize: 16.0.sp,
                                color: AppColors.shrimmerColorText,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 17.sp,
                          color: AppColors.shrimmerColorText,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          color: AppColors.shrimmerColorText,
                          child: Text(
                            '{order.customer}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.shrimmerColorText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
