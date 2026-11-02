import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(const ProviderScope(child: PersonalSpendingBootstrap()));
}
