import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/components/cart_button.dart";
import "package:shop/components/custom_modal_bottom_sheet.dart";
import "package:shop/components/network_image_with_loader.dart";
import "package:shop/entities/color_entity.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/entities/size_entity.dart";
import "package:shop/entities/variant_entity.dart";
import "package:shop/inputs/cart_input.dart";
import "package:shop/screens/product/views/added_to_cart_message_screen.dart";
import "package:shop/screens/product/views/components/product_list_tile.dart";
import "package:shop/screens/product/views/size_guide_screen.dart";
import "package:shop/services/cart/add_to_cart/add_to_cart_bloc.dart";
import "package:shop/utils/assets_network.dart";
import "package:shop/utils/format/price.dart";
import "package:shop/utils/translate.dart";

import "../../../constants.dart";
import "components/product_quantity.dart";
import "components/selected_colors.dart";
import "components/selected_size.dart";
import "components/unit_price.dart";

class ProductBuyNowScreen extends StatefulWidget {
  final ProductEntity productEntity;

  const ProductBuyNowScreen({
    Key? key,
    required this.productEntity,
  }) : super(key: key);

  @override
  _ProductBuyNowScreenState createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  late ValueNotifier<int> _quantity;
  late ValueNotifier<ColorEntity> _selectedColor;
  late ValueNotifier<SizeEntity> _selectedSize;

  late ValueNotifier<VariantEntity> selectedVariant;

  VariantEntity _getSelectedVariant() {
    return widget.productEntity.variants.firstWhere(
      (variant) =>
          variant.color == _selectedColor.value &&
          variant.size == _selectedSize.value,
      orElse: () => widget.productEntity.variants.first,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedVariant = ValueNotifier(widget.productEntity.variants.first);

    _quantity = ValueNotifier(1);
    _selectedColor = ValueNotifier(selectedVariant.value.color);
    _selectedSize = ValueNotifier(selectedVariant.value.size);

    _selectedColor.addListener(() {
      selectedVariant.value = _getSelectedVariant();
    });

    _selectedSize.addListener(() {
      selectedVariant.value = _getSelectedVariant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocListener<AddToCartBloc, AddToCartState>(
        listener: (context, state) async {
          if (state is AddToCartSuccessState) {
            selectedVariant.value = widget.productEntity.variants.first;
            _quantity.value = 1;

            customModalBottomSheet(
              context,
              isDismissible: false,
              child: const AddedToCartMessageScreen(),
            );
          }
        },
        child: CartButton(
          price: priceFormat((selectedVariant.value.priceAfterDiscount == null
                  ? selectedVariant.value.price
                  : selectedVariant.value.priceAfterDiscount!) *
              _quantity.value),
          title: t(context)!.add_to_cart_label,
          subTitle: t(context)!.add_to_cart_total_price_label,
          press: () async => context.read<AddToCartBloc>().add(
                OnAddToCartEvent(
                  variant: CartInput(
                    variant: selectedVariant.value,
                    product: widget.productEntity,
                    quantity: _quantity.value,
                  ),
                ),
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 2,
              vertical: defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  widget.productEntity.title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/Bookmark.svg",
                    color: widget.productEntity.isBookmarked
                        ? primaryColor
                        : Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(
                        networkImage(widget.productEntity.thumbnail),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(
                    defaultPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: priceFormat(selectedVariant.value.price),
                            priceAfterDiscount: selectedVariant
                                        .value.priceAfterDiscount !=
                                    null
                                ? priceFormat(
                                    selectedVariant.value.priceAfterDiscount!)
                                : null,
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: _quantity.value,
                          onIncrement: () => setState(() => _quantity.value++),
                          onDecrement: () {
                            if (_quantity.value > 1) {
                              setState(() => _quantity.value--);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: SelectedColors(
                    colors: widget.productEntity.variants
                        .map((e) => e.color)
                        .toList(),
                    selectedColorIndex: _selectedColor.value,
                    press: (value) =>
                        setState(() => _selectedColor.value = value),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SelectedSize(
                    sizes: widget.productEntity.variants
                        .map((e) => e.size)
                        .toSet()
                        .toList(),
                    selectedIndex: _selectedSize.value,
                    press: (value) =>
                        setState(() => _selectedSize.value = value),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding,
                  ),
                  sliver: ProductListTile(
                    title: t(context)!.add_to_cart_guide_size_label,
                    svgSrc: "assets/icons/Sizeguid.svg",
                    isShowBottomBorder: true,
                    press: () async {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: const SizeGuideScreen(),
                      );
                    },
                  ),
                ),
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: defaultPadding,
                //   ),
                //   sliver: SliverToBoxAdapter(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const SizedBox(
                //           height: defaultPadding / 2,
                //         ),
                //         Text(
                //           "Store pickup availability",
                //           style: Theme.of(context).textTheme.subtitle2,
                //         ),
                //         const SizedBox(
                //           height: defaultPadding / 2,
                //         ),
                //         const Text(
                //             "Select a size to check store availability and In-Store pickup options.")
                //       ],
                //     ),
                //   ),
                // ),
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                //   sliver: ProductListTile(
                //     title: "Check stores",
                //     svgSrc: "assets/icons/Stores.svg",
                //     isShowBottomBorder: true,
                //     press: () async {
                //       customModalBottomSheet(
                //         context,
                //         height: MediaQuery.of(context).size.height * 0.92,
                //         child: const LocationPermissonStoreAvailabilityScreen(),
                //       );
                //     },
                //   ),
                // ),
                const SliverToBoxAdapter(
                    child: SizedBox(
                  height: defaultPadding,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
