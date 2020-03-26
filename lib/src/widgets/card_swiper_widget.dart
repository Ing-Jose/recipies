import 'package:flutter/material.dart';
import 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/pages/detalles_plato_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cooking_at_home/src/widgets/utils_widget.dart' as utils;

class CardSwiper extends StatelessWidget {
  final List<PlatoModel> platos; // final por que sera inmutable

  const CardSwiper({Key key, this.platos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Obteniendo el tamaño del dipositivo, para trabajar con sus dimensiones
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: _screenSize.width * 1.1,
      height: _screenSize.height * .50,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return buildStack(context, index);
        },
        viewportFraction: 0.9,
        scale: 0.9,
        itemCount: platos.length,
      )
    );
  }

  Stack buildStack(BuildContext context, int index) {
    final _screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        buildContainerCardImag(index),
        buildContainerGradient(context, index),
        buildPaddingTitleYDescrip(_screenSize, index)
      ],
    );
  }

  Padding buildPaddingTitleYDescrip(Size _screenSize, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          _screenSize.width * 0.020,
          _screenSize.height * 0.36,
          _screenSize.width * 0.020,
          _screenSize.height * 0.02),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            _screenSize.width * 0.02,
            _screenSize.height * 0.02,
            _screenSize.width * 0.01,
            _screenSize.height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(.7)),
        child: Row(
          children: <Widget>[
            buildTitulo(index),
            SizedBox(
              width: _screenSize.width * .023,
            ),
            Container(
              height: _screenSize.height * 0.079,
              width: 3.9,
              color: Colors.orange,
            ),
            SizedBox(width: 10.0),
            buildDescriptionClasif(index),
          ],
        ),
      ),
    );
  }

  Widget buildTitulo(int index) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${platos[index].plato}',
              style: utils.styleTextTitlePlato,
            ),
            SizedBox(height: 10.0),
            Icon(
              Icons.restaurant,
              color: Colors.white,
              size: 40,
            )
          ],
        ),
      ],
    );
  }

  Expanded buildDescriptionClasif(int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              '${platos[index].descripcion}',
              maxLines: 2,
              style: utils.styleTextDescripPlato,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height:10),
          Row(
            children: <Widget>[
              SizedBox(
                width: 40,
              ),
              Icon(Icons.star, size: 30,color:Colors.yellow),
              Icon(Icons.star, size: 30,color:Colors.yellow),
              Icon(Icons.star, size: 30,color:Colors.yellow),
              Icon(Icons.star_border, size: 30,color:Colors.yellow),
              Icon(Icons.star_border, size: 30,color:Colors.yellow),
            ],
          ),
          
        ],
      ),
    );
  }

  Padding buildPaddingDescrption(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 370, bottom: 10, left: 12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.description,
                color: Colors.white,
                size: 25,
              ),
              Text(
                '${platos[index].descripcion}',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildContainerTitle(int index) {
    return Container(
        padding: EdgeInsets.only(top: 20.0, left: 10.0),
        child: Column(
          children: <Widget>[
            Text(
              '${platos[index].plato}',
              style: TextStyle(
                  color: (platos[index].fotoUrl != null)
                      ? Colors.white
                      : Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            SizedBox(height: 3.0),
            Container(
              height: 3.0,
              width: 110.0,
              color: Colors.orange,
            ),
    
          ],
        ));
  }

  GestureDetector buildContainerGradient(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(DetallesPlatoPage.namePage, arguments: platos[index]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.0001),
              Colors.deepPurple[200]
            ],
            begin: Alignment(0, 0),
            end: Alignment(0, 1.1),
          ),
        ),
      ),
    );
  }

  Container buildContainerCardImag(int index) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.png'),
            image: NetworkImage(platos[index].getUrlImagen(), scale: 1.2),
            fit: BoxFit.cover,
          )),
    );
  }

}

// onTap: () => Navigator.of(context).pushNamed(
//     DetallesPlatoPage.namePage,
//     arguments: platos[index]),
