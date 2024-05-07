import 'package:equatable/equatable.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/data/models/user_model.dart';

abstract class CardsEvent extends Equatable {}

class AddCardEvent extends CardsEvent {
  final CardModel cardModel;
  final UserModel userModel;
  final String color;

  AddCardEvent(this.cardModel,this.userModel, this.color);

  @override
  List<Object?> get props => [cardModel,userModel,color];
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

class GetAllCards extends CardsEvent {
  GetAllCards();

  @override
  List<Object?> get props => [];
}
