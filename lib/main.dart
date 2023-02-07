import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/Notes.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hive Database",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: Hive.openBox('hammad'),
          builder: (context, snapshot) {
            return Column(
              children: [
                Card(
                    child: ListTile(
                  title: Text(snapshot.data!.get('age').toString()),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          snapshot.data!.put('age', 24);
                        });
                      },
                      icon: Icon(Icons.edit)),
                )),
                Card(
                    child: ListTile(
                        title: Text(snapshot.data!.get('gender').toString()))),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('hammad');
          var cube = await Hive.openBox('wishes');
          cube.put('duaa', {
            'kash': 'esa hojata',
            'kaash': 'esa bhi hojata',
            'kassh': 'ye bhi hojata',
          });
          box.put('age', 25);
          box.put('gender', 'male');
          print(box.get('age'));
          print(cube.get('duaa')['kaash']);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
