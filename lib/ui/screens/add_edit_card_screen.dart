import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/provider/add_card_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/widgets/button_formCard_add.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_form_add.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/button_past_card.dart';
import 'package:sbox/ui/widgets/button_past_site.dart';
import 'package:sbox/ui/widgets/button_question_card.dart';
import 'package:sbox/ui/widgets/button_question_site.dart';
import 'package:sbox/ui/widgets/radio_button_nm.dart';
import 'package:sbox/ui/widgets/text_field_card.dart';
import 'package:sbox/ui/widgets/text_field_site.dart';

@immutable
class AddCard extends StatelessWidget {
  final bColor = ColorsSHM();
  late String note;
  late String card;
  late String name;
  late String date;
  late String dateExp;
  late String cvv;
  late String pinAtm;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().baseColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // addTextFieldWidget(objNum: 1),
                    // addTextFieldWidget(objNum: 2),
//
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container note
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 1,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_note.tr(),
                                  num: 1,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 1),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintNote,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container note
                    const SizedBox(height: 10),

                    //
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container card
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 2,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_card.tr(),
                                  num: 2,
                                  flgKbd: true,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 2),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintCard,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container card
                    SizedBox(height: 10),

                    //
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container name
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 3,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_name.tr(),
                                  num: 3,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 3),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintName,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container name

                    SizedBox(height: 10),
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container date
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 4,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_date.tr(),
                                  num: 4,
                                  flgKbd: true,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 4),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintDate,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container date

                    SizedBox(height: 10),
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container dateExp
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_date_exp.tr(),
                                  num: 5,
                                  flgKbd: true,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 5),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintDateExp,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container dateExp
                    SizedBox(height: 10),
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container cvv
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 6,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_cvv.tr(),
                                  num: 6,
                                  flgKbd: true,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 6),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintCvv,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container cvv
                    SizedBox(height: 10),
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container pinAtm
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                ButtonPastCard(
                                  num: 7,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextFieldCard(
                                  textLbl: LocaleKeys.c_pin.tr(),
                                  num: 7,
                                  flgKbd: true,
                                ),
                                const SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionCard(num: 7),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddCardProvider>().hintPinAtm,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container pinAtm
                    const SizedBox(height: 30),

                    ButtonFormCardAdd(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
