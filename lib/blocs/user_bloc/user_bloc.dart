
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_event.dart';
import 'package:tolovde_pay/blocs/user_bloc/user_state.dart';
import 'package:tolovde_pay/data/form_status/forms_status.dart';
import 'package:tolovde_pay/data/models/user_model.dart';
import 'package:tolovde_pay/data/repositories/user_repository.dart';

import '../../data/network/response.dart';


class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this.userRepository)
      : super(
    UserProfileState(
      userModel: UserModel.initial(),
      formStatus: FormsStatus.pure,
      errorText: "",
      statusMessage: "",
    ),
  ) {
    on<AddUserProfileEvent>(_addUser);

    on<DeleteUserProfileEvent>(_deleteUser);

    on<UpdateUserProfileEvent>(_updateUser);

    on<GetUserProfileByDocIdEvent>(_getUserByDocId);

    on<GetUserProfileByUuIdEvent>(_getUserByUuId);
  }

  final UserRepository userRepository;

  Future<void> _addUser(AddUserProfileEvent event, emit) async {


    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
    await userRepository.insertUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormsStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormsStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _deleteUser(DeleteUserProfileEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
    await userRepository.deleteUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(
          formStatus: FormsStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _updateUser(UpdateUserProfileEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
    await userRepository.updateUser(userModel: event.userModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormsStatus.success));
    } else {
      emit(state.copyWith(
          formStatus: FormsStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _getUserByDocId(GetUserProfileByDocIdEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
    await userRepository.getUserByDocId(docId: event.userModel.userId);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formStatus: FormsStatus.unauthenticated));
    } else {
      emit(state.copyWith(
          formStatus: FormsStatus.error, errorText: networkResponse.errorText));
    }
  }

  Future<void> _getUserByUuId(GetUserProfileByUuIdEvent event, emit) async {
    emit(state.copyWith(formStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await userRepository.getUserByUuId();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
          formStatus: FormsStatus.success,
          userModel: networkResponse.data as UserModel,
          statusMessage: "success"));
    } else {
      debugPrint(networkResponse.errorText.toString());

      emit(state.copyWith(
          formStatus: FormsStatus.error, errorText: networkResponse.errorText));
    }
  }
}