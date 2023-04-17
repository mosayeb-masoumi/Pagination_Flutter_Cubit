
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pagination_flutter_cubit/bloc/post_cubit.dart';
import 'package:pagination_flutter_cubit/post_model.dart';
import 'package:pagination_flutter_cubit/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatelessWidget {
 HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostCubit(PostRepository())),
      ],
      child: IHomePage(),
    );
  }
}

class IHomePage extends StatelessWidget {
   IHomePage({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  void setupScrollController(context){
    _scrollController.addListener(() {
      if(_scrollController.position.atEdge){ // atEdge mean bottom of list
         if(_scrollController.position.pixels !=0 ){  //pixels ==0 means listView is at top
           BlocProvider.of<PostCubit>(context).loadPosts();
         }
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    // in statefullWidget we should use below 2 lines in init state() method
    setupScrollController(context);
    BlocProvider.of<PostCubit>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),

      body: BlocConsumer<PostCubit , PostState>(
        listener: (context , state){
        },
        builder: (context , state){
          if(state is PostLoading && state.isFirstFetch){
            return _loadingIndicator();
          }

          List<Post> posts =[];
          bool isLoading = false;

          if(state is PostLoading){
            posts = state.oldPosts;
            isLoading = true;
          }else if(state is PostLoaded){
            posts = state.posts;
          }

          return ListView.separated(
              controller: _scrollController,
              itemBuilder: (context , index){
               if(index < posts.length){
                 return _postItem(posts[index] , context , index);
               }else {
                 
                 Timer(Duration(milliseconds: 30), () {
                   _scrollController.jumpTo(
                     _scrollController.position.maxScrollExtent, // entire height of list
                   );
                 });

                 return _loadingIndicator();
               }

              },
              separatorBuilder: (context , index){
                return Divider(color: Colors.grey[400],);
              },
              itemCount: posts.length + (isLoading? 1 :0));

        },
      ),
    );
  }

  Widget _loadingIndicator() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Center(child: CircularProgressIndicator(color: Colors.red,),));
  }

  Widget _postItem(Post post, BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(child: Text("${post.title} $index" , style: TextStyle(color: Colors.white , fontSize: 20),),),
    );
  }


}



