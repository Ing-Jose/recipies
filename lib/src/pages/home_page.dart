import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:cooking_at_home/src/bloc/platos_bloc.dart';
import 'package:cooking_at_home/src/bloc/prividers.dart';
import 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/pages/search_page.dart';
import 'package:cooking_at_home/src/widgets/card_dialogo_clase.dart';
import 'package:cooking_at_home/src/widgets/imagen_banner_clipper.dart';
import 'package:cooking_at_home/src/widgets/card_swiper_widget.dart' as widget;
// import 'package:cooking_at_home/src/widgets/card.dart';


class HomePage extends StatefulWidget {
  static final String namePage = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final PlatosProvider _platosProvider = PlatosProvider();
  int _currenIndex = 1;

  @override
  Widget build(BuildContext context) {
  final platosBloc = Provider.platosBloc(context);
  platosBloc.obtenerPlatos();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cooking at Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: ()=>Navigator.of(context).pushNamed(SearchPage.namePage)
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            BannerImag(tipoPlato: 'Almuerzos', url: 'assets/img1.jpg',),
            _swiperTarjetas(platosBloc),
          ],
        ),
    ),
      floatingActionButton: _crearBtn(context),
      bottomNavigationBar: _crearMenuBtn(),
    );
  
  }

  _confirmar(BuildContext context) async {
    final confirmarOk =  await Dialogo.confirmar(context,title: 'ACCIÓN REQUERIDA',body: 'Esta seguro que desea salir?');
    print('is $confirmarOk');
    if (confirmarOk) {
      print('confirmo');
    }else{
      print('object');
    }
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
  } 

  FloatingActionButton _crearBtn(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      // onPressed: ()=>Navigator.of(context).pushNamed('add')
      onPressed: ()=>_confirmar(context)
    );
  }

  // Widget _cuerpo() {
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         BannerImag(tipoPlato: 'Todos', url: 'assets/img1.jpg',),
  //         _swiperTarjetas(),
  //       ],
  //     ),
  //   );
  // }

  Widget _crearMenuBtn(){
    return CurvedNavigationBar(
      
      index: _currenIndex,
      items: [
       Icon(Icons.local_dining, size: 40, color: Colors.white,),
       Icon(Icons.local_dining, size: 40, color: Colors.white,),
       Icon(Icons.local_dining, size: 40, color: Colors.white,),
     ],
     // recibe el index, a cual tab se le hizo el clip en base 0
     onTap: (index){
       setState(() {
         _currenIndex = index;
       });
     },
     /* Colores */
     color: Theme.of(context).primaryColor,
     backgroundColor: Colors.white,
     buttonBackgroundColor: Theme.of(context).primaryColor,

     height: 70,
    );
  }
}

