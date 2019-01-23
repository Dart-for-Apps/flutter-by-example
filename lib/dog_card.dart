import 'package:flutter/material.dart';

import 'dog_model.dart';

class DogCard extends StatefulWidget {
  final Dog dog;

  DogCard(this.dog);
  @override
  _DogCardState createState() => _DogCardState();
}

class _DogCardState extends State<DogCard> {
  String renderUrl;


  @override
  void initState() {
    super.initState();
    renderDogPic();
  }

  void renderDogPic() async {
    await widget.dog.getImageUrl();

    setState(() {
      renderUrl = widget.dog.imageUrl;
    });
    print(widget.dog.imageUrl);
  }
  
  Widget get dogImage {
    return Container(
      width: 100.0,
      height: 100.0,
      
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          // 기존 샘플코드로 할 경우 renderUrl이 아직 세팅 되지 않았을 때 에러가 발생함.
          image: (renderUrl != null && renderUrl.length != 0)
              ? NetworkImage(renderUrl)
              : AssetImage('images/sample.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget get dogCard {
    return Container(
      width: 290.0,
      height: 115.0,
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // 기본 코드에 하얀색 코드 추가함.
              Text(
                widget.dog.name,
                style: Theme.of(context).textTheme.headline
                    .copyWith(color: Colors.white),
              ),
              Text(
                widget.dog.location,
                style: Theme.of(context).textTheme.subhead
                    .copyWith(color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  Text(
                    ': ${widget.dog.rating} / 10',
                    style: Theme.of(context).textTheme.caption
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
//      padding: EdgeInsets.all(0.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
//        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 115.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 50.0,
              child: dogCard,
            ),
            Positioned(top:7.5, child: dogImage),
          ],
        ),
      ),
    );
  }
}
