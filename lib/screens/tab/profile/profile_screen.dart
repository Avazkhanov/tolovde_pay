import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/auth/auth_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_state.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/screens/widgets/my_custom_button.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_EEEEEE,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 10), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.updateUserRoute,
                                    arguments: state.userModel);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 24.sp,
                              ))
                        ],
                      ),
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: state.userModel.imageUrl,
                          imageBuilder: (context, imageProvider) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.network(
                                state.userModel.imageUrl,
                                width: 120.w,
                                height: 120.h,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          errorWidget: (context, image, error) {
                            return Icon(
                              CupertinoIcons.person_circle_fill,
                              color: Colors.black,
                              size: 120.sp,
                            );
                          },
                        ),
                      ),
                      10.verticalSpace,
                      Text(state.userModel.userName,
                          style:
                              AppTextStyle.interBold.copyWith(fontSize: 22.sp)),
                      5.verticalSpace,
                      Text(state.userModel.lastName,
                          style:
                              AppTextStyle.interBold.copyWith(fontSize: 22.sp)),
                      5.verticalSpace,
                      Text(state.userModel.phoneNumber,
                          style:
                              AppTextStyle.interBold.copyWith(fontSize: 22.sp)),
                    ],
                  ),
                ),
                const Spacer(),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return MyCustomButton(
                      isLoading: isLoading,
                      title: "Log Out",
                      onTap: () {
                        context.read<AuthBloc>().add(LogOutEvent());
                      },
                      color: Colors.red,
                    );
                  },
                  listener: (BuildContext context, AuthState state) {
                    if(state is AuthLoadState){
                      isLoading = true;
                    }
                    if(state is AuthSuccessState){
                      Navigator.pushReplacementNamed(context, RouteNames.register);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
