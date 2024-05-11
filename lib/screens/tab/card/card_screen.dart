import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/card/cards_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/card/cards_state.dart';
import 'package:tolovde_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/screens/routes.dart';
import 'package:tolovde_pay/screens/tab/card/widgets/card_item_view.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    context.read<CardsBloc>().add(GetCardsByUserId(
        userId: context.read<UserProfileBloc>().state.userModel.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Cards",
          style: AppTextStyle.interSemiBold
              .copyWith(color: Colors.black, fontSize: 24.sp),
        ),
      ),
      body: BlocBuilder<CardsBloc, CardsState>(
        builder: (context, state) {
          return Column(children: [
            CarouselSlider(
              items: List.generate(
                state.userCards.length + 1,
                (index) {
                  if (index == state.userCards.length) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.addCardRoute);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            width: 1.w,
                            color: Colors.black,
                          )
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 50.w,
                          ),
                        ),
                      ),
                    );
                  }
                  CardModel cardModel = state.userCards[index];
                  return CardItemView(
                    chipVisibility: false,
                    cardModel: cardModel,
                  );
                },
              ),
              options: CarouselOptions(
                aspectRatio: 16 / 7,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.1,
                scrollDirection: Axis.horizontal,
              ),
            )
          ]);
        },
      ),
    );
  }
}
