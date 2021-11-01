import 'package:dinamik_not_ort/constants/app_constants.dart';
import 'package:dinamik_not_ort/helper/data_helper.dart';
import 'package:dinamik_not_ort/model/ders.dart';
import 'package:dinamik_not_ort/widgets/ders_listesi.dart';
import 'package:dinamik_not_ort/widgets/harf_dropdown_wirdget.dart';
import 'package:dinamik_not_ort/widgets/ortalama_goster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  _OrtalamaHesaplaPageState createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double secilenHarfDeger = 4;
  double secilenKrediDeger = 1;
  String girilenDersAdi = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    child: _buildForm(),
                    color: Colors.white,
                  )),
              Expanded(
                  flex: 1,
                  child: OrtalamaGoster(
                      dersSayisi: DataHelper.tumEklenenDersler.length,
                      ortalama: DataHelper.ortHesapla()))
            ],
          ),
          Expanded(
            child: DersListesi(
              onDismiss: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: Sabitler.yatayPadding8,
              child: _buildTextFormField(),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: Sabitler.yatayPadding8,
                    child: HarfDropdownWidget(
                      onHarfSecildi: (harf) {
                        secilenHarfDeger = harf;
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: Sabitler.yatayPadding8,
                    child: _buildKrediler(),
                  ),
                ),
                IconButton(
                  onPressed: _dersEkleveOrtHesapla,
                  icon: Icon(Icons.arrow_forward_ios),
                  color: Sabitler.anaRenk,
                  iconSize: 30,
                ),
              ],
            ),
            SizedBox(height: 5),
          ],
        ));
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Ders adını giriniz.';
        } else
          return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenKrediDeger,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          setState(() {
            secilenKrediDeger = deger!;
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }

  void _dersEkleveOrtHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDeger,
          krediDegeri: secilenKrediDeger);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
