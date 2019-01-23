import 'package:flutter/material.dart';

import 'dog_model.dart';
import 'dog_list.dart';
import 'add_dog_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 앱바의 구분을 위해 전체 테마가 dark 임을 명시하고
        // 앱 전체 아이콘 및 텍스트의 색을 white 로 정정함.
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.white,
        ),
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
          color: Colors.white,
        ),
        buttonColor: Colors.white,
      ),
      home: MyHomePage(title: 'Cute Doggos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Dog> initialDoggos = []
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddDogForm,
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[800],
              Colors.indigo[600],
              Colors.indigo[400],
              Colors.indigo[200],
            ],
          ),
        ),
        child: DogList(initialDoggos),
      ),
    );
  }

  Future _showAddDogForm() async {
    Dog newDog = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddDogForm();
        }
      ),
    );

    if (newDog != null) {
      initialDoggos.add(newDog);
    }
  }
}
