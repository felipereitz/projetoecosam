import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoecosam/ListaCores/LixoClass.dart';
import 'package:projetoecosam/ListaCores/latasList.dart';
import 'package:projetoecosam/ListaCores/todosJuntosList.dart';
import 'package:flutter_animate/flutter_animate.dart' as Ani;
import 'package:projetoecosam/Paginas/HomePage/HomePage.dart';
import 'package:projetoecosam/Paginas/JogoPage/Bloc.dart';
import 'package:projetoecosam/Paginas/ResultadoPage/ResultadoPage.dart';

class JogoPage extends StatefulWidget {
  const JogoPage({Key? key}) : super(key: key);

  @override
  State<JogoPage> createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> with TickerProviderStateMixin  {
  List<LixoClass> todoLixosList= List.from(todosJuntosList);
  List<AnimationController> animationControllerList=[];
  Bloc bloc= Bloc();
  late AnimationController mensagemAnimationController;
  Color corMensagem= Colors.green;
  String textoMensagem= 'Acertou!';

  final acertoSound = AudioPlayer();
  final erroSound = AudioPlayer();
  
  @override
  void initState() {
    todoLixosList.shuffle();
    iniciaSom();
    mensagemAnimationController = AnimationController(vsync: this);
    for(var i=0;i<latasList.length;i++){
      animationControllerList.add(AnimationController(
          vsync: this,
      duration: Duration(milliseconds: 500)));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text('Deseja sair do jogo?'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('Não')),
            TextButton(onPressed: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
                child: Text('Sim'))
          ],
        ));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.greenAccent[100],
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[100],
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            StreamBuilder<int>(
              stream: bloc.acertosStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  int acertos= snapshot.data!;
                  return Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.green,radius: 10,),
                      SizedBox(width: 5,),
                      Text('Acertos: ${acertos.toString()}'),
                    ],
                  );
                }
                return Container();
              }
            ),
              StreamBuilder<int>(
                  stream: bloc.errosStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      int erros= snapshot.data!;
                      return Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.red,radius: 10,),
                          SizedBox(width: 5,),
                          Text('Erros: ${erros.toString()}'),
                        ],
                      );
                    }
                    return Container();
                  }
              )
          ],),
        ),
        body: Center(
          child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  color: corMensagem,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 40),
                    child: Text(textoMensagem,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                    color: Colors.white),),
                  ),).animate(
                  controller: mensagemAnimationController,
                  autoPlay: false,
                  onComplete: (controler){
                   // controler.reverse();
                  }
                ).show(duration: Duration(milliseconds: 1),).then(delay: 2000.ms).hide(),
              ),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                for(var i=0;i<latasList.length;i++)
                  DragTarget<LixoClass>(
                      onAccept: (lixo){
                        if(latasList[i].id==lixo.corLataInt){
                          animationControllerList[i].reset();
                          animationControllerList[i].forward();
                          todoLixosList.remove(lixo);
                          bloc.acertosController.add(bloc.acertosController.value+1);
                          corMensagem=Colors.green;
                          textoMensagem='Acertou!';
                          mensagemAnimationController.reset();
                          mensagemAnimationController.forward();
                          acertoSound.play(AssetSource('acerto.mp3'));

                          setState(() {

                          });
                          if(todoLixosList.length==0){
                            acabouFunction();
                          }
                        }else{
                          todoLixosList.remove(lixo);
                          bloc.errosController.add(bloc.errosController.value+1);
                          corMensagem=Colors.red;
                          textoMensagem='Errou!';
                          mensagemAnimationController.reset();
                          mensagemAnimationController.forward();
                          erroSound.play(AssetSource('erro.mp3'));

                          setState(() {

                          });
                          if(todoLixosList.length==0){
                            acabouFunction();
                          }
                        }

                      },
                      builder: (context,lixos,lista){
                      return Container(
                        height: 165,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(latasList[i].imgPath).animate(
                              autoPlay: false,
                              controller: animationControllerList[i],
                              onComplete: (controller){
                                controller.reverse();
                              }
                          ).scale(
                            duration: Duration(milliseconds: 300),
                              end: Offset(1.1, 1.1),
                              curve: Curves.bounceInOut)

                        ),
                      );
                  })
              ],),
            )
          ],),),
        ),
        bottomNavigationBar: Container(
          height: 190,
        color: Colors.green[200],
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for(var i=0;i<todoLixosList.length;i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Draggable<LixoClass>(
                  key: UniqueKey(),
                  affinity: Axis.vertical,
                    data: todoLixosList[i],
                    child: Container(
                      //height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3,color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                       // gradient: LinearGradient(colors: [Colors.blue[200]!,Colors.blue[100]!,Colors.green[100]!])
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(todoLixosList[i].nome,style: TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[700]),),
                            SizedBox(
                                height: 120,
                                child: Image.asset(todoLixosList[i].imgPath)),
                          ],
                        ),
                      ),
                    ),
                    feedback: SizedBox(
                        height: 120,
                        child: Image.asset(todoLixosList[i].imgPath)),
                dragAnchorStrategy: (objeto,context,postion){
                    return Offset(60, 60);
                },),

              )
          ],),
        ),),
      ),
    );
  }
  void acabouFunction(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
    ResultadoPage(
        acertos: bloc.acertosController.value,
        erros: bloc.errosController.value)));
  }
  void iniciaSom()async{

  }
}
