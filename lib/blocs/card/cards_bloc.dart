import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/card/cards_state.dart';
import 'package:tolovde_pay/data/form_status/forms_status.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/data/network/response.dart';
import 'package:tolovde_pay/data/repositories/card_repository.dart';


class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({required this.cardsRepository})
      : super(
          const CardsState(
            userCards: [],
            cardsDB: [],
            status: FormsStatus.pure,
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<GetCardsByUserId>(_listenCard);
    on<GetAllCards>(_listenCardsDatabase);
  }

  final CardsRepository cardsRepository;

  _addCard(AddCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response = await cardsRepository.addCard(event.cardModel,event.userModel,event.color);
    if (response.errorText.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          statusMessage: "added",
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: response.errorText,
      ));
    }
  }

  _updateCard(UpdateCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response =
        await cardsRepository.updateCard(event.cardModel);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.success));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: response.errorText,
      ));
    }
  }

  _deleteCard(DeleteCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response =
        await cardsRepository.deleteCard(event.cardDocId);
    if (response.errorText.isEmpty) {
      emit(state.copyWith(status: FormsStatus.success));
    } else {
      emit(state.copyWith(
        status: FormsStatus.error,
        errorMessage: response.errorText,
      ));
    }
  }

  _listenCard(GetCardsByUserId event, Emitter emit) async {
    await emit.onEach(
      cardsRepository.getCardsByUserId(event.userId),
      onData: (List<CardModel> userCards) {
        emit(state.copyWith(userCards: userCards));
      },
    );
  }

  _listenCardsDatabase(GetAllCards event, Emitter emit) async {
    await emit.onEach(
      cardsRepository.getAllCards(),
      onData: (List<CardModel> db) {
        emit(state.copyWith(cardsDB: db));
      },
    );
  }
}
