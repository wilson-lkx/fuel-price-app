import 'package:flutter/material.dart';
import 'package:fuel_app/ui/views/fuel_price_display.dart';
import 'package:fuel_app/ui/views/home_user.dart';
import 'package:fuel_app/ui/views/login.dart';
import 'package:provider/provider.dart';

import 'model/home.model.dart';

void main() {
  runApp(
      MyApp()
  );
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => HomeModel(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: LoginView(),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeUserView(username: 'Test'),
    );
  }
}

