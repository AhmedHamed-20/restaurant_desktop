import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_windows/layout/admin_layout/admin_layout_screen.dart';
import 'package:restaurant_windows/models/bloc/cubit/admin_cubit.dart';
import 'package:restaurant_windows/models/bloc/cubit/login_cubit.dart';
import 'package:restaurant_windows/models/bloc/states/admin_state.dart';
import 'package:restaurant_windows/models/cach/chach.dart';
import 'package:restaurant_windows/models/dio/end_points.dart';
import 'package:restaurant_windows/screens/login_screen.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachFunc.init();
  String token = CachFunc.getData('token');
  if (await CachFunc.getBoolDate(key: 'isDark') == null) {
    EndPoints.isDark = false;
  } else {
    EndPoints.isDark = await CachFunc.getBoolDate(key: 'isDark');
  }
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(900, 700));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  String token;
  MyApp(this.token);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AdminCubit()..getalldataifSignedin(token),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: token == null
                ? LoginScreen()
                :

                //   print(constraints.minWidth.toInt());
                AdminLayout(),
          );
        },
      ),
    );
  }
}
