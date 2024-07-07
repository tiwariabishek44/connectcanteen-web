import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_canteen/app/modules/student_modules/friend_list/friend_list_controller.dart';
import 'package:connect_canteen/app/modules/student_modules/group/view/new_group_page.dart';
import 'package:connect_canteen/app/widget/no_data_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connect_canteen/app/config/colors.dart';
import 'package:connect_canteen/app/config/style.dart';
import 'package:connect_canteen/app/modules/common/login/login_controller.dart';
import 'package:connect_canteen/app/modules/student_modules/friend_list/view/friend_list_view.dart';
import 'package:connect_canteen/app/modules/student_modules/group/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:connect_canteen/app/modules/student_modules/group/view/group_Creation_view.dart';
import 'package:get/get.dart';
import 'package:connect_canteen/app/widget/custom_loging_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class GroupPage extends StatelessWidget {
  final logincontroller = Get.put(LoginController());
  final groupcontroller = Get.put(GroupController());
  final storage = GetStorage();
  final friendlistcontroller = Get.put(FriendListController());

  void _showGroupNameDialog(BuildContext context, String name, String userid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12.0), // Adjust border radius as needed
          ),
          title: Text(
            'Remove  $name',
            style: TextStyle(
              fontSize: 17.5.sp,
              color: Color.fromARGB(221, 37, 36, 36),
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'User will no longer be able to order food under this group.',
            style: TextStyle(
              color: const Color.fromARGB(221, 72, 71, 71),
              fontSize: 16.0.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog

                Get.back();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.purple),
              ),
            ),
            GestureDetector(
              onTap: () async {
                bool isexist = await groupcontroller.checkIfOrderExits(userid);
                if (isexist) {
                  Get.back();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: contentBox(context),
                      );
                    },
                  );
                } else {
                  groupcontroller.deleteMember(userid);
                  Get.back();
                }
              },
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Remove",
                  style: TextStyle(
                    color: Color.fromARGB(255, 225, 6, 6),
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 255, 17, 0),
                  size: 30.sp,
                ),
                SizedBox(height: 20),
                const Text(
                  'Cannot Remove User',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'User have ordered under this group.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 26.sp,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ),
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'Group',
          style: AppStyles.appbar,
        ),
      ),
      body: Obx(() {
        if (logincontroller.isGroupId.value) {
          if (groupcontroller.isloading.value ||
              logincontroller.isFetchLoading.value) {
            return LoadingWidget();
          } else if (groupcontroller.fetchGroupedData.value) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 3.5.w, horizontal: 3.5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${groupcontroller.groupResponse.value.response!.first.groupName} || ${groupcontroller.groupResponse.value.response!.first.groupCode}",
                          style: AppStyles.topicsHeading,
                        ),
                        groupcontroller.groupResponse.value.response!.first
                                    .moderator ==
                                logincontroller
                                    .userDataResponse.value.response!.first.name
                            ? GestureDetector(
                                onTap: () {
                                  friendlistcontroller
                                      .fetchFrields()
                                      .then((value) {
                                    Get.to(() => FriendList(
                                          groupId: groupcontroller.groupResponse
                                              .value.response!.first.groupId,
                                        ));
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person_add,
                                    size: 19.sp,
                                    color: AppColors.backgroundColor,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 58.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 161, 156, 156),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "All orders placed by group members are grouped together.",
                          maxLines: 2,
                          style: AppStyles.listTilesubTitle,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Obx(() {
                        if (groupcontroller.grouMemberFetch.value) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.5.h),
                            child: ListView.builder(
                              itemCount: groupcontroller
                                  .groupMemberResponse.value.response!.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 0.4.h),
                                  child: Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: ListTile(
                                        title: Text(
                                          '  ${groupcontroller.groupMemberResponse.value.response![index].name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.sp,
                                              color: Color.fromARGB(
                                                  255, 84, 84, 84)),
                                        ),
                                        subtitle: Text(
                                          '  ${groupcontroller.groupMemberResponse.value.response![index].phone}',
                                          style: AppStyles.listTilesubTitle,
                                        ),
                                        leading: Stack(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: CircleAvatar(
                                                radius: 22.sp,
                                                backgroundColor: Colors.white,
                                                child: CachedNetworkImage(
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          CircleAvatar(
                                                    radius: 21.4.sp,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    ),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 224, 218, 218),
                                                  ),
                                                  imageUrl: groupcontroller
                                                          .groupMemberResponse
                                                          .value
                                                          .response![index]
                                                          .profilePicture ??
                                                      '',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape
                                                          .circle, // Apply circular shape
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  fit: BoxFit.fill,
                                                  width: double.infinity,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          CircleAvatar(
                                                    radius: 21.4.sp,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                    ),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 224, 218, 218),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Obx(() {
                                              if (groupcontroller
                                                      .groupResponse
                                                      .value
                                                      .response!
                                                      .first
                                                      .groupId ==
                                                  groupcontroller
                                                      .groupMemberResponse
                                                      .value
                                                      .response![index]
                                                      .userid) {
                                                return Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: CircleAvatar(
                                                    radius: 7.5,
                                                    backgroundColor: Color.fromARGB(
                                                        255,
                                                        72,
                                                        2,
                                                        129), // Adjust color as needed
                                                    child: Icon(
                                                      Icons.shield_outlined,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors
                                                        .transparent, // Adjust color as needed
                                                  ),
                                                );
                                              }
                                            })
                                          ],
                                        ),
                                        onTap: () {
                                          if (groupcontroller
                                                  .groupResponse
                                                  .value
                                                  .response!
                                                  .first
                                                  .groupId ==
                                              logincontroller
                                                  .userDataResponse
                                                  .value
                                                  .response!
                                                  .first
                                                  .userid) {
                                            groupcontroller
                                                        .groupResponse
                                                        .value
                                                        .response!
                                                        .first
                                                        .groupId ==
                                                    groupcontroller
                                                        .groupMemberResponse
                                                        .value
                                                        .response![index]
                                                        .userid
                                                ? null
                                                : _showGroupNameDialog(
                                                    context,
                                                    "${groupcontroller.groupMemberResponse.value.response![index].name}",
                                                    "${groupcontroller.groupMemberResponse.value.response![index].userid}");
                                          }

                                          // Action when the item is tapped
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                      Obx(() => groupcontroller.deleteMemberLoading.value
                          ? LoadingWidget()
                          : SizedBox.shrink())
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        logincontroller.fetchUserData();
                      },
                      child: logincontroller.isFetchLoading.value
                          ? CircularProgressIndicator()
                          : Icon(
                              Icons.refresh,
                              size: 40,
                              color: Colors.grey,
                            ),
                    );
                  }),
                  SizedBox(height: 16),
                  Text(
                    "Something Went wrong",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            );
          }
        } else {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Start your group or join in a group",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      'Start ordering food in a group.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Show dialog for entering group name
                              Get.to(() => NewGroupCreate());
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              "Start",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          color: Colors.black,
                          onPressed: () {
                            // Call the refresh method or handle the refresh action
                            logincontroller.fetchUserData();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (logincontroller.isFetchLoading.value) {
                  groupcontroller.fetchGroupData();
                  groupcontroller.fecthGroupMember();
                  return LoadingWidget();
                } else {
                  return SizedBox.shrink();
                }
              })
            ],
          );
        }
      }),
    );
  }
}
