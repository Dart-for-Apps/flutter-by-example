import 'package:flutter/material.dart';
import 'dog_model.dart';

class DogDetailPage extends StatefulWidget {
  final Dog dog;

  DogDetailPage(this.dog);

  @override
  DogDetailPageState createState() {
    return new DogDetailPageState();
  }
}

class DogDetailPageState extends State<DogDetailPage> {
  final double dogAvatarSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  onChanged: (double rating) {
                    setState(() {
                      _sliderValue = rating;
                      print("rating is $rating");
                    });
                  },
                  value: _sliderValue,
                  max: 10.1,
                  min: 0.0,
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  '${_sliderValue.toInt()}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          color: Colors.indigoAccent,
          onPressed: () {
            if (_sliderValue < 4) {
              _ratingErrorDialog();
              return;
            }
            setState(() {
              widget.dog.rating = _sliderValue.toInt();
            });
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
  Widget get dogImage {
    return Container(
      height: dogAvatarSize,
      width: dogAvatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          const BoxShadow(
            offset: const Offset(1.0, 2.0),
            blurRadius: 2.0,
            spreadRadius: -1.0,
            color: const Color(0x33000000),
          ),
          const BoxShadow(
            offset: const Offset(2.0, 1.0),
            blurRadius: 3.0,
            spreadRadius: 0.0,
            color: const Color(0x24000000),
          ),
          const BoxShadow(
            offset: const Offset(3.0, 1.0),
            blurRadius: 4.0,
            spreadRadius: 2.0,
            color: const Color(0x1f000000),
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.dog.imageUrl),
        ),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          size: 40.0,
        ),
        Text(
          ' ${widget.dog.rating} / 10',
          style: Theme.of(context).textTheme.display2,
        ),
      ],
    );
  }

  Widget get dogProfile {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
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
          ]
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dogImage,
          // 적절한 스페이싱 추가: 디스크립션의 패딩과 일치 시킴
          SizedBox(height: 16.0),
          Text(
            '${widget.dog.name}  🎾',
            style: TextStyle(fontSize: 32.0),
          ),
          Text(
            widget.dog.location,
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text(widget.dog.description),
          ),
          rating,
        ],
      ),
    );
  }

  Future<Null> _ratingErrorDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rating Error!"),
          content: Text("They're good dogs, Brant."),
          actions: <Widget>[
            FlatButton(
              child: Text("Try again"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Meet ${widget.dog.name}'),
      ),
      body: ListView(
        children: <Widget>[
          dogProfile,
          addYourRating,
        ],
      ),
    );
  }
}
