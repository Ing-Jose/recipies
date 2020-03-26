import 'dart:ui';

import 'package:flutter/material.dart';


class BannerImag extends StatelessWidget {
  
  final String url;
  final String tipoPlato;
  
  BannerImag({ @required  this.url,  @required this.tipoPlato});

  @override
  Widget build(BuildContext context) {

    // Obteniendo el tamaño del dipositivo, para trabajar con sus dimensiones
    final _screenSize = MediaQuery.of(context).size;

    return Stack(
      children:<Widget>[
        Container(
          child: ClipPath(
            clipper: _MyClipper(),
            child: Container(
              width: _screenSize.width,
              height: _screenSize.height*0.25, // ocupa el 25% de la patalla 
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: NetworkImage(url),
                  image: AssetImage(url),
                  // image: NetworkImage('https://cdn.pixabay.com/photo/2015/09/02/12/43/meal-918639_1280.jpg'),
                  // image: NetworkImage('https://cdn.pixabay.com/photo/2016/02/20/21/41/vegetables-1212845_1280.jpg'),
                  fit: BoxFit.cover
                )
              ),
              child: ClipRect(
                child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
                      child: Container(
                        color: Colors.black.withOpacity(0.0),
                        // decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 57,
          // child: Text('$tipoPlato', style: Theme.of(context).textTheme.title)
          child: Text('$tipoPlato', textScaleFactor: 2.0,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromRGBO(255, 0, 0, 0)
                ),
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 8.0,
                  color: Color.fromARGB(125, 0, 0, 255)
                )
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: 50,
        //   child: Container(color: Colors.white, height: 2.0, width: 165, margin: EdgeInsets.only(left: 55),),
        // )
        
      ]
    );
        
    
    
  }
}




Widget recortarImagen({String url}){
  return ClipPath(
          clipper: _MyClipper(),
          child: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                // image: NetworkImage('https://cdn.pixabay.com/photo/2015/09/02/12/43/meal-918639_1280.jpg'),
                // image: NetworkImage('https://cdn.pixabay.com/photo/2016/02/20/21/41/vegetables-1212845_1280.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
        );
}
class _MyClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height-20);
    path.quadraticBezierTo(size.width/4, size.height-70, size.width/2, size.height-35);
    path.quadraticBezierTo(size.width*3/4, size.height, size.width, size.height-55);
    // path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
} 