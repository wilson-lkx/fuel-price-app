import 'package:flutter/material.dart';
import 'package:fuel_app/model/home.model.dart';
import 'package:fuel_app/model/role.dart';
import 'package:fuel_app/model/user.dart';
import 'package:fuel_app/rest_client/role_client.dart';
import 'package:fuel_app/rest_client/user_client.dart';
import 'package:fuel_app/ui/theme/global.dart';
import 'package:fuel_app/ui/views/home_admin.dart';
import 'package:fuel_app/ui/views/home_user.dart';
import 'package:fuel_app/ui/widgets/button_widget.dart';
import 'package:fuel_app/ui/widgets/textfield_widget.dart';
import 'package:fuel_app/ui/widgets/wave_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final model = Provider.of<HomeModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Global.color4,
                      Global.color5,
                    ]
                )
            ),
            height: size.height - 200,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Global.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Fuel Price App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextFieldWidget(
                  hintText: 'Email',
                  obscureText: false,
                  prefixIconData: Icons.mail_outline,
                  suffixIconData: model.isValid ? Icons.check : null,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFieldWidget(
                  hintText: 'Password',
                  obscureText: model.isVisible ? false : true,
                  prefixIconData: Icons.lock_outline,
                  suffixIconData: model.isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ButtonWidget(
                  title: 'Login',
                  hasBorder: false,
                  onTapFunction: () async {
                    // bool isValidUser = model.isValidUser(email, password);
                    User user = await login(email, password);
                    if(user.id != 0) {
                      Role role = await getRoleByUserId(user.id);

                      if(role.name == 'ADMIN') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeAdminView()
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeUserView(username: 'Hello')
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Wrong Email or Password!'))
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                ButtonWidget(
                  title: 'Sign Up',
                  hasBorder: true,
                  onTapFunction: ()  {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
