import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:projetoecosam/Funcoes/Inicializacao/GetItInicialization.dart';
import 'package:projetoecosam/Paginas/HomePage/HomePage.dart';

import 'Funcoes/Inicializacao/hiveInicialization.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // MobileAds.instance.initialize();
  await hiveInicialization();
  Intl.defaultLocale = 'en_US';
 // AdsHelper.createInterstitialAd();
  await getItInicialization();
  runApp(Meuapp());
}

class Meuapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECOSAM',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        //contorno botões
      ),
      routes: {
        '/PaginaInicial': (context) => HomePage(),


        //LinhaDoTempo

      },
      initialRoute: '/PaginaInicial',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}