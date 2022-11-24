import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/entities/category_entity.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/services/categories/load/load_categories_bloc.dart";

import "../../../../constants.dart";

Map<String, dynamic> mappedSlug = {
  "onsale": onSaleScreenRoute,
  "kids": kidsScreenRoute,
};

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadCategoriesBloc, LoadCategoriesState>(
      bloc: context.read<LoadCategoriesBloc>()..add(OnLoadCategoriesEvent()),
      builder: (context, state) {
        final List<CategoryEntity> categories =
            (state as LoadCategoriesInitialState).categories;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                categories.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? defaultPadding : defaultPadding / 2,
                    right: index == categories.length - 1 ? defaultPadding : 0,
                  ),
                  child: CategoryBtn(
                    category: categories[index].title,
                    // svgSrc: categories[index].svgSrc,
                    isActive: index == 0,
                    press: () async {
                      if (mappedSlug.containsKey(categories[index].slug)) {
                        Navigator.pushNamed(
                          context,
                          mappedSlug[categories[index].slug],
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    Key? key,
    required this.category,
    this.svgSrc,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  final String category;
  final String? svgSrc;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (svgSrc != null)
              SvgPicture.asset(
                svgSrc!,
                height: 20,
                color:
                    isActive ? Colors.white : Theme.of(context).iconTheme.color,
              ),
            if (svgSrc != null) const SizedBox(width: defaultPadding / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
