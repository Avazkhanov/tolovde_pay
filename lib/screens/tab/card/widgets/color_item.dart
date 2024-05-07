import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tolovde_pay/utils/colors/app_colors.dart';

class ColorItem extends StatefulWidget {
  const ColorItem({super.key, required this.color});
  final ValueChanged<Color> color;

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
  List<Color> colors = [AppColors.c_1A72DD, AppColors.c_F4261A, Colors.amber];
  Color activeColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                activeColor = colors[index];
                widget.color.call(activeColor);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: colors[index],
                shape: BoxShape.circle,
              ),
              child:
                  colors[index] == activeColor ? const Icon(Icons.check) : const SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
