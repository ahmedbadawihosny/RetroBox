// ignore_for_file: no_logic_in_create_state, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/core/widgets/custom_app_bar.dart';
import 'package:retro_box/core/widgets/custom_app_btn.dart';
import 'package:retro_box/features/xo_game/domain/entites/player.dart';
import 'package:retro_box/features/xo_game/presentation/provider/xo_game_controller.dart';
import 'package:retro_box/features/xo_game/presentation/widgets/xo_game_score.dart';

class XoGameSession extends StatefulWidget {
  final String session;
  const XoGameSession({super.key, required this.session});

  @override
  State<XoGameSession> createState() => _XoGameSessionState();
}

class _XoGameSessionState extends State<XoGameSession> {
  late XoGameController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<XoGameController>(context, listen: false);
    if (widget.session == 'AI_Game') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.initializeGame();
      });
    }
  }

  void _showWinnerDialog(BuildContext context, String winner) {
    String message = winner == 'Draw' ? "It's a draw!" : 'Player $winner wins!';
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.white,
          title: Text('Game Over', 
            style: TextStyle(color: AppColor.black, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          content: Text(message,
            style: TextStyle(color: AppColor.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                if (widget.session == 'AI_Game') {
                  await controller.resetAIGame();
                } else {
                  controller.resetFriendGame();
                }
                setState(() {});
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Play Again',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<XoGameController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: customAppBar(
            barTitle: 'Tic Tac Toe',
            barIcon: Icons.arrow_back_ios_new_rounded,
            barFunc: () {
              Navigator.pop(context);
              controller.newGame();
            },
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.session == 'AI_Game'
                  ? XoGameScore(secondPlayer: 'bot')
                  : XoGameScore(secondPlayer: 'Friend'),
              const SizedBox(height: 30),
              gameBoard(context, controller),
              const SizedBox(height: 30),
              CustomAppBtn(
                btnTitle: 'Reset Game',
                btnColor: AppColor.primary,
                btnFun: () async {
                  if (widget.session == 'AI_Game') {
                    await controller.resetAIGame();
                  } else {
                    controller.resetFriendGame();
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomAppBtn(
                btnTitle: 'New Game',
                btnColor: AppColor.white,
                btnFun: () => controller.newGame(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Padding gameBoard(BuildContext context, XoGameController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              if (widget.session == 'AI_Game') {
                if (controller.winner.isEmpty) {
                  await controller.makeAIMove(index);
                  if (controller.winner.isNotEmpty) {
                    _showWinnerDialog(context, controller.winner);
                  }
                }
              } else {
                if (controller.winner.isEmpty) {
                  controller.handleTap(index);
                  if (controller.winner.isNotEmpty) {
                    _showWinnerDialog(context, controller.winner);
                  }
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: AppColor.xoBoard,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  controller.board[index],
                  style: TextStyle(
                    color: controller.board[index] == Player.x
                        ? AppColor.playerX
                        : AppColor.playerO,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
