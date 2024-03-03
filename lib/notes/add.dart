import 'package:flutter/material.dart';
import 'package:notes/auth/crud.dart';
import 'package:notes/components/cust_text_for_sign.dart';
import 'package:notes/constants.dart';
import 'package:notes/home.dart';
import 'package:notes/main.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Crud {

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();

  bool isLoading=false;

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

  addNotes() async{
    isLoading=true;
    setState(() {

    });
    if(formKey.currentState!.validate()){
      var response=await postRequest(linkAddNote, {
        'title':titleController.text,
        'content':contentController.text,
        'id':sharedPreferences.getString('id')
      });

      if(response['status']=='sucess'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      }

    }
    isLoading=false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add note'),
      ),
      body:isLoading==true? Center(
        child: CircularProgressIndicator(),
      ) : Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustTextFormSign(myControler:titleController,
                  hint: 'title',
                  valid: (val){
                return validInput(val!, 1, 40);
                  }),
              CustTextFormSign(myControler:contentController,
                  hint: 'content',
                  valid: (val){
                    return validInput(val!, 10, 255);
                  }),
              Container(height: 20,),
              MaterialButton(onPressed: ()async{
                await addNotes();
              },
                child: Text('Add'),
                textColor: Colors.white,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
