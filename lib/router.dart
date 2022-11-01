import 'package:docs_clone_flutter/screens/document_screen.dart';
import 'package:docs_clone_flutter/screens/home_screen.dart';
import 'package:docs_clone_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final logginRouter = RouteMap(routes: {
  '/': ((route) {
    return const MaterialPage(child: LoginScreen());
  })
});

final homeeRouter = RouteMap(routes: {
  '/': ((route) => const MaterialPage(
        child: HomeScreen(),
      )),
  '/document/:id': ((route) => MaterialPage(
        child: DocumentScreen(docID: route.pathParameters['id'] ?? ''),
      ))
});
