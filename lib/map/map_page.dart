import 'package:eTour_flutter/constants/etour_colors.dart';
import 'package:eTour_flutter/global/etour_app_bar.dart';
import 'package:eTour_flutter/repository/tours_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ETourColors.white,
        appBar: ETourAppBar(
          titleTranslationKey: 'btn_map',
          withSettingsButton: true,
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              minScale: 0.5,
              maxScale: 2,
              child: FutureBuilder(
                  future: (ToursRepository().getCurrenTourMapUrl()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.network(snapshot.data as String);
                    }
                    return Container();
                  }),
            ),
          ),
        ));
  }
}
