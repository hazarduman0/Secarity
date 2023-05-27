import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secarity/constants/app_colors.dart';

class InputArea extends StatefulWidget {
  InputArea(
      {super.key,
      required this.text,
      required this.controller,
      required this.isPassword});

  String text;
  TextEditingController? controller;
  bool isPassword;

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  late bool _isVisible;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Container(
        height: size.shortestSide * 0.3,
        width: size.shortestSide,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.dividerColor, width: 1.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.shortestSide * 0.04,
              horizontal: size.shortestSide * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(widget.text,
                  style: Theme.of(context).textTheme.headlineSmall),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: focusNode,
                  style: Theme.of(context).textTheme.bodyMedium,
                  obscureText: _isVisible,
                  cursorColor: AppColors.appBlue,
                  decoration: InputDecoration(
                      suffixIcon: widget.isPassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: FaIcon(
                                  !_isVisible
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  size: size.shortestSide * 0.04,
                                  color: AppColors.iconColor1))
                          : const SizedBox.shrink(),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}