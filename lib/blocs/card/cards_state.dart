import 'package:equatable/equatable.dart';
import 'package:tolovde_pay/data/models/forms_status.dart';

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
    required this.errorMessage,
    required this.statusMessage,
    required this.cardsDB,
    required this.activeCards,
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
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      cardsDB: cardsDB ?? this.cardsDB,
      activeCards: activeCards ?? this.activeCards,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userCards,
        errorMessage,
        statusMessage,
        cardsDB,
        activeCards,
      ];
}
