import 'package:flutter/material.dart';
import 'package:notes/auth/crud.dart';
import 'package:notes/auth/login.dart';
import 'package:notes/components/cust_text_for_sign.dart';
import 'package:notes/constants.dart';
import 'package:notes/home.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with Crud {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController username=TextEditingController();

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

  signUp () async{

    if(formKey.currentState!.validate()){
    isLoading=true;
    setState(() {

    });
    //await Future.delayed(Duration(seconds: 2));//to test CircularprogressIndicator
    var response=await postRequest(linkSignUp, {
      'username':username.text,
      'email':email.text,
      'password':password.text,
    });
    isLoading=false;
    setState(() {

    });

    if(response['status']=="success"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
    }else{
      print('Signup failed');
    }
    }
  }

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:isLoading?Center(
          child: CircularProgressIndicator(),
        ): Container(
          padding: EdgeInsets.all(18),
          child: ListView(
            children: [
              Form(
                  key:formKey
                  ,child:Column(
                children: [
                  SizedBox(height: 33,),
                  Image.asset('lib/images/login.png',width: 200,height: 200,),
                  SizedBox(height: 23,),
                  CustTextFormSign(
                    valid: (val){
                    return validInput(val!, 3, 20);
                  },
                    hint: 'username',myControler: username,),
                  CustTextFormSign(  valid: (val){
                    return validInput(val!, 5, 40);
                  },hint: 'email',myControler: email,),
                  CustTextFormSign(  valid: (val){
                    return validInput(val!, 3, 10);
                  },hint:'password',myControler: password,),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 70),
                    onPressed: ()async{
                     await signUp();
                    },
                    child: Text('Signup'),

                  ),
                  Container(height: 10,),

                  InkWell(child: Text('Login')
                      ,onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context)=>Login()));
                      }),
                ],

              )),
            ],
          ),
        )
    );
  }


}
