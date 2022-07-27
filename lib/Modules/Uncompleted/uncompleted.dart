import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';
import 'package:task2/Layouts/Cubit/states.dart';
import 'package:task2/Shared/component/defultTask.dart';

class UncompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCuibt, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var taskes = AppCuibt
            .get(context)
            .uncompletetasks;
        return ListView();
      },

    );
  }
}
