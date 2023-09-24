import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:hello_language_change/config/resources/colors.dart';
import '../../search_page/model/coutries_list.dart';
import '../../search_page/model/searchpage_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isEnglish = true.obs;

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
            SizedBox(
              child: Autocomplete<Country>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return countryOptions
                      .where((Country county) => county.name.toLowerCase()
                      .startsWith(textEditingValue.text.toLowerCase())
                  )
                      .toList();
                },
                displayStringForOption: (Country option) => option.name,
                fieldViewBuilder: (
                    BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted
                    ) {
                  return TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: AppLocalizations.of(context)!.search ?? "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                    ),
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
                onSelected: (Country selection) {
                  print('Selected: ${selection.name}');
                },
                optionsViewBuilder: (
                    BuildContext context,
                    AutocompleteOnSelected<Country> onSelected,
                    Iterable<Country> options
                    ) {
                  return Material(
                    child: Container(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Country option = options.elementAt(index);

                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(
                                  option.name,
                                  style: const TextStyle(color: Colors.black)
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
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
                    isEnglish.value = !isEnglish.value;

                  final newLocale = isEnglish.value ? const Locale("en") : const Locale("ne");
                  Get.updateLocale(newLocale);
                },
                child: Obx(()=>
                  Text(
                    isEnglish.value ? "Switch to Nepali" : "अंग्रेजीमा स्विच गर्नुहोस्",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.white// Set text color
                    ),
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