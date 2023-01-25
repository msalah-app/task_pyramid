import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CustomFormField extends StatefulWidget {
  final String? hintText;
  final bool security;
  final TextInputType inputType;
  final String? validation;
  final String? Function(String?)? validationFunction;
  final Function(dynamic)? saved;
  final int maxLine;
  final Widget? prefix;
  final Widget? suffix;
  final bool suffixBool;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final int? number;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  const CustomFormField(
      {Key? key,
      required this.hintText,
      this.onEditingComplete,
      this.focusNode,
      this.validationFunction,
      this.security = false,
      this.textInputAction = TextInputAction.next,
      this.controller,
      this.inputType = TextInputType.text,
      this.validation = 'الحقل مطلوب',
      this.saved,
      this.maxLine = 1,
      this.prefix,
      this.suffixBool = false,
      this.suffix,
      this.onChanged,
      this.number = 0})
      : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool security = false;
  @override
  void initState() {
    super.initState();
    security = widget.security;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * 90,
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffixBool
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      security = !security;
                    });
                  },
                  icon: Icon(
                      !security ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey))
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          hintText: widget.hintText,
          hintStyle: Constant.bodyLineGrey14,
          enabledBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.black87,
              width: .2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Constant.primaryColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Constant.primaryColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Constant.primaryColor,
              width: 1,
            ),
          ),
        ),
        onEditingComplete: widget.onEditingComplete,
        validator: widget.validationFunction ??
            (value) {
              if (value!.isEmpty || value.length < widget.number!) {
                return widget.validation;
              }
              return null;
            },
        onSaved: widget.saved,
        onFieldSubmitted: widget.saved,
        obscureText: security,
        maxLines: widget.maxLine,
        keyboardType: widget.inputType,
      ),
    );
  }
}
