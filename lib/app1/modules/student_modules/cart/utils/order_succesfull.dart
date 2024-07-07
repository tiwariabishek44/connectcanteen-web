import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart'; // For adding confetti animation

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back button as ios
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Success!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  height: 20.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff93C22F),
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Color(0xff93C22F),
                    size: 80.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Thank you for order',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your items have been placed and\nis on its way to being processed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10.0),
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: BorderSide(color: Colors.green),
                ),
                child: Text(
                  'Back to Shop',
                  style: TextStyle(fontSize: 18.0, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
