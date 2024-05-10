import 'package:equatable/equatable.dart';
import 'package:tolovde_pay/data/form_status/forms_status.dart';

import '../../data/models/card_model.dart';

class CardsState extends Equatable {
  final List<CardModel> userCards;
  final List<CardModel> cardsDB;
  final List<CardModel> activeCards;
  final FormsStatus status;
  final String errorMessage;
  final String statusMessage;

  const CardsState({
    required this.status,
    required this.userCards,
    required this.activeCards,
    required this.errorMessage,
    required this.statusMessage,
    required this.cardsDB,
  });

  CardsState copyWith({
    List<CardModel>? userCards,
    List<CardModel>? cardsDB,
    List<CardModel>? activeCards,
    FormsStatus? status,
    String? errorMessage,
    String? statusMessage,
  }) {
    return CardsState(
      userCards: userCards ?? this.userCards,
      status: status ?? this.status,
      activeCards: activeCards ?? this.activeCards,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      cardsDB: cardsDB ?? this.cardsDB,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userCards,
        errorMessage,
        activeCards,
        statusMessage,
        cardsDB,
      ];
}
