import "package:flutter/material.dart";
import 'package:shop/entities/size_entity.dart';

import "../../../../constants.dart";

class SelectedSize extends StatelessWidget {
  final List<SizeEntity> sizes;
  final SizeEntity selectedIndex;
  final ValueChanged<SizeEntity> press;

  const SelectedSize({
    Key? key,
    required this.sizes,
    required this.selectedIndex,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Select Size",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Row(
          children: List.generate(
            sizes.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultPadding : defaultPadding / 2),
              child: SizeButton(
                text: sizes[index].value,
                isActive: selectedIndex == sizes[index],
                press: () => press(sizes[index]),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SizeButton extends StatelessWidget {
  const SizeButton({
    Key? key,
    required this.text,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  final String text;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: OutlinedButton(
        onPressed: press,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          side: isActive ? const BorderSide(color: primaryColor) : null,
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: isActive
                  ? primaryColor
                  : Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
    );
  }
}
