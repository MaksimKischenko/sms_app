import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:sms_app/bloc/sms_parser/sms_parser_bloc.dart';
import 'package:sms_app/screens/screens.dart';

import 'bloc/bloc_observer.dart';
import 'bloc/sms_generator/sms_generator_bloc.dart';


void main() {

  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
      providers: [
        BlocProvider<SmsGeneratorBloc>(
          create: (context) => SmsGeneratorBloc()..add(SmsGeneratorInitial())
        ),
         BlocProvider<SmsParserBloc>(
          create: (context) => SmsParserBloc()
        ),
      ], child: const SmsApp())),
    blocObserver: SimpleBlocObserver(),
    eventTransformer: sequential<dynamic>()
  );
}

class SmsApp extends StatelessWidget {
  const SmsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SetParametersScreen()//InfoScreen()
    );
  }
}

