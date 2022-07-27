import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task2/Layouts/Cubit/cubit.dart';

import '../../size_config.dart';

class TaskTile extends StatelessWidget {

   TaskTile(this.task,{Key? key,}) : super(key: key);
  var task =AppCuibt().AllTasks;
  @override
  Widget build(BuildContext context) {

      String ST= AppCuibt().startDate;
      String ET= AppCuibt().endDate;
    return Container(
      padding: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(SizeConfig.orientation==Orientation.landscape?4:20)),
      width: SizeConfig.orientation==Orientation.landscape?SizeConfig.screenWidth/2:SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenWidth(12)),
      child: Container(
    padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(AppCuibt().selectedColor)
        ),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('jkll',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
                color:Colors.white,fontSize: 16),
          ),
        ),
              const SizedBox(height: 12,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_rounded,color: Colors.grey[200],),
                  const SizedBox(width: 12,),
                  Text('${ST} - ${ET}',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color:Colors.grey[100],fontSize: 13),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12,),

          ],
        ),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),

          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch(color){
      case 0:
        return const Color(0xFF4e5ae8);
      case 1:
        return const Color(0xFFff4667);
      case 2:
        return const Color(0xCFFF8746);
      default:
        return const Color(0xF5D9AB21);

    }
  }
}
