import 'package:flutter/material.dart';

import 'package:cooking_at_home/src/bloc/prividers.dart';
import 'package:cooking_at_home/src/widgets/card_swiper_widget.dart' as widget;
import 'package:cooking_at_home/src/widgets/imagen_banner_clipper.dart';
// Desayuno
class BreakfastPage extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final platosBloc = Provider.platosBloc(context);
    platosBloc.obtenerPlatos();
    
    return Column(
      children: <Widget>[
        BannerImag(tipoPlato: 'Desayunos', url: 'assets/huevos.gif',),
        _swiperTarjetas(platosBloc)
      ],
    );
  }

  Widget _swiperTarjetas(PlatosBloc platosBloc){
    return StreamBuilder<List<PlatoModel>>(
      stream: platosBloc.platoDesayunoStream,
      builder: (BuildContext context, AsyncSnapshot<List<PlatoModel>> snapshot){
        // print(snapshot.data);
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