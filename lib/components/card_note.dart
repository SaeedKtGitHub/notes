import 'package:flutter/material.dart';
import 'package:notes/model/note.dart';

class CardNote extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onDelete;
  final Note note;
  const CardNote({
    super.key,required this.onTap,
    required this.note
   ,required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1
                ,child: Image.asset(
              'lib/images/note.jpg',width: 100,height: 100,
              fit: BoxFit.fill,
            )
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text('${note.noteTitle}'),
                  subtitle: Text('${note.noteContent}'),
                  trailing: IconButton(onPressed:onDelete,
                      icon: Icon(Icons.delete)),
                ))
          ],
        ),
      ),
    );
  }
}
