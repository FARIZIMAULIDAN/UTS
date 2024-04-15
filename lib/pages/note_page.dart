import 'package:flutter/material.dart';
import 'package:flutter_application_4/database/note_database.dart';
import 'package:flutter_application_4/models/note.dart';
import 'package:flutter_application_4/pages/add_edit_note_page.dart';
import 'package:flutter_application_4/pages/note_detail_page.dart';
import 'package:flutter_application_4/widget/note_card_wiget.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> _notes;
  var _isLoading = false;

  Future<void> _refreshNotes() async {
    setState(() {
      _isLoading = true;
    });
    _notes = await NoteDatabase.instance.getAllNotes();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Menu Makanan'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/food.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _notes.isEmpty
                ? const Center(
                    child: Text(
                      'Menu Makanan Kosong',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailPage(id: note.id!),
                            ),
                          );
                          _refreshNotes();
                        },
                        child: NoteCardWidget(note: note, index: index),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.food_bank_outlined),
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditNotePage()));
          _refreshNotes();
        },
      ),
    );
  }
}
