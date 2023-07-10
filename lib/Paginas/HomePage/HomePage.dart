import 'package:flutter/material.dart';
import 'package:projetoecosam/Paginas/JogoPage/JogoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: SingleChildScrollView(child: Column(children: [
        SizedBox(height: 100,),
        Container(height: MediaQuery.of(context).size.height*0.4,
          width: double.maxFinite,
          child: Image.asset('assets/logo.png',fit: BoxFit.fitWidth,),),
        SizedBox(height: 100,width: 250,
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            JogoPage()));
          },
              child: Text('INICIAR JOGO',style: TextStyle(fontSize: 26),)),
        ),
      ],),),
    );
  }
}
