import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/card/cards_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/card/cards_state.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    debugPrint("USER UUID ${FirebaseAuth.instance.currentUser!.uid}");
    context
        .read<CardsBloc>()
        .add(GetCardsByUserId(userId: FirebaseAuth.instance.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CardsBloc, CardsState>(
        builder: (context, state) {
          return CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(milliseconds: 400),
              viewportFraction: .85,
            ),
            items: List.generate(
              state.userCards.length + 1,
              (index) {
                if (index == state.userCards.length) {
                  return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.white,
                          border: Border.all(
                              width: 1.w, color: AppColors.c_1A72DD)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.addCardRoute);
                        },
                        child: const Icon(Icons.add),
                      ));
                }
                CardModel cardModel = state.userCards[index];
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(int.parse(cardModel.color)),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cardModel.bank,style: AppTextStyle.interBold.copyWith(fontSize: 22.sp)),
                        SizedBox(height: 25.h),
                        Text("${cardModel.balance} so'm",style: AppTextStyle.interRegular.copyWith(fontSize: 20.sp)),
                        SizedBox(height: 10.h),
                        Text(cardModel.cardNumber,style: AppTextStyle.interRegular.copyWith(fontSize: 24.sp)),
                        const Spacer(),
                        Text(cardModel.expireDate,style: AppTextStyle.interRegular.copyWith(fontSize: 18.sp)),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
