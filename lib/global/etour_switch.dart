import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:flutter/cupertino.dart';

class ETourSwitch extends StatelessWidget {
  final bool? value;
  final Function? onChanged;

  const ETourSwitch({Key? key, this.value, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        activeColor: ETourColors.orange, value: value!, onChanged: onChanged as void Function(bool)?);
  }
}
