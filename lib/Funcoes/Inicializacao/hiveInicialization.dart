


import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';


hiveInicialization() async {
  // WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  //Hive.registerAdapter(QuebraSalvoTypeAdapter());

  await Hive.initFlutter(); // isso precisa do hive_flutter
 // await Hive.openBox<QuebraSalvoType>('QuebraSalvo');

}