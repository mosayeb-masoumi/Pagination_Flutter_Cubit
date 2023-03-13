import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pagination_flutter_cubit/post_model.dart';
import 'package:pagination_flutter_cubit/repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _repository;
  static const int _pageSize = 10;
  int _page = 1;
  PostCubit(this._repository) : super(PostInitial());

  void loadPosts(){

    if(state is PostLoading) return;

    final currentState = state;
    var oldPosts = <Post>[];

    if(currentState is PostLoaded){
      oldPosts = currentState.posts;
    }
    
    emit(PostLoading(oldPosts , isFirstFetch: _page ==1));
    
    _repository.fetchPosts(_page).then((newPosts){
      _page++;

      final posts = (state as PostLoading).oldPosts;
      posts.addAll(newPosts);
      
      emit(PostLoaded(posts));

    } );
    
  }
}


