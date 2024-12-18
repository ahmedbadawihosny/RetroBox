import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetOnboarding extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const GetOnboarding(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image),
        const SizedBox(
          height: 30,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
