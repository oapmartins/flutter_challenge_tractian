import 'package:flutter/material.dart';
import 'package:flutter_challenge_tractian/core/routers/tree_routers.dart';
import 'package:flutter_challenge_tractian/features/tree/domain/entities/company_entity.dart';
import 'package:go_router/go_router.dart';

class CardMenuWidget extends StatelessWidget {
  const CardMenuWidget({
    super.key,
    required this.companyEntity,
  });

  final CompanyEntity companyEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('${TreeRouters.ASSETS_TREE}/${companyEntity.id}');
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 76,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xff2188FF),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 33),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/vectors/Vector.png',
                    ),
                    const SizedBox(width: 16),
                    Text(
                      companyEntity.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
