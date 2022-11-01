// ignore_for_file: avoid_print

import 'package:docs_clone_flutter/colors.dart';
import 'package:docs_clone_flutter/repository/auth_repository.dart';
import 'package:docs_clone_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void singInWithGoogle(WidgetRef ref, ctx) async {
    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    print("errorModel.data ${errorModel.data}");
    print("errorModel.error ${errorModel.error}");
    final sMessanger = ScaffoldMessenger.of(ctx);
    final navigator = Routemaster.of(ctx);
    print('try logiin');
    if (errorModel.error == null) {
      print('logiin');
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator
          .push('/');
    } else {
      print('errror in logiin');
      sMessanger
          .showSnackBar(SnackBar(content: Text(errorModel.error.toString())));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => singInWithGoogle(ref, context),
          icon: Image.asset(
            "assets/images/g-logo-2.png",
            height: 20,
          ),
          label: const Text(
            "Login With Google",
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
