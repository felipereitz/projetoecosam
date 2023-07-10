import 'package:get_it/get_it.dart';
import 'package:event_bus/event_bus.dart';

getItInicialization( )async{
  final getIt= GetIt.instance;
  getIt.registerSingleton<EventBus>(EventBus());
  // getIt.registerSingleton<TabelaTaco>(TabelaTaco());
  // getIt<TabelaTaco>().tacoJson=await carregaTabelaTaco();


}


// event_bus tutorial // obs geralmente os eventos são classes com os valores sendo atributos delas
//
// Para ouvir tudo que for dado fire:
//
// getIt<EventBus>().on().listen((event) {
// // aqui faz alguma coisa com o evento recebido
// });
//
// Para ouvir apenas eventos especificos de uma classe:
//
// getIt<EventBus>().on<NomeDaClasse>().listen((event) {
// // aqui faz alguma coisa com o evento recebido
// });