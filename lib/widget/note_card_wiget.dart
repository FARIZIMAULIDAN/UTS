import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/note.dart';


class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({super.key, required this.note, required this.index});
  final Note note;
  final int index;

@override
Widget build(BuildContext context) {

  return Card(
    color: Colors.yellow,
    child: Container(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4,),
          Row(
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.description,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


}