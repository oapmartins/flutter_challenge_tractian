import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleNodeTreeWidget extends StatelessWidget {
  const TitleNodeTreeWidget({
    super.key,
    required this.title,
    this.typeNode,
    this.sensorType,
    this.sensorStatus,
  });

  final String title;
  final String? typeNode;
  final String? sensorType;
  final String? sensorStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          typeNode == 'location'
              ? Image.asset('assets/vectors/Vector (3).png')
              : typeNode == 'asset'
                  ? Image.asset('assets/vectors/Vector (2).png')
                  : Image.asset('assets/vectors/Vector (1).png'),
          const SizedBox(width: 5),
          sensorType != null || sensorStatus == 'alert'
              ? Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff17192D),
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff17192D),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
          const SizedBox(width: 5),
          Visibility(
            visible: sensorType != null && sensorStatus != 'alert',
            child: Icon(
              sensorType == 'energy'
                  ? Icons.bolt
                  : sensorType == 'vibration'
                      ? FontAwesomeIcons.waveSquare
                      : Icons.ads_click,
              color: const Color(0xff52C41A),
              size: 15,
            ),
          ),
          Visibility(
            visible: sensorStatus == 'alert',
            child: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 10,
            ),
          ),
        ],
      ),
    );
  }
}
