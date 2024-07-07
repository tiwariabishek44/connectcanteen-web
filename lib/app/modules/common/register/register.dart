import 'package:connect_canteen/app/config/prefs.dart';
import 'package:connect_canteen/app/widget/custom_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:connect_canteen/app/config/colors.dart';
import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app/modules/common/register/register_controller.dart';
import 'package:connect_canteen/app/widget/customized_button.dart';
import 'package:connect_canteen/app/widget/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api

  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registercontroller = Get.put(RegisterController());
  String? _selectedOption;

  // Replace with your own options

  bool _isPasswordVisible = false;
  bool _isconrnformPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar(
          title: "Account Register",
        ),
        body: Padding(
          padding: AppPadding.screenHorizontalPadding,
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Form(
              key: registercontroller.registerFromkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      registercontroller.pickImages();
                    },
                    child: Obx(() => CircleAvatar(
                          radius: 38.sp,
                          backgroundColor: AppColors.greyColor.withOpacity(0.4),
                          child: registercontroller.image.value.path.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_a_photo,
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Text(
                                      'Select ProfilePicture',
                                      style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 15.sp),
                                    ),
                                  ],
                                )
                              : ClipOval(
                                  child: Image.file(
                                    registercontroller.image.value!,
                                    fit: BoxFit.fill,
                                    width: 35
                                        .w, // Adjust the width and height as needed
                                    height: 35.w,
                                  ),
                                ),
                        )),
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  CustomizedTextfield(
                    keyboardType: TextInputType.emailAddress,
                    validator: registercontroller.usernameValidator,
                    icon: Icons.email,
                    myController: registercontroller.emailcontroller,
                    hintText: "Email",
                  ),
                  CustomizedTextfield(
                    keyboardType: TextInputType.phone,
                    validator: registercontroller.phoneValidator,
                    icon: Icons.phone,
                    myController: registercontroller.phonenocontroller,
                    hintText: "Phone",
                  ),
                  CustomizedTextfield(
                    keyboardType: TextInputType.name,
                    validator: registercontroller.usernameValidator,
                    icon: Icons.person,
                    myController: registercontroller.namecontroller,
                    hintText: "Name",
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.7.h),
                    child: Container(
                      height: 6.5.h,
                      padding: EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.secondaryColor),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedOption,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.class_,
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              'Select a Class',
                              style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ), // Initial hint
                        icon: Icon(Icons.arrow_drop_down),

                        iconSize: 20.sp,
                        elevation: 8,
                        style: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 16.sp),
                        underline: SizedBox(),
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Display selected value at bottom when an option is selected

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.7.h),
                    child: TextFormField(
                      validator: registercontroller.passwordValidator,
                      controller: registercontroller.passwordcontroller,
                      obscureText: !_isPasswordVisible, // Toggle the visibility
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 16.sp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.7.h),
                    child: TextFormField(
                      validator: registercontroller.confirmPasswordValidator,
                      controller: registercontroller.confirmPasswordController,
                      obscureText:
                          !_isconrnformPasswordVisible, // Toggle the visibility
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(Icons.lock_outline),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                            color: AppColors.secondaryColor, fontSize: 16.sp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isconrnformPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isconrnformPasswordVisible =
                                  !_isconrnformPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      registercontroller.termsAndConditions.value =
                          !registercontroller.termsAndConditions.value;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: registercontroller.termsAndConditions.value,
                            onChanged: (value) {
                              registercontroller.termsAndConditions.value =
                                  value!;
                            },
                            activeColor: AppColors.primaryColor,
                            checkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                            splashRadius: 1.5.h,
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        Flexible(
                          child: RichText(
                            softWrap: true,
                            maxLines: 2,
                            text: TextSpan(
                              text: "I have read and accept the ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms and Privacy Policy",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                  style: TextStyle(
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => CustomButton(
                        text: "Register",
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          registercontroller.image.value.path.isEmpty
                              ? Fluttertoast.showToast(
                                  msg: "Please select a profile picture",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                )
                              : registercontroller
                                  .registerSubmit(_selectedOption.toString());
                        },
                        isLoading: registercontroller.isregisterloading.value,
                      )),

                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )))
          ]),
        ));
  }
}
