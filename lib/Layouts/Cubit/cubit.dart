
import 'package:intl/intl.dart';
import 'package:task2/Layouts/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task2/Modules/All/all.dart';
import 'package:task2/Modules/Completed/completed.dart';
import 'package:task2/Modules/Favorites/favorites.dart';
import 'package:task2/Modules/Uncompleted/uncompleted.dart';

class AppCuibt extends Cubit<AppStates> {
  AppCuibt() : super(AppInitialState());

  // to get instance
  static AppCuibt get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;
  List <Map>AllTasks = [];
  List<Map> Completetasks = [];
  List<Map> uncompletetasks = [];
  List<Map> favoritestasks = [];

  List<Widget> screens = [
    AllScreen(),
    CompletedScreen(),
    UncompletedScreen(),
    FavoritesScreen(),
  ];
  List<String> screenAppBar = [
    "All Tasks",
    "Completd Tasks",
    "uncompleted Tasks",
    "Favorites Tasks",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBar());
  }


  void createDataBase() {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (database, version) {
        print("Create dataBase");
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, '
                'title TEXT, date TEXT,'
                'startTime STRING,'
                'endTime STRING,'
                'color INTEGER,'
                'remind INTEGER,'
                'status TEXT)')
            .then((value) {
          print("Create table");
        }).catchError((error) {
          print(" catchError " + error.toString());
        });
      },
      onOpen: (database) {
        getDataBase(database);
        print("Open dataBase");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }

  Future insertToDatabase({
    required String title,
    required String date,
    required String starttime,
    required String endtime,
    required int Color,
    required int remind,

  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
          ' INSERT INTO tasks(title, date, startTime,endTime,color, remind,status) VALUES("$title", "$date", "$starttime","$endtime", "$Color","$remind","st")')
          .then((value) {
        print("$value INSERT successfully");
        print('$database');
        emit(AppInsertDataBase());
        getDataBase(database);
      }).catchError((error) {
        print(" catchError " + error.toString());
      });
      return null;
    });
  }


  void getDataBase(database) {
    AllTasks = [];
    Completetasks = [];
    uncompletetasks = [];
    favoritestasks = [];
    AllTasks.clear();
    Completetasks.clear();
    uncompletetasks.clear();
    favoritestasks.clear();

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'st') {
          AllTasks.add(element);
        } else if (element['status'] == 'completed') {
          Completetasks.add(element);
        }
        else if (element['status'] == 'Uncompleted') {
          uncompletetasks.add(element);
        } else {
          favoritestasks.add(element);
        }
      });
      emit(AppGetDataBase());
    });
  }

  void updateDataBase({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataBase(database);
      emit(AppUpdateDataBase());
    });
  }


  void deleteDataBase({
    required int id,
  }) async {
    database.rawUpdate(
      'DELETE  FROM  tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataBase(database);
      emit(AppDeleteDataBase());
    });
  }


  DateTime selectionDate = DateTime.now();

  void getDateFromUser(BuildContext context) async {
    DateTime? _pickedDate = await showDatePicker(
      initialDate: selectionDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030), context: context,);
    if (_pickedDate != null) {
      selectionDate = _pickedDate
      ;
    }
    else
      print('It\s null or  somthing is wrong ');
    emit(AppGetDateFromUser());
  }


  String startDate = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String endDate = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  void getTimeFromUser(
      {required bool isStartTime, required BuildContext context}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: isStartTime
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
            DateTime.now().add(const Duration(minutes: 15))));
    String formattedTime = _pickedTime!.format(context);
    if (isStartTime) {
      startDate = formattedTime;
    }
    else if (!isStartTime) {
      endDate = formattedTime;
    }
    else {
      print('Time Canceled  or  somthing is wrong ');
    }
    emit(APPGetTimeFromUser());
  }

  int selectedRemind = 5;

  void SetRemind({ int? newValue}) {
    selectedRemind = newValue!;
    emit(APPSetRemind());
  }

  String selectedRepeat = 'None';

  void SetRepeat({ String? newValue}) {
    selectedRepeat = newValue!;
    emit(APPSetRepeat());
  }


  int selectedColor = 0;

  void setColor({required int index}) {
    selectedColor = index;
    emit(AppSetColor());
  }

  String selctval = 'Complete';

  void setDrowdwonMenu({String? val}) {
    selctval = val !;
    emit(AppsetDrowdwonMenu());
  }

String? list;
  void ReturnList() {
    for (int i = 0; i <= AllTasks.length;i++){
      list=AllTasks[i]['title'];
      print('$list');
    }
    emit(AppReturnList());
  }


}
