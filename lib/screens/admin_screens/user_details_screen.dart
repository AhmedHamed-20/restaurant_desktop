import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_windows/models/bloc/cubit/admin_cubit.dart';
import 'package:restaurant_windows/models/bloc/states/admin_state.dart';

class UserDetailesScreen extends StatelessWidget {
  const UserDetailesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
        builder: (context, state) {
          return Scaffold();
        },
        listener: (context, state) {});
  }
}
