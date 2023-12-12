import 'package:flutter/material.dart';

class TextFieldFormCustomBorder extends StatefulWidget {
  const TextFieldFormCustomBorder({
    Key? key,
    required this.onChanged,
    required this.placeholder,
    required this.mesaje,
    required this.labelText,
    required this.typeInput,
  }) : super(key: key);
  final String placeholder;
  final String mesaje;
  final String labelText;
  final ValueChanged<String> onChanged;
  final TextInputType typeInput;

  @override
  State<TextFieldFormCustomBorder> createState() =>
      TextFieldFormCustomBorderState();
}

class TextFieldFormCustomBorderState extends State<TextFieldFormCustomBorder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: TextFormField(
        keyboardType: widget.typeInput,
        onChanged: (value) {
          widget.onChanged(value);
        },
        key: Key(widget.mesaje),
        initialValue: widget.mesaje,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: widget.mesaje,
          labelText: widget.labelText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(100.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1, color: Colors.black), //<-- SEE HERE
            borderRadius: BorderRadius.circular(100.0),
          ),
          // hintStyle: GoogleFonts.barlow(
          //   fontSize: 16.0,
          //   wordSpacing: 1,
          //   letterSpacing: 0.001,
          //   fontWeight: FontWeight.normal,
          //   color: Colors.black,
          // ),
          filled: true,
          // labelStyle: GoogleFonts.barlow(
          //   fontSize: 16.0,
          //   wordSpacing: 1,
          //   letterSpacing: 0.001,
          //   fontWeight: FontWeight.normal,
          //   color: Colors.black,
          // ),
        ),
        // style: GoogleFonts.barlow(
        //   fontSize: 16.0,
        //   wordSpacing: 1,
        //   letterSpacing: 0.001,
        //   fontWeight: FontWeight.normal,
        //   color: Colors.black,
        // ),
        onSaved: (value) => {widget.onChanged(value!)},
        validator: (value) {
          return widget.placeholder;
        },
      ),
    );
  }
}
