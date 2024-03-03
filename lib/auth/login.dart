import 'package:flutter/material.dart';
import 'package:notes/auth/crud.dart';
import 'package:notes/auth/sign_up.dart';
import 'package:notes/components/cust_text_for_sign.dart';
import 'package:notes/constants.dart';
import 'package:notes/home.dart';
import 'package:notes/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with Crud {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();


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

  login () async{
    if(formKey.currentState!.validate()){
      var response =await postRequest(
          linkLogin, {
            'email':email.text,
             'password':password.text,
      });
      if(response['status']=='success'){
        sharedPreferences.setString('id', response['data']['id'].toString());
        sharedPreferences.setString('username', response['data']['username']);
        sharedPreferences.setString('email', response['data']['email']);

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
      }else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Warning'),
              content: Text('Username or password is incorrect.'),
            );
          },
        );

      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  CustTextFormSign(valid: (val){
                    return validInput(val!, 3, 20);
                  },
                    hint: 'email',myControler: email,),
                  CustTextFormSign(valid: (val){
                    return validInput(val!, 3, 20);
                  }, hint:'password',myControler: password,),
                   MaterialButton(
                   color: Colors.blue,
                   textColor: Colors.white,
                   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 70),
                   onPressed: ()async{
                     await login();
                   },
                    child: Text('Login'),

                 ),
                  Container(height: 10,),

                  InkWell(child: Text('Sign up ->')
                  ,onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>Signup()));
                         }),
                ],

            )),
          ],
        ),
      )
    );
  }
}
