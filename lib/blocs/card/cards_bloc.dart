import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/card/cards_event.dart';
import 'package:tolovde_pay/blocs/card/cards_state.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/data/models/forms_status.dart';
import 'package:tolovde_pay/data/models/network_response.dart';

import '../../data/repositories/cards_repository.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc({required this.cardsRepository})
      : super(
          const CardsState(
            userCards: [],
            cardsDB: [],
            activeCards: [],
            status: FormsStatus.pure,
            errorMessage: "",
            statusMessage: "",
          ),
        ) {
    on<AddCardEvent>(_addCard);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<GetCardsByUserId>(_listenCard);
    on<GetActiveCards>(_listenActiveCard);
    on<GetCardsDatabaseEvent>(_listenCardsDatabase);
  }

  final CardsRepository cardsRepository;

  _addCard(AddCardEvent event, emit) async {
    emit(state.copyWith(status: FormsStatus.loading));

    NetworkResponse response = await cardsRepository.addCard(
        event.cardModel, event.userId, event.cardHolder);
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

  _listenActiveCard(GetActiveCards event, Emitter emit) async {
    await emit.onEach(
      cardsRepository.getActiveCards(),
      onData: (List<CardModel> activeCards) {
        emit(state.copyWith(activeCards: activeCards));
      },
    );
  }

  _listenCardsDatabase(GetCardsDatabaseEvent event, Emitter emit) async {
    debugPrint("DATABASE CARDS");
    await emit.onEach(
      cardsRepository.getCardsDatabase(),
      onData: (List<CardModel> db) {
        debugPrint("DATABASE CARDS LENGTH${db.length}");
        emit(state.copyWith(cardsDB: db));
      },
    );
  }
}
