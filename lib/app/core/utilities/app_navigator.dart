import 'package:flutter/material.dart';

extension NavigateOnKey on GlobalKey<NavigatorState>? {
  Future<bool> pop([dynamic result]) async {
    return await this?.currentState?.maybePop(result) ?? false;
  }

  void popUntil() {
    this?.currentState?.popUntil(
          ModalRoute.withName(Navigator.defaultRouteName),
        );
  }

  Future<dynamic> pushNamed(String router, {Object? args}) async {
    return this?.currentState?.pushNamed(router, arguments: args);
  }

  Future<dynamic> push(Widget page, {Object? args}) async {
    return this?.currentState?.push(
      MaterialPageRoute(
        builder: (_) {
          return page;
        },
      ),
    );
  }
}
