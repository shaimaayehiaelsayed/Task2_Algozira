
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';
import 'package:task2/Layouts/Cubit/states.dart';
import 'package:task2/Modules/AddTasks/addtasks.dart';
import 'package:task2/Modules/All/all.dart';
import 'package:task2/Modules/Completed/completed.dart';
import 'package:task2/Modules/Favorites/favorites.dart';
import 'package:task2/Modules/Schedule/schedule.dart';
import 'package:task2/Modules/Uncompleted/uncompleted.dart';
import 'package:task2/Shared/component/Button.dart';
class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCuibt(),
        child: BlocConsumer<AppCuibt, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCuibt.get(context);
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar:PreferredSize(
                  preferredSize: const Size.fromHeight(120),
                  child: AppBar(
                    title: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Board',
                      ),
                    ),
                    actions:  [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScheduleScreen()),
                          );
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(10),
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.black26,
                          ),
                          const TabBar(
                            isScrollable: true,
                            // Required
                            unselectedLabelColor: Colors.black26,
                            // Other tabs color
                            labelPadding: EdgeInsets.symmetric(horizontal: 30),
                            // Space between tabs
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: Colors.black, width: 2),
                              // Indicator height
                              insets: EdgeInsets.symmetric(
                                  horizontal: 48), // Indicator width
                            ),
                            labelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: 'ALL',
                              ),
                              Tab(text: 'Completed'),
                              Tab(text: 'Uncompleted'),
                              Tab(text: 'favorites '),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body:Stack(
                  fit: StackFit.passthrough,
                 alignment: AlignmentDirectional.bottomCenter,

                 // clipBehavior:  Clip.antiAlias,
                  children:[
                  TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      AllScreen(),
                      CompletedScreen(),
                      UncompletedScreen(),
                      const FavoritesScreen()
                    ],
                  ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: MyButton(label: 'add', onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddScreen()),
                        );
                        cubit.ReturnList();
                      }),
                    ),
                   ]
                ),
              ),
            );
          },
        ));
  }
}