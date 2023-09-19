
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:hello_language_change/config/resources/colors.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.localization ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppColors.appBarBgColor
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.hello ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey, // Set the background color
                borderRadius: BorderRadius.circular(25.0), // Add rounded corners
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isEnglish = !isEnglish;
                  });
                  final newLocale = isEnglish ? const Locale("en") : const Locale("fr");
                  Get.updateLocale(newLocale);
                },
                child: Text(
                  isEnglish ? "Switch to French" : "Passer à l'anglais",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.white// Set text color
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}