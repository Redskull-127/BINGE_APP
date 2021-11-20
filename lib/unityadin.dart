// // Interstitial_Android
// // ignore_for_file: missing_return

// import 'package:flutter/material.dart';
// import 'package:unity_ads_plugin/unity_ads.dart';

// class Unityin extends StatefulWidget {
//   @override
//   _UnityinState createState() => _UnityinState();
// }

// class _UnityinState extends State<Unityin> {
//   bool isLoaded = true;
//   @override
//   void initState() {
//     super.initState();

//     UnityAds.init(
//       gameId: "4443999",
//       testMode: true,
//     );
//   }

//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     UnityAds.isReady(placementId: "Interstitial_Android").then((value) {
//       if (value == true) {
//         // isLoaded = true;
//         UnityAds.showVideoAd(
//             placementId: "Interstitial_Android",
//             listener: (state, args) {
//               if (state == UnityAdState.complete) {
//                 print("VIDEO IS COMPLETED");
//               } else if (state == UnityAdState.skipped) {
//                 print("VIDEO IS SKIPPED");
//               }
//             });
//       } else {
//         print("AD IS NOT READY");
//       }
//     });
//   }

