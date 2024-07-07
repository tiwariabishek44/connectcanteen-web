import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_canteen/app1/cons/colors.dart';
import 'package:connect_canteen/app1/model/student_model.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/student_list/student_list_controller.dart';
import 'package:connect_canteen/app1/modules/canteen_module.dart/student_list/utils/no_student_found.dart';
import 'package:connect_canteen/app1/modules/common/wallet/balance_load.dart';
import 'package:connect_canteen/app1/modules/common/wallet/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class StudentListPage extends StatelessWidget {
  final String grade;
  final studetnListControllre = Get.put(StudetnController());
  final String isrecord;

  StudentListPage({super.key, required this.grade, this.isrecord = 'false'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        titleSpacing: 4.0, // Adjusts the spacing above the title
        title: Text(
          "Students",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.0.w),
              child: Text(
                grade,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<StudentDataResponse>>(
        stream: studetnListControllre.fetchClassStudent(grade),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListtileShrimmer();
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return NoStudetnFound();
          } else {
            final students = snapshot.data!;

            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  StudentDataResponse student = students[index]!;
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (isrecord == 'true') {
                          Get.to(() => WalletPage(
                                userId: student.userid,
                                name: student.name,
                                grade: '',
                                isStudent: true,
                                image: '',
                              ));
                        } else {
                          Get.to(() => BalanceLoadPage(
                                grade: student.classes,
                                oldBalance: '0',
                                // transctionController.totalbalances.value.toString(),
                                id: student.userid,
                                name: student.name,
                              ));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19.0.sp,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${student.phone}',
                                        style: TextStyle(
                                          fontSize: 17.0.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 9.h,
                              height: 9.h,
                              child: student?.profilePicture == ''
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 243, 242, 242),
                                      ),
                                      width: 9.h,
                                      height: 9.h,
                                      child: Icon(Icons.person,
                                          color: const Color.fromARGB(
                                              255, 129, 126, 126),
                                          size: 30.sp),
                                    )
                                  : CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Opacity(
                                        opacity: 0.8,
                                        child: Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              255, 248, 246, 246),
                                          highlightColor: Color.fromARGB(
                                              255, 238, 230, 230),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color.fromARGB(
                                                  255, 243, 242, 242),
                                            ),
                                            width: 9.h,
                                            height: 9.h,
                                          ),
                                        ),
                                      ),
                                      imageUrl: student.profilePicture ?? '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      errorWidget: (context, url, error) =>
                                          CircleAvatar(
                                        radius: 21.4.sp,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 224, 218, 218),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class ListtileShrimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
        ),
        title: Container(
          width: double.infinity,
          height: 10,
          color: Colors.white,
        ),
        subtitle: Container(
          width: double.infinity,
          height: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
