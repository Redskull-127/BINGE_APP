import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = true;
  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: "4443999",
      testMode: false,
    );
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    UnityAds.isReady(placementId: "BINGE").then((value) {
      if (value == true) {
        // isLoaded = true;
        UnityAds.showVideoAd(
            placementId: "BINGE",
            listener: (state, args) {
              if (state == UnityAdState.complete) {
                print("VIDEO IS COMPLETED");
              } else if (state == UnityAdState.skipped) {
                print("VIDEO IS SKIPPED");
              }
            });
      } else {
        print("AD IS NOT READY");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        children: [
          Spacer(),
          isLoaded
              ? Container(
                  height: 50,
                  child: UnityBannerAd(
                    placementId: "BINGE",
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
