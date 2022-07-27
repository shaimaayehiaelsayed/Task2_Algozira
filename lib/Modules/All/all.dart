import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';
import 'package:task2/Layouts/Cubit/states.dart';
import 'package:task2/Shared/component/Button.dart';
import 'package:task2/Shared/component/defultTask.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCuibt, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var taskes = AppCuibt.get(context).AllTasks;
        return ListView.separated(
            itemBuilder: (context ,index) => DefultTask(context,taskes[index]),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],

            ),
            // a proplem with get length tasks.length
            itemCount:taskes.length);
      },

    );
  }
}