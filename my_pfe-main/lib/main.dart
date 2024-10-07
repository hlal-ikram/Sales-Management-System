import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/binding/intialbinding.dart';
import 'package:my_pfe/core/serices.dart';
import 'package:my_pfe/routes.dart';
//import 'package:shared_preferences/shared_preferences.dart';

//late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBindings(),
      // home: const Login(),
      getPages: routes,
    );
  }
}
