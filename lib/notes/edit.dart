import 'package:flutter/material.dart';
import 'package:notes/auth/crud.dart';
import 'package:notes/components/cust_text_for_sign.dart';
import 'package:notes/constants.dart';
import 'package:notes/home.dart';
import 'package:notes/main.dart';

class EditNote extends StatefulWidget {
  final  note;
  const EditNote({Key? key,this.note}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with Crud {

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

  editNotes() async{
    isLoading=true;
    setState(() {

    });
    if(formKey.currentState!.validate()){
      var response=await postRequest(linkEditNote, {
        'title':titleController.text,
        'content':contentController.text,
        'id':widget.note['note_id'].toString()});

      if(response['status']=='success'){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
      }

    }
    isLoading=false;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    titleController.text=widget.note['note_title'];
    contentController.text=widget.note['note_content'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit note'),
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
                await editNotes();

              },
                child: Text('Save'),//or edit
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
