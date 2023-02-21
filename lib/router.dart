import 'package:authtd/data/models/posts.dart';
import 'package:authtd/pages/home_page.dart';
import 'package:authtd/post_screen/add_comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'const/strings.dart';
import 'cubit/add_post_cubit.dart';
import 'cubit/comment_cubit.dart';
import 'cubit/edit_post_cubit.dart';
import 'cubit/posts_cubit.dart';
import 'data/network_service.dart';
import 'data/repository.dart';
import 'pages/login_registred_page.dart';
import 'post_screen/add_post_screen.dart';
import 'post_screen/edit_post_screen.dart';
import 'post_screen/posts_screen.dart';


class AppRouter {
  late Repository repository;
  late PostsCubit postsCubit;

  AppRouter () {
    repository = Repository(networkService: NetworkService());
    postsCubit = PostsCubit(repository: repository);
  }

  MaterialPageRoute? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/posts":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: postsCubit,
            child: const PostsScreen(),
          ),
        );
      case "/home":
      return MaterialPageRoute(
      builder: (_) => HomePage(),
      );
      case "/login":
      return MaterialPageRoute(
      builder: (_) => const LoginPage(),
      );
      case EDIT_POST_ROUTE:
        final post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => EditPostCubit(
              repository: repository,
              postsCubit: postsCubit,
            ),
            child: EditPostScreen(post: post,),
          ),
        );
      case ADD_POST_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddPostCubit(
              repository: repository,
              postsCubit: postsCubit,
            ),
            child: AddPostScreen(),
          ),
        );
      case COMMENT_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CommentsCubit(
              repository: repository,
            ),
            child: AddCommentScreen(),
          ),
        );
      /*case SEARCH_POST_ROUTE:
        return MaterialPageRoute(
          builder: (_) => SearchResultsWidget()
        );*/
      default:
        return null;
    }
  }
}