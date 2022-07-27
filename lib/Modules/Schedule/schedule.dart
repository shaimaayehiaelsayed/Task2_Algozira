

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';
import 'package:task2/Layouts/Cubit/states.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:task2/Shared/component/task_tile.dart';

import '../../size_config.dart';


class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCuibt(),
      child: BlocConsumer<AppCuibt, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String Date = DateFormat.yMMMMd().format(DateTime.now());
          DateTime selectedDate = DateTime.now();
          AppCuibt cuibt = AppCuibt.get(context);

          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                title: const Text('Schedules'),
              ),
              body: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black26,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 6),
                  child: DatePicker(
                    DateTime.now(),
                    width: 80,
                    height: 100,
                    initialSelectedDate: DateTime.now(),
                    selectedTextColor: Colors.white,
                    selectionColor: Colors.green,
                    onDateChange: (newDate) {
                      selectedDate = newDate;
                    },
                    monthTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 20),
                    dateTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 20),
                    dayTextStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 20),

                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black26,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20,right: 10,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Today',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:Colors.black,
                          fontSize: 20
                      ),),
                      Text(
                        Date,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color:Colors.black,
                            fontSize: 20
                        ),
                      ),

                    ],
                  ),
                ),
                noTaskMsg(),
                showTask(),
              ]
              ));
        },
      ),
    );
  }

  Future <void>_onRefresf()async {
    AppCuibt().getDataBase(AppCuibt().database );
  }




  noTaskMsg(){
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 150),
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children:  [
                  SvgPicture.asset('assets/images/task.svg',color: const Color(
                      0xFF4e5ae8),height: 90,semanticsLabel: 'Task image',),
                    const SizedBox(height: 10,),
                    const Text(
                      'you do not have any tasks yet ! \n add new task to make your day productive',
                      style: TextStyle(
                       fontWeight  : FontWeight.w400,
                       color:Colors.black26,fontSize: 16),
                      textAlign: TextAlign.center,
                     ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  showTask() {
    return Expanded(
      child: GetX(
         builder: (DisposableInterface controller) => RefreshIndicator(
        onRefresh: _onRefresf,
        child: ListView.builder(
          scrollDirection: SizeConfig.orientation == Orientation.landscape
              ? Axis.horizontal
              : Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            var task =AppCuibt().AllTasks[index];
            var date = DateFormat().add_jm().parse(AppCuibt().startDate);
            var myTime = DateFormat('HH:mm ').format(date);
            /** NotifyHelper().scheduledNotification(
                int.parse(myTime.toString().split(':')[0]),
                int.parse(myTime.toString().split(':')[1]), task);**/
            return AnimationConfiguration.staggeredList(
              duration: const Duration(milliseconds: 1375),
              position: index,
              child: SlideAnimation(
                horizontalOffset: 300,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      showIcon();
                    },
                    child: TaskTile(AppCuibt().AllTasks),
                  ),
                ),
              ),
            );
          },
          itemCount:AppCuibt().AllTasks.length,
        ),


    )));
  }
showIcon(){
return IconButton(onPressed: (){}, icon: const Icon(
  Icons.radio_button_off,
));
}
}
