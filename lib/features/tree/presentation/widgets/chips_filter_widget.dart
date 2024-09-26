import 'package:flutter/material.dart';

class ChipFilterWidget extends StatelessWidget {
  const ChipFilterWidget({
    super.key,
    required this.isSelected,
    required this.textLabel,
    required this.icon,
    this.iconSize,
    this.onTap,
    this.filterClean,
  });

  final ValueNotifier<bool> isSelected;
  final String textLabel;
  final IconData icon;
  final double? iconSize;
  final Function()? onTap;
  final Function()? filterClean;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FilterChip(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        label: Text(textLabel),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: isSelected.value ? Colors.white : const Color(0xff77818C),
          fontSize: 14,
        ),
        avatar: Icon(
          icon,
          color: isSelected.value ? Colors.white : const Color(0xff77818C),
          size: iconSize ?? 18,
        ),
        side: BorderSide(
          width: .7,
          color: isSelected.value ? const Color(0xff2188FF) : Colors.grey.shade400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        selected: isSelected.value,
        showCheckmark: false,
        selectedColor: const Color(0xff2188FF),
        backgroundColor: Colors.white,
        onSelected: (bool selected) {
          if (isSelected.value == true && selected == false) {
            filterClean?.call();
          }

          isSelected.value = selected;
          onTap?.call();
        },
      ),
    );
  }
}
