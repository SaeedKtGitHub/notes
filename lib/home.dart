import 'package:flutter/material.dart';
import 'package:notes/auth/crud.dart';
import 'package:notes/auth/login.dart';
import 'package:notes/components/card_note.dart';
import 'package:notes/constants.dart';
import 'package:notes/main.dart';
import 'package:notes/model/note.dart';
import 'package:notes/notes/add.dart';
import 'package:notes/notes/edit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud  {

  getNotes() async{
    var response=await postRequest(linkViewNote,{
      'id':sharedPreferences.getString('id'),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text('Home'),
       actions: [
         IconButton(onPressed: (){
           sharedPreferences.clear();
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
         }, icon: Icon(Icons.exit_to_app)),
       ],
       ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNote()));
        },
        child: Icon(Icons.add),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data['status']=='fail')
                      return const Center(child: Text('لا يوجد ملاحظات '),);
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return CardNote(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>EditNote(note:snapshot.data['data'][i] ,)));
                          },
                          note: Note.fromJson(snapshot.data['data'][i]),
                          onDelete: ()async{
                            var response=await postRequest(linkDeleteNote, {
                              "id":snapshot.data['data'][i]["note_id"].toString()
                            });
                            if(response['status']=='success'){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));

                            }
                          },
                        );
                      },
                    );

                  }
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: Text('Loading.....'),);
                  }
                  return Center(child: Text('Loading.....'),);


                })
            ,



          ],
        ),
      ),
    );
  }
}
