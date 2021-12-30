part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

// ignore: must_be_immutable
class PostStatus extends PostState {
  Status status;
  List<Post>? data;
  String? message;

  PostStatus.loading() : status = Status.LOADING;
  PostStatus.completed(this.data) : status = Status.COMPLETED;
  PostStatus.error(this.message) : status = Status.ERROR;
}