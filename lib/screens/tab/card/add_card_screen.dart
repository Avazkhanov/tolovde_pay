import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/blocs/card/cards_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/card/cards_state.dart';
import 'package:tolovde_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/data/models/forms_status.dart';
import 'package:tolovde_pay/screens/dialogs/unical_dialog.dart';
import 'package:tolovde_pay/screens/tab/card/widgets/card_item_view.dart';
import 'package:tolovde_pay/screens/tab/card/widgets/card_number_input.dart';
import 'package:tolovde_pay/screens/tab/card/widgets/expire_date_input.dart';
import 'package:tolovde_pay/screens/widgets/my_custom_button.dart';
import 'package:tolovde_pay/utils/styles/app_text_style.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expireDate = TextEditingController();

  final FocusNode cardFocusNode = FocusNode();
  final FocusNode expireDateFocusNode = FocusNode();
  CardModel cardModel = CardModel.initial();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Karta biriktirish",
          style: AppTextStyle.interSemiBold
              .copyWith(color: Colors.black, fontSize: 24.sp),
        ),
      ),
      body: BlocConsumer<CardsBloc, CardsState>(
        builder: (context, state) {
          return Column(
            children: [
              CardItemView(cardModel: cardModel),
              CardNumberInput(
                controller: cardNumber,
                focusNode: cardFocusNode,
              ),
              ExpireDateInput(
                focusNode: expireDateFocusNode,
                controller: expireDate,
              ),
              const Spacer(),
              MyCustomButton(
                onTap: () {
                  List<CardModel> allCards = state.cardsDB;
                  List<CardModel> myCards = state.userCards;
                  bool isExist = false;
                  for (var element in myCards) {
                    if (element.cardNumber == cardNumber.text) {
                      isExist = true;
                      break;
                    }
                  }
                  bool hasInDB = false;
                  for (var element in allCards) {
                    if (element.cardNumber == cardNumber.text) {
                      hasInDB = true;
                      cardModel = element;
                      break;
                    }
                  }

                  if ((!isExist) && hasInDB) {
                    context.read<CardsBloc>().add(AddCardEvent(
                        cardModel,
                        context.read<UserProfileBloc>().state.userModel.userId,
                        context
                            .read<UserProfileBloc>()
                            .state
                            .userModel
                            .username));
                  } else {
                    showUniqueDialog(
                        errorMessage:
                            "Karta allaqachon qo'shilgan yoki bazada mavjud emas!");
                  }
                },
                title: "Qo'shish",
                isLoading: state.status == FormsStatus.loading,
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.statusMessage == "added") {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
