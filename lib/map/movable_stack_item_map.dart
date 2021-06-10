import 'package:eTour_flutter/app_localizations.dart';
import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/constants/etour_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovableStackItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovableStackItemState();
  }
}

class _MovableStackItemState extends State<MovableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  double width = 150;
  double height = 150;
  Color color = Color.fromRGBO(255, 255, 255, 0.5);
  bool isFullScreen = false;
  bool dragged = true;
  @override
  void initState() {
    super.initState();
  }

  void makeFullScreen() {
    setState(() {
      dragged = false;
      xPosition = 0;
      yPosition = 0;
      if (isFullScreen) {
        width = 150;
        height = 150;
        color = Color.fromRGBO(255, 255, 255, 0.5);
      } else {
        width = Get.size.width;
        height = Get.size.height * 2 / 3;
        color = Color.fromRGBO(255, 255, 255, 1);
      }
      isFullScreen = !isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: dragged ? 0 : 300),
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            dragged = true;
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: InkWell(
          onTap: () => makeFullScreen(),
          child: AnimatedContainer(
            width: width,
            height: height,
            duration: Duration(milliseconds: 300),
            child: Stack(
              children: [
                Center(
                    child: Text(
                        AppLocalizations.of(context)!.translate("btn_map")!,
                        style: ETourTextStyles.semiboldItalicTitleWithColor(
                            ETourColors.black))),
                Image.network(
                    "https://st.depositphotos.com/1172692/1379/v/950/depositphotos_13793704-stock-illustration-abstract-city-map-vector-illustration.jpg",
                    color: color,
                    colorBlendMode: BlendMode.modulate)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
