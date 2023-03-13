part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}



class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostLoading extends PostState {
  final List<Post> oldPosts;
  final bool isFirstFetch;

  PostLoading(this.oldPosts, {this.isFirstFetch = false});
}

class PostError extends PostState {}