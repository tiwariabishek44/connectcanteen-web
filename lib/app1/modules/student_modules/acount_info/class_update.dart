import 'dart:developer';

import 'package:connect_canteen/app/widget/custom_loging_widget.dart';
import 'package:connect_canteen/app1/modules/student_modules/acount_info/account_info_controller.dart';
import 'package:connect_canteen/app1/widget/black_textform_field.dart';
import 'package:connect_canteen/app1/widget/custom_app_bar.dart';
import 'package:connect_canteen/app1/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClassUpdate extends StatelessWidget {
  final String initialName;
  final List<String> classOptions;
  final String userId;

  ClassUpdate(
      {Key? key,
      required this.userId,
      required this.initialName,
      required this.classOptions})
      : super(key: key);
  final accountInfoController = Get.put(AccountInfoController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: initialName);
    var selectedClass =
        classOptions.isNotEmpty ? classOptions.first.obs : ''.obs;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            titleSpacing: 4.0, // Adjusts the spacing above the title
            title: Text(
              'User Account',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0.w),
                  child: Text(
                    'Class Change',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    "Update your profile to the latest class. ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 19.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                initialName == ''
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: BlackTextFormField(
                          prefixIcon: const Icon(Icons.person),
                          textInputType: TextInputType.text,
                          hintText: 'Previous Class',
                          controller: nameController,
                          validatorFunction: (value) {
                            if (value.isEmpty) {
                              return '  Name Can\'t be empty';
                            }
                            return null;
                          },
                          actionKeyboard: TextInputAction.next,
                          onSubmitField: () {},
                        ),
                      ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Latest Class',
                      style: TextStyle(
                          fontSize: 19.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(24, 152, 151, 151),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => DropdownButton<String>(
                          value: selectedClass.value,
                          onChanged: (newValue) {
                            selectedClass.value = newValue.toString();
                            accountInfoController.newClass.value =
                                newValue.toString();
                          },
                          items: classOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    isLoading: false,
                    text: 'Update',
                    onPressed: () {
                      accountInfoController.doCalssUpdae(
                          userId, accountInfoController.newClass.value);
                    },
                    buttonColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 40.h,
            left: 40.w,
            child: Obx(() => accountInfoController.loading.value
                ? LoadingWidget()
                : SizedBox.shrink()))
      ],
    );
  }
}
