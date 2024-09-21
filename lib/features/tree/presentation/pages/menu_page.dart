import 'package:flutter/material.dart' hide MenuController;
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/menu_controller.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/widgets/card_menu_widget.dart';
import 'package:get_it/get_it.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final MenuController _menuController = GetIt.I<MenuController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _menuController.getCompanies();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/LOGO TRACTIAN.png',
            )
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _menuController.loading,
        builder: (BuildContext context, LoadingStatus loadingStatus, child) {
          if (loadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (loadingStatus == LoadingStatus.error) {
            return const Center(
              child: Text('Error ao consultar menu'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            itemCount: _menuController.companies.length,
            itemBuilder: (BuildContext context, int index) {
              return CardMenuWidget(
                companyEntity: _menuController.companies[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 40); // Espaçamento entre os itens
            },
          );
        },
      ),
    );
  }
}
