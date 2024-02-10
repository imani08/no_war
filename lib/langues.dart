import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:translator/translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('sw', 'TZ'), // Langue swahili (Tanzanie)
        Locale('ln', 'CG'), // Langue lingala (République démocratique du Congo)
        // Ajoutez les autres langues prises en charge
      ],
      path: 'assets/langs',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String translatedText = '';

  void translateText() async {
    String textToTranslate = 'hello'.tr();
    final translator = GoogleTranslator();

    Translation translation = await translator.translate(textToTranslate, to: context.locale.languageCode);
    String translated = translation.text;

    setState(() {
      translatedText = translated;
    });
  }

  void navigateToSupportedLanguages() async {
    Locale selectedLocale = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SupportedLanguagesPage()),
    );

    if (selectedLocale != null) {
      context.locale = selectedLocale;
      translateText(); // Traduire le texte dans la nouvelle langue sélectionnée
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Langues'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translatedText,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: translateText,
              child: Text('translate'.tr()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: navigateToSupportedLanguages,
              child: Text('Supported Languages'),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportedLanguagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> supportedLocales = context.supportedLocales;

    return Scaffold(
      appBar: AppBar(
        title: Text('Supported Languages'),
      ),
      body: ListView.builder(
        itemCount: supportedLocales.length,
        itemBuilder: (context, index) {
          Locale locale = supportedLocales[index];
          String languageName = locale.languageCode;

          // Récupérer le nom de la langue à partir du code de langue
          switch (locale.languageCode) {
            case 'en':
              languageName = 'English';
              break;
            case 'fr':
              languageName = 'Français';
              break;
            case 'sw':
              languageName = 'Swahili';
              break;
            case 'ln':
              languageName = 'Lingala';
              break;
          // Ajoutez les autres langues prises en charge ici avec leurs noms respectifs
          }

          return ListTile(
            title: Text(languageName),
            onTap: () {
              Navigator.pop(context, locale); // Retourne la langue sélectionnée à la page précédente
            },
          );
        },
      ),
    );
  }
}