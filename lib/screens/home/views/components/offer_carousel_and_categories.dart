import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shop/components/skleton/others/categories_skelton.dart";
import "package:shop/entities/category_entity.dart";
import "package:shop/services/categories/load/load_categories_bloc.dart";
import "package:shop/utils/translate.dart";

import "../../../../constants.dart";
import "categories.dart";

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        // const OffersSkelton(),
        // const OffersCarousel(),
        // const SizedBox(
        //   height: defaultPadding / 2,
        // ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            t(context)!.categories_label,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        // While loading use 👇
        BlocBuilder<LoadCategoriesBloc, LoadCategoriesState>(
          bloc: context.read<LoadCategoriesBloc>()
            ..add(OnLoadCategoriesEvent()),
          builder: (context, state) {
            final bool isLoading =
                (state as LoadCategoriesInitialState).loading;

            final List<CategoryEntity> categories = state.categories;

            if (isLoading) {
              return const CategoriesSkelton();
            }

            return Categories(
              categories: categories,
            );
          },
        ),
      ],
    );
  }
}
