import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_event.dart';
import 'package:tolovde_pay/screens/widgets/button_container.dart';
import 'package:tolovde_pay/screens/widgets/my_text_field.dart';
import 'package:tolovde_pay/utils/validates/app_validates.dart';

import '../../../../data/models/user_model.dart';

class UserUpdateScreen extends StatefulWidget {
  const UserUpdateScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UserUpdateScreen> createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  late UserModel userModel;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    userModel = widget.userModel;
    lastNameController.text = userModel.lastName;
    firstNameController.text = userModel.userName;
    phoneNumberController.text = userModel.phoneNumber;
    passwordController.text = userModel.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: userModel.imageUrl,
                imageBuilder: (context, imageProvider) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      userModel.imageUrl,
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                errorWidget: (context, image, error) {
                  return Icon(
                    CupertinoIcons.person_circle_fill,
                    color: Colors.black,
                    size: 150.sp,
                  );
                },
              ),
              SizedBox(height: 20.h),
              MyTextFieldWidget(
                hintText: "Last Name",
                keyBoardType: TextInputType.text,
                controller: lastNameController,
              ),
              MyTextFieldWidget(
                hintText: "First Name",
                keyBoardType: TextInputType.text,
                controller: firstNameController,
              ),
              MyTextFieldWidget(
                keyBoardType: TextInputType.text,
                hintText: "Phone Number",
                controller: phoneNumberController,
              ),
              MyTextFieldWidget(
                hintText: "Password",
                keyBoardType: TextInputType.text,
                controller: passwordController,
                isObscureText: true,
              ),
              10.verticalSpace,
              ButtonContainer(
                title: "Update User",
                background: Colors.blue,
                isLoading: false,
                borderColor: Colors.blue,
                onTap: () {
                  context.read<UserProfileBloc>().add(
                        UpdateUserProfileEvent(
                          userModel: userModel.copyWith(
                            email: userModel.email,
                            userName: firstNameController.text,
                            uuId: FirebaseAuth.instance.currentUser!.uid,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                          ),
                        ),
                      );
                  context
                      .read<UserProfileBloc>()
                      .add(GetUserProfileByUuIdEvent());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get checkInput {
    return AppValidates.passwordExp.hasMatch(passwordController.text);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
