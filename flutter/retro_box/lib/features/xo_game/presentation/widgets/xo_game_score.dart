import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retro_box/core/constants/app_assets.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/features/xo_game/presentation/logic/player.dart';

class XoGameScore extends StatelessWidget {
  final String secondPlayer;
  const XoGameScore({
    super.key, required this.secondPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.xoBoard,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppAssets.xLogo),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'you:',
                        style:
                            TextStyle(color: AppColor.black, fontSize: 16),
                      ),
                      Text(
                        Player.playerXWin.toString(),
                        style:
                            TextStyle(color: AppColor.black, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.xoBoard,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppAssets.oLogo),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        secondPlayer,
                        style:
                            TextStyle(color: AppColor.black, fontSize: 16),
                      ),
                      Text(
                        Player.playerOWin.toString(),
                        style:
                            TextStyle(color: AppColor.black, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
