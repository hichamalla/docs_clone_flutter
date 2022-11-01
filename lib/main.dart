// ignore_for_file: avoid_print

import 'package:docs_clone_flutter/models/error_models.dart';
import 'package:docs_clone_flutter/repository/auth_repository.dart';
import 'package:docs_clone_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  ErrorModel? dataModel;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    // print('getuserdata');
    dataModel = await ref.read(authRepositoryProvider).getUserData();
    if (dataModel != null && dataModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => dataModel!.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: user == null ? const LoginScreen() : const HomeScreen(),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        final user = ref.watch(userProvider);
        if (user != null && user.token.isNotEmpty) {
                    return homeeRouter;
        } 
        // else {
          return logginRouter;
        // }
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
