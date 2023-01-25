import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/login_controller.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/assets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  bool isSignIn = false;
  bool google = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthMethods>();
    var deviceSize = MediaQuery.of(context).size;
    final value = context.watch<LoginController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(90.0),
              height: deviceSize.height / 3,
              width: deviceSize.width,
              child: Image.asset(
                AppAssets.logo,
                height: 20,
                width: 20,
              ),
            ),
            Form(
              key: _userLoginFormKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 15, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 25),
                        ),
                      ),
                      InkWell(
                        child: Container(
                            width: deviceSize.width / 2,
                            height: deviceSize.height / 18,
                            margin: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppAssets.googleLogo),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ))),
                        onTap: () async {
                          await auth
                              .signInWithGoogle(context)
                              .onError((error, stackTrace) => {
                                    debugPrint(
                                        "error: $error and stacktrace: $stackTrace")
                                  })
                              .whenComplete(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _userIdController.dispose();
  }
}
