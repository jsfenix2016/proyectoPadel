import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxCustom extends StatelessWidget {
  const CheckBoxCustom(
      {super.key,
      required this.valueType,
      required this.title,
      required this.onChanged,
      required this.styleCustom,
      required this.unselectedColorCustom});
  final bool valueType;
  final String title;
  final ValueChanged<bool> onChanged;
  final TextStyle styleCustom;
  final Color unselectedColorCustom;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(unselectedWidgetColor: unselectedColorCustom),
        child: CheckboxListTile(
          activeColor: Colors.transparent, // Color cuando está seleccionado
          checkColor: Colors.white, // Color del check cuando está seleccionado
          // inactiveTrackColor: Colors.grey, // Color cuando no está seleccionado
          controlAffinity: ListTileControlAffinity.leading,
          value: valueType,
          onChanged: (value) {
            onChanged(value!);
          },
          title: Text(
            title.tr,
            textAlign: TextAlign.left,
            style: styleCustom,
          ),
        ),
      ),
    );
  }
}
