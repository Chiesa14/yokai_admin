import 'package:yokai_admin/Widgets/deleteDialog.dart';
import 'package:yokai_admin/api/local_storage.dart';
import 'package:yokai_admin/authentication/login.dart';
// import 'package:yokai_admin/authentication/login.dart';
import 'package:yokai_admin/globalVariable.dart';
import 'package:yokai_admin/home/home_page.dart';
import 'package:yokai_admin/utils/colors.dart';
import 'package:yokai_admin/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
String appName = "YOKAIZEN Admin Panel";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    checkDebugMode();
    bool isLoggedIn = prefs!.getBool(LocalStorage.isLogin) ?? false;
    print("isLoggedIn :: $isLoggedIn");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: colorCustom,
        fontFamily: "OpenSans",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      navigatorKey: navigatorKey,
      home: isLoggedIn ? const HomePage(selectedTab: 0) : const LoginPage(),
      onGenerateRoute: (settings) {
        if (settings.name == Routes.dashboard) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(selectedTab: 0),
          );
        } else if (settings.name == Routes.users) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(selectedTab: 1),
          );
        } else if (settings.name == Routes.stories) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(selectedTab: 2),
          );
        } else if (settings.name == Routes.chapters) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(selectedTab: 3),
          );
        } else if (settings.name == Routes.activities) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(selectedTab: 4),
          );
        } else if (settings.name == Routes.characters) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomePage(selectedTab: 5),
          );
        }  else if (settings.name == Routes.logout) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => CustomDeleteWidget(
              title: 'Log Out',
              message: 'Are you sure you want to logout?',
              onCancelPressed: () {
                navigatorKey.currentState!.pop();
              },
              onConfirmPressed: () {
                prefs!.setBool(LocalStorage.isLogin, false);
                print(
                    "logout popup:: ${prefs!.getBool(LocalStorage.isLogin) ?? false}");

                nextPage(navigatorKey.currentContext!, LoginPage());
              },
            ),
          );
        }
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const LoginPage(),
        );
      },
    );
  }
}
