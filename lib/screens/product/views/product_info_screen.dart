import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:shop/constants.dart";
import "package:shop/entities/product_entity.dart";
import "package:shop/utils/translate.dart";

class ProductInfoScreen extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductInfoScreen({
    Key? key,
    required this.productEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    t(context)!.products_details_label,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding,
                  ),
                  child: Column(
                    children: [
                      MarkdownBody(
                        data: productEntity.productDetails,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
