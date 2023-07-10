import 'package:flutter/material.dart';
import 'package:projetoecosam/ListaCores/LixoClass.dart';
import 'package:projetoecosam/ListaCores/todosJuntosList.dart';
import 'package:projetoecosam/Paginas/HomePage/HomePage.dart';

class ResultadoPage extends StatefulWidget {
  int acertos;
  int erros;
   ResultadoPage({required this.acertos, required this.erros,Key? key}) : super(key: key);

  @override
  State<ResultadoPage> createState() => _ResultadoPageState();
}

class _ResultadoPageState extends State<ResultadoPage> {
  List<LixoClass> todoLixosList= List.from(todosJuntosList);
  @override
  void initState() {
    todoLixosList.shuffle();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Parabéns!   Acertou: ${widget.acertos.toString()}',
          style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),),
        body: SingleChildScrollView(child:
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Que tal aprender um pouco sobre o tempo de decomposição do lixo?',
              textAlign: TextAlign.center,style: TextStyle(fontSize: 23,color: Colors.green,
                fontWeight: FontWeight.bold),),
            ),
            ListView.builder(
              shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: todoLixosList.length,
                itemBuilder: (context,index){
              return Card(
                color: Colors.green[100],
                child: ListTile(
                  leading: Image.asset(todoLixosList[index].imgPath,width: 60,height: 60,),
                  title: Text(todoLixosList[index].nome,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(todoLixosList[index].descricao+'.'),
                  trailing: Image.asset(retornaPathDaLata(todoLixosList[index].corLataInt)),
                ),
              );
            }),
            SizedBox(height: 20,)
          ],),),
      ),
    );
  }
  String retornaPathDaLata(int numero){
    String path='';
    switch(numero){
      case 0: path= 'assets/Latas/lataVermelha.png';
        break;
      case 1: path= 'assets/Latas/lataAzul.png';
      break;
      case 2: path= 'assets/Latas/lataAmarela.png';
      break;
      case 3: path= 'assets/Latas/lataVerde.png';
      break;
      case 4: path= 'assets/Latas/lataMarrom.png';
      break;
    }
    return path;
  }
}
