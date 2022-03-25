import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:graphql_login/home/home_state.dart';
import 'package:graphql_login/home/home_state_notifier.dart';
import 'package:graphql_login/login/login_screen.dart';
import 'package:graphql_login/login/login_state_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<HomeStateNotifier, HomeState>(
        create: (context) => HomeStateNotifier(),
        builder: (context, child) {
          final homeData = context.select((HomeState state) => state.data);
          final loginStateNotifier = Provider.of<LoginStateNotifier>(context);

          if (homeData == null) {
            return const SizedBox();
          }

          return homeData.maybeWhen((data) {
            final chargeRent = data?.residentHome?.userContract?.chargeRent;

            print('Charge rent: $chargeRent');

            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Charge rent: $chargeRent'),
                    ElevatedButton(
                        onPressed: () async {
                          await loginStateNotifier.logout();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        },
                        child: const Text('Logout'))
                  ],
                ),
              ),
            );
          }, orElse: () {
            return const SizedBox();
          });
        });
  }
}
