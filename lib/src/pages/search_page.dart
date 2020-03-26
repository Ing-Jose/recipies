import 'dart:ui';
// import 'package:cooking_at_home/src/bloc/prividers.dart';
import 'package:flutter/material.dart';
import 'package:cooking_at_home/src/bloc/prividers.dart';
import 'package:cooking_at_home/src/bloc/platos_bloc.dart';

import 'package:cooking_at_home/src/widgets/utils_widget.dart' as utils;
import 'package:cooking_at_home/src/widgets/card_swiper_widget.dart' as widget;

class SearchPage extends StatefulWidget {
  static final String namePage = 'search';
  @override
  _SearchPageState createState() => new _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    
    final platosBloc = Provider.platosBloc(context);
    platosBloc.obtenerPlatos();
     // Obteniendo el tamaño del dipositivo, para trabajar con sus dimensiones
    final _screenSize = MediaQuery.of(context).size;
    // print(_screenSize.height);
    return new Scaffold(
      body: buildSafeArea(platosBloc,_screenSize.height),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,size: 34,),
          onPressed: () => Navigator.of(context).pushNamed('add')),
    );
  }

  SafeArea buildSafeArea(PlatosBloc platosBloc, double height) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          // SizedBox(height: 20),
          buildStackBanner(height),
          SizedBox(height: height*.015),
          buildContainerDateMonth(),
          buildContainerDateDay(),
          SizedBox(height: height*.011),
          _swiperTarjetas(platosBloc)
          // buildStackImage(platosBloc)
        ],
      ),
    );
  }

  Container buildContainerDateDay() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        'HOY',
        style: utils.styleTextTitleDateDay,
      ),
    );
  }

  Container buildContainerDateMonth() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        'September 8',
        style: utils.styleTextTitleDateMoth,
      ),
    );
  }

  Stack buildStackBanner(double height) {
    return Stack(
      children: <Widget>[
        Container(
          height: height*.26,
          color: Colors.deepPurple[100],
        ),
        Column(
          children: <Widget>[
            buildContainerTextFromFieldSearch(height),
            SizedBox(height: height*.033),
            buildPaddingLema(height),
            SizedBox(height: height*.013),
            buildContainerTipeFood(height)
          ],
        )
      ],
    );
  }

  Container buildContainerTextFromFieldSearch(double height) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        height*.016, height*.040, height*.016, height*.0004),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(25.0),
        child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.black),
              contentPadding: EdgeInsets.only(left: height*.016, top: height*.016),
              hintText: 'Search for recipes and channels',
              hintStyle: utils.styleTextSearch),
        ),
      ),
    );
  }

  Padding buildPaddingLema(double height) {
    return Padding(
      padding: EdgeInsets.only(left: height*.018),
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: Colors.orange,
                    style: BorderStyle.solid,
                    width: 3.0))),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('COCINAR CON', style: utils.styleTextTitleBanner),
                Text('AMOR TE ALIMENTA EL ALMA',
                    style: utils.styleTextTitleBanner),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildContainerTipeFood(double height) {
    return Container(
      padding: EdgeInsets.only(top: height*.0167, left: height*.0167),
      height: height*.086,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _foodCard('Desayuno'),
          SizedBox(width: 8.0),
          _foodCard('Almuerzo'),
          SizedBox(width: 8.0),
          _foodCard('Cena'),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }

  Container buildStackImage(PlatosBloc platosBloc) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Container(
              height: 360.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      image: AssetImage('assets/img1.jpg'), fit: BoxFit.cover)),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                  child: Container(
                    color: Colors.white.withOpacity(0.0),
                    // decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
          ),
          // _swiperTarjetas(platosBloc),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 250,horizontal: 24),
            child: Container(
                // height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                // color: Colors.red,
                padding: EdgeInsets.only(top: 8, left: 4.0,bottom: 8),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'BEST OF',
                          style: utils.styleTextTitlePlato,
                        ),
                        Text(
                          'THE DAY',
                          style: utils.styleTextTipoPlato,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: 3.0,
                          width: 50.0,
                          color: Colors.orange,
                        )
                      ],
                    ),
                    SizedBox(width: 12.0,),
                    Container(
                      // padding: EdgeInsets.only(left: 12.0),
                      height: 60,
                      width: 3.2,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 12.0,),
                    
                   
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget _foodCard(String food) {
    return GestureDetector(
      onTap: () => print(food),
      child: Container(
        // height: 1.0,
        width: 125.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey, blurRadius: 10.0, offset: Offset(0, 2))
            ]),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: AssetImage('assets/balanced.jpg'))),
              // height: 100.0,
              width: 40.0,
            ),
            SizedBox(width: 5.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  food,
                  style: utils.styleTextTitleFood,
                ),
                // Text(
                //   'with Fruit Salad',
                //   style: TextStyle(fontFamily: 'Quicksand'),
                // ),
                SizedBox(height: 10.0),
                Container(
                  // padding: EdgeInsets.only(right: 32.0),
                  height: 2.0,
                  width: 60.0,
                  color: Colors.orange,
                ),
                // SizedBox(height: 10.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     // Container(
                //     //   height: 25.0,
                //     //   width: 25.0,
                //     //   decoration: BoxDecoration(
                //     //       borderRadius: BorderRadius.circular(12.5),
                //     //       image: DecorationImage(
                //     //           image: AssetImage('assets/img1.jpg'))),
                //     // ),
                //     // SizedBox(width: 10.0),
                //     Text('James Oliver',
                //         style: TextStyle(fontFamily: 'Quicksand'))
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas(PlatosBloc platosBloc){
    return StreamBuilder<List<PlatoModel>>(
      stream: platosBloc.platoStream,
      builder: (BuildContext context, AsyncSnapshot<List<PlatoModel>> snapshot){
        
        if (snapshot.hasData) {
          final platoData = snapshot.data;
          // print(platoData[0].plato);
          return widget.CardSwiper(platos: platoData,);
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    // return Placeholder();
  }
}
