import 'package:flutter/material.dart';



/// recibe como parametro las lista de las categoria a dibujar y la funcion que se ejecuta
class CategorySelectionWidget extends StatefulWidget {
  final Map<String, IconData> categories;
  final Function(String) onValueChanged;// para informar cual es el que esta selecionado dentro de categoria
  final String currentItem;

  CategorySelectionWidget({Key key, @required this.categories, @required this.onValueChanged, this.currentItem} ) : super(key: key);

  @override
  _CategorySelectionWidgetState createState() => _CategorySelectionWidgetState();
}

////////////////
class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool select;

  const CategoryWidget({Key key, this.name, this.icon, this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            // color: Colors.red,
            width: 89,
            height: 47,
            child: Icon(icon,color: (select)?Colors.white:Colors.black54),
            decoration: BoxDecoration(
              color: (select)?Colors.deepPurple[100]:Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: (select)?Colors.deepPurple:Colors.grey,
                width: select ? 3.0 : 1.0
              )
            ),
          ),
          Text(name)
        ],
      ),
    );
  }
}
////////////////

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  
  String currentItem; // por defautl esta selecionado Shopping  
  
  @override
  void initState() {
    // TODO: implement initState
    currentItem=widget.currentItem;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // currentItem=widget.currentItem;
    widget.onValueChanged(currentItem);
    var widgets = <Widget>[];
    // para cada categoria que nos pasan la iteramos
    widget.categories.forEach((name, icon){
      widgets.add(
        GestureDetector(
          child: CategoryWidget(
            name: name,
            icon: icon,
            select: name == currentItem,
          ),
          onTap: (){
            setState(() {
              currentItem=name;
            });
      
            widget.onValueChanged(name);
          },
        )
      );
    });
    return Center(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: widgets,
      ),
    );
  }
}