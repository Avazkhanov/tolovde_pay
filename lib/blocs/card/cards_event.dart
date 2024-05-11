import 'package:equatable/equatable.dart';
import 'package:tolovde_pay/data/models/card_model.dart';

abstract class CardsEvent extends Equatable {}

class AddCardEvent extends CardsEvent {
  final CardModel cardModel;
  final String userId;

  AddCardEvent(this.cardModel, this.userId);

  @override
  List<Object?> get props => [cardModel,userId];
}

class UpdateCardEvent extends CardsEvent {
  final CardModel cardModel;

  UpdateCardEvent(this.cardModel);

  @override
  List<Object?> get props => [cardModel];
}

class DeleteCardEvent extends CardsEvent {
  final String cardDocId;

  DeleteCardEvent(this.cardDocId);

  @override
  List<Object?> get props => [cardDocId];
}

class GetCardsByUserId extends CardsEvent {
  GetCardsByUserId({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class GetActiveCards extends CardsEvent {
  @override
  List<Object?> get props => [];
}

class GetCardsDatabaseEvent extends CardsEvent {
  GetCardsDatabaseEvent();

  @override
  List<Object?> get props => [];
}
