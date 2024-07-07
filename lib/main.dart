import 'dart:async';

import 'package:connect_canteen/app1/modules/common/splash%20screen/splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBMiAkgEUAgyHyGiIH4V73kdizOAVOeif4",
            authDomain: "connect-cant.firebaseapp.com",
            projectId: "connect-cant",
            storageBucket: "connect-cant.appspot.com",
            messagingSenderId: "999730318693",
            appId: "1:999730318693:web:73dacd3134b9697393a58c"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    // Check initial connectivity status
    initConnectivity().then(_updateConnectionStatus);

    // Subscribe to connectivity changes
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<ConnectivityResult> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return ConnectivityResult.none;
    }
    return result;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        // Use Builder to get context inside the builder
        return Builder(
          builder: (context) {
            return GetMaterialApp(
              title: 'Connect Canteen',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // Check connectivity status to determine which screen to show
              home: MediaQuery.of(context).size.width >= 600
                  ? DesktopScreen()
                  : _connectionStatus == ConnectivityResult.none
                      ? OfflineScreen()
                      : SplashScreen1(),
            );
          },
        );
      },
    );
  }
}

class DesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your desktop screen UI here
    return Scaffold(
      body: Center(
        child: Text(
          'Sorry, this time we are not available on the desktop version. You can browse from mobile.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class OfflineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 79, 117),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off,
              size: 72,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'No Internet Connection',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please check your connection and try again',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  'Retry',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
