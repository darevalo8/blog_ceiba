part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

// ignore: must_be_immutable
class UserStatus extends UserState {
  Status status;
  List<User>? data;
  String? message;

  UserStatus.loading() : status = Status.LOADING;
  UserStatus.completed(this.data) : status = Status.COMPLETED;
  UserStatus.error(this.message) : status = Status.ERROR;
}