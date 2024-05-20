import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  const FormContainerWidget({super.key, this.controller, this.fieldKey, this.isPasswordField, this.hintText, this.labelText, this.helperText, this.onSaved, this.validator, this.onFieldSubmitted, this.inputType});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {


  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 119, 233, 141).withOpacity(.35),
        border: Border.all(
      color: const Color.fromARGB(255, 119, 233, 141), // or any color you prefer for the border
      width: 2.0, // you can adjust the border width
    ),
    borderRadius: BorderRadius.circular(10),
        
         ),

         child: TextFormField(
          style: const TextStyle(color: Color.fromARGB(255, 14, 15, 14)),
          controller: widget.controller,
          keyboardType: widget.inputType,
          key: widget.fieldKey,
          obscureText: widget.isPasswordField== true? _obscureText: false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: widget.hintText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText= !_obscureText;
                });
              },
              child: widget.isPasswordField==true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false? Colors.blue : Colors.grey,): const Text(" ")
            )
          ),
         ),
    );
  }
}