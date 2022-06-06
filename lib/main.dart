import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'data.dart';
import 'monitoring/bloc_monitor.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      RepositoryProvider(
        create: (context) => GameStatsRepository(GameStatsSharedPrefProvider()),
        child: const PlingoApp(),
      ),
    ),
    blocObserver: BlocMonitor(),
  );
}
