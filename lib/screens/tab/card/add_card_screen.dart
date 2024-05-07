import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/card/cards_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/card/cards_state.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_bloc.dart';
import 'package:tolovde_pay/data/form_status/forms_status.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/screens/dialogs/unical_dialog.dart';
import 'package:tolovde_pay/screens/tab/card/widgets/color_item.dart';
import 'package:tolovde_pay/screens/widgets/button_container.dart';
import 'package:tolovde_pay/screens/widgets/text_field_container.dart';
import 'package:tolovde_pay/utils/formaters/formatters.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
  String activeColor = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Card",
          style: AppTextStyle.interBold.copyWith(fontSize: 22.sp),
        ),
      ),
      body: BlocConsumer<CardsBloc, CardsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                TextFieldContainer(
                  labelText: 'Card Number',
                  hintText: "XXXX XXXX XXXX XXXX",
                  keyBoardType: TextInputType.number,
                  controller: cardNumberController,
                  maskTextInputFormatter:
                      AppInputFormatters.cardNumberFormatter,
                ),
                SizedBox(height: 20.h),
                TextFieldContainer(
                  labelText: 'Expire Date',
                  hintText: "MM/YY",
                  keyBoardType: TextInputType.number,
                  controller: expireDateController,
                  maskTextInputFormatter:
                      AppInputFormatters.cardExpirationDateFormatter,
                ),
                ColorItem(
                  color: (color) {
                    activeColor = color.toString();
                    activeColor = activeColor.substring(6,activeColor.length-1);
                  },
                ),
                const Spacer(),
                ButtonContainer(
                  title: "Save",
                  isLoading: state.status == FormsStatus.loading,
                  onTap: () {
                    if(cardNumberController.text.isNotEmpty && expireDateController.text.isNotEmpty && activeColor.isNotEmpty){
                      List<CardModel> allCards = state.cardsDB;
                      List<CardModel> myCards = state.userCards;
                      bool isExist = false;
                      for (var element in myCards) {
                        if (element.cardNumber == cardNumberController.text) {
                          isExist = true;
                          break;
                        }
                      }
                      CardModel? cardModel;
                      bool hasInDB = false;
                      for (var element in allCards) {
                        if (element.cardNumber == cardNumberController.text) {
                          hasInDB = true;
                          cardModel = element;
                          break;
                        }
                      }

                      if ((!isExist) && hasInDB) {
                        context.read<CardsBloc>().add(AddCardEvent(cardModel!,context.read<UserProfileBloc>().state.userModel,activeColor));
                      } else {
                        showUnicalDialog(
                            errorMessage:
                            "Karta allaqachon qo'shilgan yoki bazada mavjud emas!");
                      }
                    }else{
                      showUnicalDialog(errorMessage: "Maydonlarni to'liq kiriting");
                    }
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
        listener: (context, state) {
          if(state.statusMessage == "added"){
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
