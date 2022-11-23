import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/route/screen_export.dart";

import "../../../../constants.dart";

class ExpansionCategory extends StatelessWidget {
  const ExpansionCategory({
    Key? key,
    required this.title,
    required this.subCategory,
    required this.svgSrc,
  }) : super(key: key);

  final String title, svgSrc;
  final List subCategory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).textTheme.bodyText1!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyText2!.color,
      leading: SvgPicture.asset(
        svgSrc,
        height: 24,
        width: 24,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      textColor: Theme.of(context).textTheme.bodyText1!.color,
      childrenPadding: const EdgeInsets.only(left: defaultPadding * 3.5),
      children: List.generate(
        subCategory.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () async {
                Navigator.pushNamed(context, onSaleScreenRoute);
              },
              title: Text(
                subCategory[index].title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (index < subCategory.length - 1) const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
