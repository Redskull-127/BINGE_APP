import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movie_app_flutter/utils/text.dart';

// adUnitId: "ca-app-pub-3940256099942544/5224354917",

class AdPage extends StatefulWidget {
  const AdPage({Key key}) : super(key: key);
  @override
  AdPageState createState() => AdPageState();
}

class AdPageState extends State<AdPage> {
  BannerAd bannerAd;
  bool isLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-5854213705609546/6432866274",
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
        print("Baneer Ad Loaded");
      }, onAdFailedToLoad: (ad, error) {
        print(error);
        ad.dispose();
      }),
      request: AdRequest(),
    );
    bannerAd.load();
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
                  child: AdWidget(ad: bannerAd),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
