import 'package:firebaseapp/screens/localization/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import 'helpers/launguage.dart';


class LanguageScreens extends StatelessWidget {
  const LanguageScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).homePageAppBarTitle),
        actions: <Widget>[
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.green,
              ),
              onChanged: (Language? language) async{
              context.read<LanguageCubit>().changeLanguage(language, context);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.languageCode,
                        style: const TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
      body:  Column(
        children: [
          Center(
            child: Text(
                S.of(context).aboutUsPageAppBarTitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height:10.0),

        ],
      ),

    );
  },
);
  }
}
