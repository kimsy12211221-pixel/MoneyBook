import 'package:flutter/material.dart';

import 'app.dart';

void bootstrap(Widget app) {
  runApp(app);
}

class PersonalSpendingBootstrap extends StatelessWidget {
  const PersonalSpendingBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return const PersonalSpendingApp();
  }
}
