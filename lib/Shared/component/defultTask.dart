import 'package:flutter/material.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';



// ignore: non_constant_identifier_names
Widget DefultTask(context,Map task){
  return Dismissible(
      key: Key(task['id'].toString()),
     child: Container(
    color: Colors.red,
    child: Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(
            Icons.check_box_outline_blank,color: Colors.black,
             )),
        const SizedBox(width: 10,),
        Text ('${task['title']}'),
        DropdownButton(
          items: ['complete','uncomplete','Favirote']
              .map(
                (value) => DropdownMenuItem(
                value: value, child: Text('$value')),
                 )
              .toList(),
          onChanged: (String ? newValue) {
            ///cuibt.setDrowdwonMenu(val:newValue);
          },
          icon:
          const Icon(Icons.keyboard_arrow_down_outlined),
          iconSize: 32,
          dropdownColor: Colors.blueGrey,
          elevation: 4,
          underline: Container(
            height: 0,
          ),
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 16),
        ),
      ],
    ),
  ),
    onDismissed:(direction) {
      AppCuibt.get(context).deleteDataBase(id: task['id']);
    }
  );
  }