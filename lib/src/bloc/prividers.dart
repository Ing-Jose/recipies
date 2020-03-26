import 'package:flutter/material.dart';
import 'package:cooking_at_home/src/bloc/platos_bloc.dart';
export 'package:cooking_at_home/src/bloc/platos_bloc.dart';

/*** este archivo será el InheritedWidget, personalizado */

class Provider extends InheritedWidget{
  // instanciando el patron bloc
  final _platoBloc = new PlatosBloc(); // primera y unica instancia
  static Provider _instancia; // INTANCIA de la clase
  // para saber si necesito regresar una nueva intancia o utilizar ya un existente
  factory Provider({Key key, Widget child}){
    if (_instancia==null) { // se necesita crear una nueva
      _instancia = new Provider._internal(key: key, child: child,);
      
    }
    return _instancia;
  }
  Provider._internal ({Key key, Widget child})
  : super(key: key, child: child);

  // factory Provider({Key key, Widget child}){
  //   if (_instancia==null) {
  //     _instancia = new Provider._internal();
  //   }
  //   return _instancia;
  // }
  ////////////////////// opc 1/////////////////////////////////
  // // contructor de forma corta. 
  // // Key= identificar unico del widget
  // // super para inicializar el InheritedWidget
  // Provider ({Key key, Widget child})
  // : super(key: key, child: child);
 ////////////////////// opc 1/////////////////////////////////
  // Provider._internal({Key key, Widget child}) 
  //   : super(key: key, child: child);

  // para que al actualizarce notifique a sus hijo
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  /** 
   * cuando utilizamos este provider vamos a ocupar la instancia de 
   * nuestro platoBloc, es decir que regrese el estado como esta 
   * ese platoBloc.
   * static: para que sea un metodo que se llame directamente 
   * retornara la instancia de platoBloc. el metodo se llamara 
   * platosBloc() recibira como argumento BuildContext
   **/
  static PlatosBloc platosBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>()._platoBloc;
    
  }
}