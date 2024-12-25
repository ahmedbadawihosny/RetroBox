import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/core/routes/routes_names.dart';
import 'package:retro_box/core/widgets/custom_app_bar.dart';
import 'package:retro_box/core/widgets/custom_app_btn.dart';

class XoHome extends StatelessWidget {
  const XoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: customAppBar(
          barIcon: Icons.arrow_back_ios_new_rounded,
          barFunc: () => Navigator.pop(context)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/tic_tac_toe/xo_logo.png'),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Tic-Tac-Toe',
              style: TextStyle(
                color: AppColor.black,
                fontSize: 25,
                fontFamily: 'Poppins-Bold',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            CustomAppBtn(
                btnTitle: 'Play With AI',
                btnFun: () => Navigator.pushNamed(context, RoutesName.xoRules,
                    arguments: 'AI_Game'),
                btnColor: AppColor.primary),
            const SizedBox(
              height: 20,
            ),
            CustomAppBtn(
                btnTitle: 'Play With Friend',
                btnFun: () => Navigator.pushNamed(context, RoutesName.xoRules,
                    arguments: 'Friends_Game'),
                btnColor: AppColor.white),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
