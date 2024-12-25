import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_assets.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/core/routes/routes_names.dart';
import 'package:retro_box/core/widgets/custom_app_bar.dart';
import 'package:retro_box/core/widgets/custom_app_btn.dart';
import 'package:retro_box/features/xo_game/presentation/widgets/game_rule.dart';

class XoRules extends StatelessWidget {
  final String? session;
  const XoRules({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: customAppBar(
          barTitle: 'Game Rules',
          barIcon: Icons.arrow_back_ios_new_rounded,
          barFunc: () => Navigator.pop(context)),
      body: gameRulesContent(context),
    );
  }

  Column gameRulesContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        GameRule(
          ruleTitle: 'Win',
          ruleDescription: 'Get 3 marks in a row,\nPlayer wins, game ends.',
          ruleimage: AppAssets.xWin,
          imageSpace: 50,
        ),
        Divider(
          height: 2,
          indent: 80,
          endIndent: 80,
          color: AppColor.black,
        ),
        GameRule(
          ruleTitle: 'Defeat',
          ruleDescription:
              'Opponnent gets 3 in a row,\nPLayer Loses, game ends.',
          ruleimage: AppAssets.oWin,
          imageSpace: 23,
        ),
        Divider(
          height: 2,
          indent: 80,
          endIndent: 80,
          color: AppColor.black,
        ),
        GameRule(
          ruleTitle: 'Draw',
          ruleDescription: 'Board full, no 3 in a row,\nNo winner, game ends.',
          ruleimage: AppAssets.draw,
          imageSpace: 23,
        ),
        const SizedBox(
          height: 50,
        ),
        CustomAppBtn(
            btnTitle: 'Play',
            btnFun: () => Navigator.pushNamed(context, RoutesName.xoGameSession,
                arguments: session),
            btnColor: AppColor.primary)
      ],
    );
  }
}
