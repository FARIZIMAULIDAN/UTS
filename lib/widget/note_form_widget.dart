import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
      {super.key,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.onChangeIsImportant,
      required this.onChangeNumber,
      required this.onChangeTitle,
      required this.onChangeDescription,
      });
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangeIsImportant;
  final ValueChanged<int> onChangeNumber;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDescription;


@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTitleField(),
          const SizedBox(height: 8,),
          Divider(
            color: Colors.black,
          ),
          _buildDescriptionField(),
          const SizedBox(height: 8,),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}



  Widget _buildTitleField(){
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Nama Makanan',
        hintStyle: TextStyle(color: Colors.black),
      ),
      onChanged: onChangeTitle,
      validator: (title){
        return title != null && title.isEmpty ? 'The title cannot be empty'
          :null;
      },
    );
  }
  Widget _buildDescriptionField(){
    return TextFormField(
      maxLines: 1,
      initialValue: description,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Description',
        hintStyle: TextStyle(color: Colors.black),
      ),
      onChanged: onChangeDescription,
      validator: (desc){
        return desc != null && desc.isEmpty ? 'The desc cannot be empty'
          :null;
      },
    );
  }
}
