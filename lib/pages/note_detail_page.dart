import 'package:flutter/material.dart';
import 'package:flutter_application_4/database/note_database.dart';
import 'package:flutter_application_4/models/note.dart';
import 'package:flutter_application_4/pages/add_edit_note_page.dart';
import 'package:intl/intl.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key, required this.id});
  final int id;
  
  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note _note;
  var _isLoading = false;

  Future<void> _refreshNotes() async{
    setState(() {
      _isLoading = true;
    });
    _note = await NoteDatabase.instance.getNoteById(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshNotes();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.orange,
      title: const Text('Detail Menu'),
    ),
    body: _isLoading 
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/food2.jpg'), // Ganti dengan path gambar yang sesuai
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24), // Spacer
                Text(
                  _note.title,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  DateFormat.yMMMd().format(_note.createTime),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  _note.description,
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.yellow,
                    ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24), // Spacer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _editButton(),
                    SizedBox(width: 16),
                    _deleteButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
  );
}




  Widget _editButton(){
    return IconButton(onPressed: ()async{
      if(_isLoading) return;
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) => AddEditNotePage(
        note: _note,
      )));
      _refreshNotes();
    }, icon:const Icon(Icons.edit_outlined,color: Colors.yellow,));
  }
  Widget _deleteButton(){
    return IconButton(onPressed: () async{
      if(_isLoading) return;
      await NoteDatabase.instance.deleteNoteById(widget.id);
      Navigator.pop(context);
    }, icon:const Icon(Icons.delete,color: Colors.orange,));
  }
}