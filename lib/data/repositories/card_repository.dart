import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tolovde_pay/data/models/card_model.dart';
import 'package:tolovde_pay/data/models/user_model.dart';
import 'package:tolovde_pay/data/network/response.dart';
import 'package:tolovde_pay/utils/constants/app_constants.dart';

class CardsRepository {
  Future<NetworkResponse> addCard(
      CardModel cardModel, UserModel userModel, String color) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .add(cardModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(documentReference.id)
          .update({
        "cardId": documentReference.id,
        "cardHolder": userModel.userName,
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "color": color
      });

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      debugPrint("CARD ADD ERROR:$error");
      return NetworkResponse(errorText: error.toString());
    }
  }

  Future<NetworkResponse> updateCard(CardModel cardModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(cardModel.cardId)
          .update(cardModel.toJsonForUpdate());

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Future<NetworkResponse> deleteCard(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .doc(docId)
          .delete();

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      return NetworkResponse(errorText: error.toString());
    }
  }

  Stream<List<CardModel>> getCardsByUserId(String userId) =>
      FirebaseFirestore.instance
          .collection(AppConstants.cards)
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((event) =>
              event.docs.map((doc) => CardModel.fromJson(doc.data())).toList());

  Stream<List<CardModel>> getAllCards() => FirebaseFirestore.instance
      .collection(AppConstants.allCards)
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => CardModel.fromJson(doc.data())).toList());
}
