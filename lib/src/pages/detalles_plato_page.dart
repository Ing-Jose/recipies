import 'package:cooking_at_home/src/bloc/prividers.dart';
import 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/widgets/card_dialogo_clase.dart';
import 'package:cooking_at_home/src/widgets/fade_Animation_widget.dart';
import 'package:flutter/material.dart';

class DetallesPlatoPage extends StatefulWidget {
  static final String namePage = 'details';

  @override
  _DetallesPlatoPageState createState() => _DetallesPlatoPageState();
}

class _DetallesPlatoPageState extends State<DetallesPlatoPage> {
  @override
  Widget build(BuildContext context) {
    

    final PlatoModel _platoArg = ModalRoute.of(context).settings.arguments; // obteniendo los argumentos 
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detalles'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed:()=> _confirmar(context,_platoArg))
        ],
      ),
      
      body: cuerpo(_platoArg),
      floatingActionButton: _crearBtn(context,_platoArg)
    );
  }

  Widget cuerpo(PlatoModel plato){
    return Container(
      child: Column(
        children: <Widget>[
          FadeAnimation(.8,Container(
            width: double.infinity,
            height: 483,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img1.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black87.withOpacity(.8),
                    Colors.black.withOpacity(.0)
                  ])
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _nombrePlato(plato)
                ],
              ),
            ),
          )),
          Expanded(
            child: Transform.translate(
              child: FadeAnimation(1,Container(
                width: double.infinity,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  // color:Colors.deepPurple[600]
                  color:Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30) )
                ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1.5,Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.star, size:28,color: Colors.yellow[800],),
                        Icon(Icons.star, size:28,color: Colors.yellow[800],),
                        Icon(Icons.star, size:28,color: Colors.yellow[800],),
                        Icon(Icons.star_border, size:28,color: Colors.yellow[800],),
                        Icon(Icons.star_border, size:28,color: Colors.yellow[800],),
                      ],
                    )),
                    SizedBox(height: 15,),
                    FadeAnimation(1.3,Text('Receta', style: TextStyle(color:Colors.grey[800],fontSize: 35, fontWeight: FontWeight.bold),)),
                    FadeAnimation(1.3,Text('${plato.descripcion}', style: TextStyle(color:Colors.grey[800],fontSize: 20, fontWeight: FontWeight.normal),)),
                    SizedBox(height: 25),
                    FadeAnimation(1.4,Text('Notas', style: TextStyle(color:Colors.grey[800],fontSize: 35, fontWeight: FontWeight.bold),)),
                    FadeAnimation(1.4,Text('${plato.notas}', style: TextStyle(color:Colors.grey[800],fontSize: 20, fontWeight: FontWeight.normal),)),
                    
                  ],
                ),
              )),
              offset: Offset(0,-50)
            )
          )
        ],
      ),
    );
  }

  Widget _nombrePlato(PlatoModel p){
    return FadeAnimation(1,Container(
      width: double.infinity,
      // color: Colors.deepPurple,
      // margin: EdgeInsets.only(bottom: ),
      child: Container(
        padding: EdgeInsets.only(left: 25,bottom: 57),
        child: Text('${p.plato}', style: TextStyle(color:Colors.white,fontSize: 38),),
      ),
    ));
  }

  FloatingActionButton _crearBtn(BuildContext context, PlatoModel plato) {
    return FloatingActionButton(
      child: Icon(Icons.edit),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=>Navigator.of(context).pushNamed('add',arguments: plato)
    );
  }

  _confirmar(BuildContext context, PlatoModel plato ) async {
    final confirmarOk =  await Dialogo.confirmar(context,title: 'ELIMINAR',body: 'Esta seguro que desea eliminar este Plato?');
    final platosBloc = Provider.platosBloc(context);
    print('is $confirmarOk');
    if (confirmarOk) {
      // print('confirmo');
      if (plato.fotoUrl!=null) {
        platosBloc.eliminarImg(plato.fotoUrl);
      }
      platosBloc.eliminarPlato(plato);
      Navigator.pop(context);
    }else{
      print('object');
    }
  }
}