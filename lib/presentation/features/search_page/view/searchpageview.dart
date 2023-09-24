import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../model/countries_list.dart';
import '../model/searchpage_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<Country>(
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
            suffixIcon: Icon(Icons.search),
            labelText: AppLocalizations.of(context)!.search ?? "",
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
    );
  }
}

