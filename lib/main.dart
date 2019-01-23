import 'package:flutter/material.dart';

import 'dog_model.dart';
import 'dog_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 앱 전체 텍스트, 아이콘의 색을 하얀색으로 설정
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.white,
        ),
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
}
