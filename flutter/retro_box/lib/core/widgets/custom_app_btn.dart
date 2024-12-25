import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';

class CustomAppBtn extends StatelessWidget {
  final String btnTitle;
  final void Function()? btnFun;
  final Color btnColor;
  const CustomAppBtn(
      {super.key, required this.btnTitle, required this.btnFun, required this.btnColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnFun,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            color: btnColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            btnTitle,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 20,
              fontFamily: 'Poppins-Bold',
              fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }
}
