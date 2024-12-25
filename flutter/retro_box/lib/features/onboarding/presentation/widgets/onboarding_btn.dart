// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';

class OnboardingBtn extends StatefulWidget {
  final String btnTitle;
  final Color? btnColor;
  final void Function()? btnFun;

  const OnboardingBtn(
      {super.key,
      required this.btnTitle,
      required this.btnColor,
      required this.btnFun});

  @override
  State<OnboardingBtn> createState() =>
      _OnboardingBtnState(btnTitle, btnColor, btnFun);
}

class _OnboardingBtnState extends State<OnboardingBtn> {
  final String? btnTitle;
  final Color? btnColor;
  final void Function()? btnFun;

  _OnboardingBtnState(this.btnTitle, this.btnColor, this.btnFun);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            btnFun!();
          });
        },
        child: Text(
          btnTitle!,
          style: TextStyle(
              color: btnColor, fontSize: 16, fontWeight: FontWeight.w400),
        ));
  }
}
