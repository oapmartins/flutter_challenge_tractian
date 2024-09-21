import 'package:flutter_challenge_tractian/features/tree/presentation/pages/assets_page.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/pages/menu_page.dart';
import 'package:go_router/go_router.dart';

// ignore_for_file: constant_identifier_names

class TreeRouters {
  static const MENU = '/';
  static const ASSETS_TREE = '/assets';
}

class TreeRoutersPage {
  TreeRoutersPage._();
  static final router = <GoRoute>[
    GoRoute(
      path: TreeRouters.MENU,
      builder: (context, state) => const MenuPage(),
    ),
    GoRoute(
      path: TreeRouters.ASSETS_TREE,
      builder: (context, state) {
        // final companyId = state.pathParameters['companyId'] ?? '662fd0ee639069143a8fc387';
        return const AssetsPage(companyId: '662fd0ee639069143a8fc387');
      },
    ),
  ];
}
