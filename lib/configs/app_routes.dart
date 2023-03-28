  import 'package:flutter/material.dart';
  import 'package:go_router/go_router.dart';
  import 'package:pertemuan_lima/modul/news_detail/news_detail.dart';
  import 'package:pertemuan_lima/modul/splash_screen/splash_screen.dart';

  import '../models/user.dart';
  import '../modul/home_screen/home_screen.dart';

  class AppRoutes {
    static const String splash = "splash";
    static const String home = "home";
    static const String profile = "profile";
    static const String newsDetail = "news-detail";

    static Page _splashScreenRouteBuilder(
      BuildContext context,
      GoRouterState state,
    ) {
      return MaterialPage(
        key: state.pageKey,
        child: const SplashScreen(),
      );
    }

    static Page _homeScreenRoutePageBuilder(
      BuildContext context,
      GoRouterState state,
    ) {
      late User user;
      if (state.extra != null && state.extra is User) {
        user = state.extra as User;
      } else {
        user = User(
          id: 002,
          name: "Dzikri Aprila",
          userName: "Dzikri",
          email: "2006005@itg.ac.id",
          profileImage:
              "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=785&q=80",
          phoneNumber: "0888888888888",
        );
      }
      return CustomTransitionPage(
        child: HomeScreen(
          key: state.pageKey,
          user: user,
        ),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    }

    static Page _newsDetailScreenRouteBuilder(
      BuildContext context,
      GoRouterState state,
    ) {
      if (state.params["id"] != null) {
        return MaterialPage(
          key: state.pageKey,
          child: NewsDetailScreen(
            newsId: state.params["id"]!,
          ),
        );
      } else {
        return const MaterialPage(
          child: Scaffold(
            body: Center(
              child: Text("Data Not Found"),
            ),
          ),
        );
      }
    }

    static final GoRouter goRouter = GoRouter(
      routerNeglect: true,
      routes: [
        GoRoute(
          name: splash,
          path: "/splash",
          pageBuilder: _splashScreenRouteBuilder,
        ),
        GoRoute(
          name: home,
          path: "/home",
          pageBuilder: _homeScreenRoutePageBuilder,
          routes: [
            GoRoute(
              name: newsDetail,
              path: "news-detail/:id",
              pageBuilder: _newsDetailScreenRouteBuilder,
            ),
          ],
        ),
      ],
      initialLocation: "/splash",
    );
  }
