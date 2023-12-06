import 'package:flutter/material.dart';
import 'package:loop/components/app_landing/app_landing.dart';
import 'package:loop/model/count.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Count()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Loop',
            home: AppLanding(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> _initializeData(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Provider.of<Count>(context, listen: false)
        .loadCountFromLocalStorage();
  }
}
