import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retro_box/core/constants/app_colors.dart';

class GameRule extends StatelessWidget {
  final String ruleTitle;
  final String ruleDescription;
  final String ruleimage;
  final double imageSpace;

  const GameRule({
    super.key,
    required this.ruleTitle,
    required this.ruleDescription,
    required this.ruleimage,
    required this.imageSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ruleTitle,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              ruleDescription,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          width: imageSpace,
        ),
        SvgPicture.asset(ruleimage)
      ],
    );
  }
}
