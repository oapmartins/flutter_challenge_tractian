import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/enums/loading_status.dart';
import 'package:flutter_challenge_tractian/features/tree/presentation/controllers/assets_controller.dart';
import 'package:get_it/get_it.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({
    super.key,
    required this.companyId,
  });

  final String companyId;

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AssetsController _assetsController = GetIt.I<AssetsController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _assetsController.initServicesAssetController(companyId: widget.companyId);
    });

    super.initState();
  }

  @override
  void dispose() {
    GetIt.I.resetLazySingleton<AssetsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Assets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _assetsController.loadingLocations,
        builder: (BuildContext context, LoadingStatus loadingStatus, child) {
          if (loadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (loadingStatus == LoadingStatus.error) {
            return const Center(
              child: Text('Error ao consultar assets'),
            );
          }
          return Column(
            children: [
              Column(
                children: [
                  SearchBar(
                    hintText: 'Pesquisar veículo',
                    // onChanged: controller.filterListCar,
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                    ),
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text('Sendor de Energia'),
                      Text('Crítico'),
                    ],
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _assetsController.listAlllocations.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
