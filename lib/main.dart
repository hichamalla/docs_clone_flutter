// ignore_for_file: avoid_print

import 'package:docs_clone_flutter/models/error_models.dart';
import 'package:docs_clone_flutter/repository/auth_repository.dart';
import 'package:docs_clone_flutter/screens/home_screen.dart';
import 'package:docs_clone_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final user = ref.watch(userProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      home: user == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
