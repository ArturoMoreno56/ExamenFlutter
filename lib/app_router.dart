import 'package:go_router/go_router.dart';
import 'view/home.dart';
import 'view/detail_page.dart';
import 'view/create_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (_, state) {
        final id = int.parse(state.pathParameters["id"]!);
        return DetailPage(id: id);
      },
    ),
    GoRoute(
      path: '/create',
      builder: (_, __) => const CreatePage(),
    ),
  ],
);
