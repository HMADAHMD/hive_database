import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/Notes.dart';
import 'package:hive_tutorial/boxes.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesAdapter());
  await Hive.openBox<Notes>('notes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final titleController = TextEditingController();
final descriptionController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hive Database",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          myDialogue(context);
          print('button pressed');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
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
                decoration: InputDecoration(
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
                  data.save();
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
