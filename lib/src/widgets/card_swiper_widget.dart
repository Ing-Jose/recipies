import 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/pages/detalles_plato_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<PlatoModel> platos; // final por que sera inmutable

  const CardSwiper({Key key, this.platos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Obteniendo el tamaño del dipositivo, para trabajar con sus dimensiones
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        width: _screenSize.width * .9,
        height: _screenSize.height * .43,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            DetallesPlatoPage.namePage,
                            arguments: platos[index]),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/no-image.png'),
                          image: NetworkImage(platos[index].getUrlImagen(),
                              scale: 1.2),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text('${platos[index].plato}',
                          style:TextStyle(
                          color:(platos[index].fotoUrl!=null)?Colors.white:Colors.black54,
                          fontWeight: 
                          FontWeight.bold,
                          fontSize: 28
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Container(
                        height: 3.0,
                        width: 110.0,
                        color: Colors.orange,
                      )
                    ],
                  )
                )
              ],
            );
          },
          viewportFraction: 0.8,
          scale: 0.9,
          itemCount: platos.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
        ));
  }
}
