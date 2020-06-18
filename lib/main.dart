import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flare/constants.dart';
import 'package:test_flare/home_page.dart';

const _filesToWarmup = [
  Constants.FLARE_BACKGROUND,
  Constants.FLARE_CHANGE_THEME_BUTTON,
];

Future<void> warmupFlare() async {
  for (final filename in _filesToWarmup) {
    final AssetProvider assetProvider =
        AssetFlare(bundle: rootBundle, name: filename);
    await cachedActor(assetProvider);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlareCache.doesPrune = false;
  warmupFlare().then((value) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Background Flare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
