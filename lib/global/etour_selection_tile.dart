import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:flutter/material.dart';

class ETourSelectionTile extends StatelessWidget {
  final Function onTap;
  final bool isSelected;
  final String? title;

  const ETourSelectionTile(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      onTap: onTap as void Function()?,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
                width: 2,
                color: isSelected ? ETourColors.orange : Colors.transparent)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title!,
                  style: ETourTextStyles.regularRalewayBodyWithColor(
                    ETourColors.black,
                  )),
              if (isSelected)
                Icon(
                  Icons.check,
                  color: ETourColors.orange,
                )
            ],
          ),
        ),
      ),
    );
  }
}
