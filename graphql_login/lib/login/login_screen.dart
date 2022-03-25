import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:graphql_login/home/home_screen.dart';
import 'package:graphql_login/login/login_state.dart';
import 'package:graphql_login/login/login_state_notifier.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<LoginStateNotifier, LoginState>(
        create: (context) => LoginStateNotifier(
              onLoginSuccessful: () async => _onLoginSuccessful(context),
              onLoginFailed: () async => _onLoginFailed(context),
            ),
        builder: (context, child) {
          final stateNotifier = Provider.of<LoginStateNotifier>(context);
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                child: const Text('Test Login'),
                onPressed: () {
                  stateNotifier.login('DXR-3366999', 'hogehoge');
                },
              ),
            ),
          );
        });

    // final userNameController = TextditingController();
    // final passwordController = TextEditingController();

    //   return Scaffold(
    //     body: SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               Center(
    //                   child: Image.asset(
    //                 "assets/images/graphQl.png",
    //               )),
    //               const SizedBox(height: 20.0),
    //               TextField(
    //                 keyboardType: TextInputType.name,
    //                 autofocus: false,
    //                 controller: userNameController,
    //                 decoration: InputDecoration(
    //                   hintText: "User Name",
    //                   border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(8)),
    //                   hintStyle: const TextStyle(
    //                       fontSize: 13,
    //                       fontFamily: 'UTM',
    //                       fontWeight: FontWeight.w400,
    //                       color: Color.fromRGBO(51, 51, 51, 0.5)),
    //                 ),
    //               ),
    //               const SizedBox(height: 20.0),
    //               TextField(
    //                 keyboardType: TextInputType.text,
    //                 obscureText: true,
    //                 autofocus: false,
    //                 controller: passwordController,
    //                 decoration: InputDecoration(
    //                   hintText: "Password",
    //                   border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(8)),
    //                   hintStyle: const TextStyle(
    //                       fontSize: 13,
    //                       fontFamily: 'UTM',
    //                       fontWeight: FontWeight.w400,
    //                       color: Color.fromRGBO(51, 51, 51, 0.5)),
    //                 ),
    //               ),
    //               const SizedBox(height: 50.0),
    //               OutlinedButton(
    //                 style: OutlinedButton.styleFrom(
    //                     backgroundColor: Colors.white,
    //                     side: const BorderSide(
    //                         color: Color.fromRGBO(51, 51, 51, 1)),
    //                     shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(30))),
    //                     minimumSize: const Size(343, 53)),
    //                 onPressed: () async {},
    //                 child: const Text("Sign in",
    //                     style: TextStyle(
    //                         fontSize: 15,
    //                         fontFamily: 'UTM',
    //                         fontWeight: FontWeight.w400,
    //                         color: Color.fromRGBO(51, 51, 51, 1))),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }

  Future<void> _onLoginSuccessful(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Future<void> _onLoginFailed(BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Login failed!')));
  }
}
