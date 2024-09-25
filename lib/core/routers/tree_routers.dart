import 'package:flutter_challenge_tractian/features/tree/presentation/pages/assets_page.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/pages/menu_page.dart';
import 'package:go_router/go_router.dart';

// ignore_for_file: constant_identifier_names

class TreeRouters {
  static const String MENU = '/';
  static const String ASSETS_TREE = '/assets';
}

class TreeRoutersPage {
  TreeRoutersPage._(); // Construtor privado para evitar instância

  static final List<GoRoute> router = [
    GoRoute(
      path: TreeRouters.MENU,
      builder: (context, state) => const MenuPage(),
    ),
    GoRoute(
      path: '${TreeRouters.ASSETS_TREE}/:companyId',
      builder: (context, state) {
        final String companyId = state.pathParameters['companyId'] ?? '662fd0ee639069143a8fc387';
        return AssetsPage(companyId: companyId);
      },
    ),
  ];
}
