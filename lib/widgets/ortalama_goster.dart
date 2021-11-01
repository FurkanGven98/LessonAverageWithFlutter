import 'package:dinamik_not_ort/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;
  const OrtalamaGoster(
      {required this.dersSayisi, required this.ortalama, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dersSayisi > 0 ? '$dersSayisi Ders girildi.' : 'Ders seçiniz.',
          style: Sabitler.dersSayisiStyle,
        ),
        Text(
          ortalama >= 0 ? '${ortalama.toStringAsFixed(2)}' : '0.0',
          style: Sabitler.ortStyle,
        ),
        Text(
          'Ortalama',
          style: Sabitler.ortBodyStyle,
        )
      ],
    );
  }
}
