import 'package:flutter/material.dart';

import 'dog_detail_page.dart';
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
    Widget dogAvatar = Hero(
      tag: widget.dog,
      child: Container(
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
      ),
    );

    Widget placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black54, Colors.black, Colors.blueGrey[600]
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        "DOGGOS",
        textAlign: TextAlign.center,
      ),
    );
    return AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: dogAvatar,
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 1000),
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
              Text(
                widget.dog.name,
                style: Theme.of(context).textTheme.headline,
              ),
              Text(
                widget.dog.location,
                style: Theme.of(context).textTheme.subhead,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                  ),
                  Text(
                    ': ${widget.dog.rating} / 10',
                    style: Theme.of(context).textTheme.caption,
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
    return InkWell(
      // 짧아서 따로 분리하지 않았음. 나중에 길어지면 함수로 분리 가능.
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_context) {
              return DogDetailPage(widget.dog);
            }
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
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
      ),
    );
  }
}
