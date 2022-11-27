import "package:flutter/material.dart";
import 'package:shop/entities/color_entity.dart';

import "../../../../constants.dart";
import "color_dot.dart";

class SelectedColors extends StatelessWidget {
  final List<ColorEntity> colors;
  final ColorEntity selectedColorIndex;
  final ValueChanged<ColorEntity> press;

  const SelectedColors({
    Key? key,
    required this.colors,
    required this.selectedColorIndex,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Select Color",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              colors.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? defaultPadding : defaultPadding / 2),
                child: ColorDot(
                  color: colors[index].value,
                  isActive: selectedColorIndex == colors[index],
                  press: () => press(colors[index]),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
