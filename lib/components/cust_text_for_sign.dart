import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint;
  final TextEditingController myControler;
  final String? Function(String?) valid;



  const CustTextFormSign({super.key,required this. myControler,required this.hint,required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator:valid ,
        controller: myControler,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
  validInput(String val,int min,int max){
    if(val.isEmpty){
      return "$messageInputEmpty";
    }
    if(val.length<min){
      return "$messageInputMin";
    }
    if(val.length>max){
      return "$messageInputMax";
    }

  }
}
