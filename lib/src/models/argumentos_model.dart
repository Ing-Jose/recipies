/// Clase para manejar los argumentos que se envia a la pagina de crear plato
/// como la pagina sera llamada desdes dos pagina se creo esta clase intermedio
/// para saber desde donde recibe el llamado
class ScreenArguments {
  final int pag; // para 
  final String message;

  ScreenArguments(this.pag, this.message);
}