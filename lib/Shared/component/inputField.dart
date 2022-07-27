
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key, required this.title,required this.desc, this.controller, this.widget}) : super(key: key);
  final String title;
  final String desc;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Container(
              padding: const EdgeInsets.only(left: 14),
              margin: const EdgeInsets.only(top: 8),
              height: 45,
              width: double.infinity,
              decoration:  BoxDecoration(
                color:Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),

              ),
              child:Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      autofocus: false,

                      readOnly: widget !=null?true:false,
                      decoration: InputDecoration(
                        hintText: desc,

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 0
                          ),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),

                      ),

                    ),
                  ),
                  widget??Container()
                ],
              ),),


          ],
        ),
      ),
    );
  }
}
