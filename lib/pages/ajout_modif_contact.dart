import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/contact.model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../services/contact.service.dart';

class AjoutModifContactPage extends StatefulWidget {
  AjoutModifContactPage({this.contact ,this.modifMode=false});
  final Contact? contact;
  final bool modifMode;

  @override
  State<AjoutModifContactPage> createState() => _AjoutModifContactPageState();
}

class _AjoutModifContactPageState extends State<AjoutModifContactPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Contact contact = Contact();
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modifMode? 'Page Modifier Contact':'Page Ajouter Contact',
            style:
            GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple.shade200,
        centerTitle: true,
      ),
      body: Form(
        key: globalKey,
        child: _formUI(),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              widget.modifMode? "Modifier":"Ajouter",
                  () {
                if (validateAndSave()) {
                  if(validateAndSave()){
                    contactService.ModifierContact(contact!).then((value) {
                      Navigator.pop(context);
                    });
                  }
                  contactService.AjouterContact(contact!).then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              borderRadius: 10,
              btnColor: Colors.blueGrey,
              borderColor: Colors.blueGrey,
            ),
            FormHelper.submitButton(
              "Annuler",
                  () {
                Navigator.pop(context);
              },
              borderRadius: 10,
              btnColor: Colors.blueGrey,
              borderColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    if(widget.modifMode)contact=widget.contact!;
  }
  _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context, "nom", "Nom", "", (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              return null;
            },
                  (onSaved) {
                contact!.nom = onSaved.toString().trim();
              },
              initialValue: widget.modifMode? contact!.nom!:"",
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context, "tel", "Téléphone", "", (onValidate) {
              if (onValidate.isEmpty) {
                return "* Required";
              }
              return null;
            },
                  (onSaved) {
                contact!.tel = int.parse(onSaved.toString().trim());
              },
              initialValue: widget.modifMode? contact!.tel.toString():"",
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.numbers),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
              isNumeric: true,
            ),

          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

