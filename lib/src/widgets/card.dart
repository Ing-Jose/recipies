import 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/pages/detalles_plato_page.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

// http://via.placeholder.com/350x150

class CardSwiper extends StatelessWidget {
  final List<PlatoModel> platos;

  const CardSwiper({Key key, @required this.platos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            _screenSize.width * 0.012,
            _screenSize.height * 0.01,
            _screenSize.width * 0.012,
            _screenSize.height * 0.13),
        child: _cardImage(context));
  }

  Widget _cardImage(BuildContext context) {
    return TransformerPageView(
      loop: true,
      viewportFraction: 0.8,
      transformer: PageTransformerBuilder(builder: (Widget child, TransformInfo info) {
        return GestureDetector(
          onTap: (){
            // print(platos[info.index].plato);
            //Navigator.of(context).pushNamed(DetallesPlatoPage.namePage, arguments: platos[info.index]);
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Material(
              elevation: 4.0,
              textStyle: TextStyle(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ParallaxContainer(
                    child: Image.network('${platos[info.index].fotoUrl}',
                      fit: BoxFit.fill,
                    ),
                    position: info.position,
                    // translationFactor: 300.0,
                  ),
                  // new ParallaxImage.asset(
                  //   images[info.index],
                  //   position: info.position,
                  // ),
                  new DecoratedBox(
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          const Color(0xFF000000),
                          const Color(0x33FFC0CB),
                        ],
                      ),
                    ),
                  ),
                  //parallaxContainerText(info)
                ],
              ),
            ),
          ),
        );
      }),
      itemCount: platos.length,
    );
  }

  Positioned parallaxContainerText(TransformInfo info) {
    return Positioned(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ParallaxContainer(
            child: Text(
              platos[info.index].plato,
              style: TextStyle(fontSize: 15.0),
            ),
            position: info.position,
            translationFactor: 300.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          ParallaxContainer(
            child: Text(platos[info.index].categoria,
                style: TextStyle(fontSize: 18.0)),
            position: info.position,
            translationFactor: 200.0,
          ),
        ],
      ),
      left: 10.0,
      right: 10.0,
      bottom: 10.0,
    );
  }



}
