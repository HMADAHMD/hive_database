import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_tutorial/Notes.dart';
import 'package:hive_tutorial/boxes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_tutorial/functions.dart';

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

Fucntions myfunction = Fucntions();
final titleController = TextEditingController();
final descriptionController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ToDo",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: ValueListenableBuilder<Box<Notes>>(
          valueListenable: Boxes.getdata().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<Notes>();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data[index].title.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                InkWell(
                                    onTap: () {
                                      delete(data[index]);
                                    },
                                    child: Icon(Icons.delete)),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                    onTap: () {
                                      myfunction.update(
                                          data[index],
                                          data[index].title.toString(),
                                          data[index].description.toString(),
                                          context);
                                    },
                                    child: Icon(Icons.edit)),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data[index].description.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          myfunction.myDialogue(context);
          print('button pressed');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void delete(Notes notes) async {
  await notes.delete();
}
