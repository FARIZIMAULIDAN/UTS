import 'package:flutter/material.dart';
import 'package:flutter_application_4/database/note_database.dart';
import 'package:flutter_application_4/models/note.dart';
import 'package:flutter_application_4/widget/note_form_widget.dart';
class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.note});
  final Note? note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool _isImportant;
  late int _number;
  late String _title;
  late String _description;
  final _formkey = GlobalKey<FormState>();
  var _isUpdateForm = false;

  @override
  void initState(){
    super.initState();
    _isImportant = widget.note?.isImportant ?? false;
    _number = widget.note?.number ?? 0;
    _title = widget.note?.title ?? '';
    _description = widget.note?.description ?? '';
    _isUpdateForm = widget.note != null;
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(_isUpdateForm ? 'Edit' :'add'),
        actions: [
          _buildButtonSave(),
        ], 
      ),
      body: 
      Form(
        key: _formkey,
        child: NoteFormWidget(
          isImportant: _isImportant, 
          number: _number, 
          title: _title, 
          description: _description, 
          onChangeIsImportant: (value) {
            setState(() {
              _isImportant = value;
            });
          }, 
          onChangeNumber: (value) {
            setState(() {
              _number = value;
            });
          }, 
          onChangeTitle: (value) {
            _title = value;
          }, 
          onChangeDescription: (value) {
            _description = value;
          },
          ), 
      ),
    );
  }
  Widget _buildButtonSave(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(onPressed: () async {
        final isValid = _formkey.currentState!.validate();
        if(isValid){
          if(_isUpdateForm){
            await _updateNote();
          }else{
            await _addNote();
          }
          Navigator.pop(context);
        }
      }, child: const Text('save'),),
      );
  }
  Future<void> _addNote() async{
    final note = Note(
      isImportant: _isImportant, 
      number: _number, 
      title: _title, 
      description: _description, 
      createTime: DateTime.now());
      await NoteDatabase.instance.create(note);
  }
  Future<void> _updateNote() async{
    final updateNote = Note(
      id: widget.note?.id,
      isImportant: _isImportant, 
      number: _number, 
      title: _title, 
      description: _description, 
      createTime: DateTime.now());
      await NoteDatabase.instance.UpdateNote(updateNote);
  }
}