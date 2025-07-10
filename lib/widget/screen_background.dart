import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';
class screen_background extends StatelessWidget {
  const screen_background({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(
            Asset.backgroundpath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(child: child)
        ],
      ),
    );
  }
}
