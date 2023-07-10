import 'package:rxdart/rxdart.dart';

class Bloc{

  BehaviorSubject<int> acertosController= BehaviorSubject<int>()..value=0;
  Stream<int> get acertosStream =>acertosController.stream;

  BehaviorSubject<int>errosController= BehaviorSubject<int>()..value=0;
  Stream<int> get errosStream => errosController.stream;
}