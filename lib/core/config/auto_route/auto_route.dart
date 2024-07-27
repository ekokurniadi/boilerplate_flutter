import 'package:auto_route/auto_route.dart';
import 'package:boilerplate_flutter/features/homepage/presentations/screen/home_screen.dart';
part 'auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomePageRoute.page,
          initial: true,
        )
      ];
}
