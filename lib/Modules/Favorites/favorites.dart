import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';
import 'package:task2/Layouts/Cubit/states.dart';
import 'package:task2/Shared/component/defultTask.dart';

class FavoritesScreen  extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCuibt, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var taskes = AppCuibt
            .get(context)
            .favoritestasks;
        return ListView();
      },
    );
  }
}
