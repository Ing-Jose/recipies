import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cooking_at_home/src/models/platos_models.dart';
import 'package:cooking_at_home/src/providers/plato_provider.dart';
import 'package:cooking_at_home/src/widgets/selector_categoria.dart';
import 'package:image_picker/image_picker.dart';

class AddPlatoPage extends StatefulWidget {
  static final String namePage = 'add';

  AddPlatoPage({Key key}) : super(key: key);

  @override
  _AddPlatoPageState createState() => _AddPlatoPageState();
}

class _AddPlatoPageState extends State<AddPlatoPage> {
  final formKey = GlobalKey<FormState>(); // para refenrenciar el formulario
  final scaffoldKey = GlobalKey<ScaffoldState>(); // para refenrenciar el Scaffold para mostrar el snakBar
  final PlatosProvider _platosProvider = PlatosProvider();
  PlatoModel _platoModel = PlatoModel();
  String categoria;
  bool _guardando = false;
  File img;
  // int pag = 0; //

  @override
  Widget build(BuildContext context) {
    final PlatoModel _arg = ModalRoute.of(context).settings.arguments; // obteniendo los argumentos
    // Obteniendo el tamaño del dipositivo, para trabajar con sus dimensiones
    final _screenSize = MediaQuery.of(context).size;

    // si voy a editar o guardar un plato nuevo
    if (_arg != null) {
      _platoModel = _arg;
      categoria = _platoModel.categoria;
    }

    return Scaffold(
      backgroundColor:  Color.fromRGBO(244, 243, 243, 1),
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        // brightness: Brightness.light,
        // title: Text('Agregar un Nuevo plato'),
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.image), onPressed: _galeriImage),
        //   IconButton(icon: Icon(Icons.camera_alt), onPressed: _camaraImage),
        // ],
      ),
      body: SingleChildScrollView(
          // child: buildContainer1(),
        child: Stack(
          children: <Widget>[
          Container(
            height: _screenSize.height * .40,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/cocina.jpg'), fit: BoxFit.cover)),
          ),
          Container(
            margin: EdgeInsets.only(top: _screenSize.height * .30),
            child: Material(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 110, left: 30, right: 10, bottom: 30),
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //       'El Ingrediente Secreto \nes el Amor',
                    //       style: TextStyle(
                    //       color: Colors.black87,
                    //       fontSize: 24,
                    //       fontWeight: FontWeight.bold),
                    //     ),
                    // ),

                    contenedorForm(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            right: 21,
            child: Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage('assets/img1.jpg'), fit: BoxFit.cover
                  // ),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(30),
                  //   // topRight: Radius.circular(30),
                  //   bottomRight: Radius.circular(30),
                  //   // bottomLeft: Radius.circular(30)
                  // ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.deepPurple,
                        blurRadius: 10.0,
                        offset: Offset(0, 0))
                  ]),
              child: Material(
                  borderRadius: BorderRadius.only(
                      // topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  child: _mostrarImg()),
            ),
          ),
          Positioned(
            top: 311,
            left: 30,
            child: Text(
              'El Ingrediente Secreto \nes el Amor',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 330,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.image, color: Colors.deepPurple),
                    onPressed: _galeriImage),
                IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.deepPurple),
                    onPressed: _camaraImage),
              ],
            ),
          ),
        ],
      )
          // Column(
          //   children: <Widget>[
          //     // buildContainerAddImagen(),
          //     // contenedorForm()
          //   ],
          // ),
          ),
      // resizeToAvoidBottomPadding: false,
    );
  }

  Container buildContainerAddImagen() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              // spreadRadius: 2.0,
              // offset: Offset(0,2.0)
            )
          ]),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text('data', style: TextStyle(fontSize: 25),)
          Text(
            'Agregar',
            style: TextStyle(color: Colors.black87, fontSize: 25),
          ),
          SizedBox(height: 3.0),
          Text(
            'Nuevo Plato',
            style: TextStyle(color: Colors.black87, fontSize: 38),
          ),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            height: 230.0,
            child: _mostrarImg(),
          ),
          // SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Container contenedorForm() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          formulario(),
        ],
      ),
    );
  }

  Form formulario() {
    return Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _selectorCategoria(),
            _containerInput(child: crearNombre()),
            SizedBox(height: 10.0),
            _containerInput(child: _crearDescripcion()),
            SizedBox(height: 10.0),
            _containerInput(child: _crearNota()),
            // _crearDescripcion(),
            // _crearNota(),
            SizedBox(height: 15.0),
            _crearBtn(),
          ],
        ));
  }

  Widget _selectorCategoria() {
    return Container(
      padding: EdgeInsets.only(top: 3),
      alignment: Alignment.bottomRight,
      height: 80.0,
      child: CategorySelectionWidget(
        categories: {
          "Desayuno": Icons.free_breakfast,
          "Almuerzo": Icons.restaurant,
          "Cena": Icons.fastfood,
        },
        onValueChanged: (newCategoria) => categoria = newCategoria,
        currentItem: _platoModel.categoria,
      ),
    );
  }

  Widget _containerInput({Widget child}) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          // color: Color.fromRGBO(244, 243, 243, 1),
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }

  TextFormField crearNombre() {
    return TextFormField(
      initialValue: _platoModel.plato,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => _platoModel.plato = value,
      // Validacion de la caja
      validator: (value) =>
          (value.length < 3) ? 'Ingrese el nombre del plato' : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Nombre del plato',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        // labelText: 'Plato'
      ),
    );
  }

  TextFormField _crearDescripcion() {
    return TextFormField(
      initialValue: _platoModel.descripcion,
      onSaved: (value) => _platoModel.descripcion = value,
      // textCapitalization: TextCapitalization.sentences,
      maxLines: 3,
      validator: (value) => (value.length < 5)
          ? '*Ingrese una breve descripción del plato'
          : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Ingredientes del plato',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        // labelText: 'Plato'
      ),
    );
  }

  Widget _crearNota() {
    return TextFormField(
      initialValue: _platoModel.notas,
      onSaved: (value) => _platoModel.notas = value,
      maxLines: 2,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '*Nota del plato',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }

  Widget _crearBtn() {
    return RaisedButton.icon(
      label: (_platoModel.id == null) ? Text('Guardar') : Text('Editar'),
      icon: Icon(Icons.save),
      onPressed: (!_guardando) ? _submit : null,
      textColor: Colors.white,
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    // formulario valido
    if (categoria == null) {
      showDialogCategoria();
      return;
    }
    // disparando todos los metodos onSaved de los campos de nuetro formulario
    formKey.currentState.save();
    _platoModel.categoria = categoria;

    setState(() => _guardando = true);

    // enviando la imagen y esperando el url
    if (img != null) {
      _platoModel.fotoUrl = await _platosProvider.subirImagen(img);
    }
    // print(_platoModel.plato);
    // print(_platoModel.descripcion);
    // print(_platoModel.notas);
    // print(_platoModel.categoria);

    if (_platoModel.id == null) {
      _platosProvider.crearPlato(_platoModel);
      _mostrarSnackBar('Plato creado');
    } else {
      _platosProvider.editPlato(_platoModel);
      _mostrarSnackBar('Plato editado');
    }

    Navigator.pop(context);
    setState(() => _guardando = false);
  }

  Future showDialogCategoria() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Debe seleccionar una categoría"),
              actions: <Widget>[
                FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ));
  }

  /// metodo que sirve para mostar un SnackBar cuando se manda la peticion de guardar o actualizar
  void _mostrarSnackBar(String mensaje) {
    final snackbar = SnackBar(
      backgroundColor: Colors.deepPurple,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Text(
            mensaje,
            style: TextStyle(fontStyle: FontStyle.italic),
          )),
          Expanded(child: Icon(Icons.check))
        ],
      ),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  /// Seleccionar imagen de pendiendo el tipo de donde se obtendra
  /// necesita como parametro `source` que sera de dos opciones
  /// * ImageSource.gallery
  /// * ImageSource.gallery
  _selectedImage({@required ImageSource source}) async {
    //TODO: Perfeccionar cuando se cancela ImagePicker.pickImage(source: source); retorna null
    // osea se pidio montar una foto y el usuario lo cancelo debe quedar la imagen anterior
    img = await ImagePicker.pickImage(source: source);
    if (img != null) {
      //limpiar
    }
    setState(() {});
  }

  _galeriImage() async {
    _selectedImage(source: ImageSource.gallery);
  }

  _camaraImage() async {
    _selectedImage(source: ImageSource.camera);
  }

  ///Mostar la imagen
  Widget _mostrarImg() {
    if (_platoModel.fotoUrl != null) {
      //TODO: Implementar esto
      return Placeholder();
    } else {
      if (img != null) {
        return Image.file(
          img,
          fit: BoxFit.cover,
          height: 200.0,
        );
      }
      return Image.asset('assets/no-image.png', fit: BoxFit.cover);
    }
  }
}
