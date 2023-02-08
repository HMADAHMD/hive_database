import 'package:flutter/material.dart';
import 'package:hive_tutorial/Notes.dart';
import 'package:hive_tutorial/boxes.dart';

import 'main.dart';

class Fucntions {
  Future update(Notes notes, String title, String description,
      BuildContext context) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Put it in"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      //fillColor: Colors.green[100],
                      border: UnderlineInputBorder(),
                      hintText: 'Edit Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      fillColor: Colors.green[100],
                      border: UnderlineInputBorder(),
                      hintText: 'Edit Description'),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () async {
                    notes.title = titleController.text.toString();
                    notes.description = descriptionController.text.toString();
                    notes.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }

  Future myDialogue(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Put it in"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      //fillColor: Colors.green[100],
                      border: UnderlineInputBorder(),
                      hintText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      fillColor: Colors.green[100],
                      border: UnderlineInputBorder(),
                      hintText: 'Description'),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    final data = Notes(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getdata();
                    box.add(data);
                    //data.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        });
  }
}
