import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:shop/entities/page_entity.dart";
import "package:shop/inputs/page_input.dart";
import "package:shop/services/pages/load_page/load_page_bloc.dart";
import "package:shop/utils/translate.dart";

import "../../../constants.dart";

class ProductReturnsScreen extends StatelessWidget {
  const ProductReturnsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    t(context)!.products_return_label,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                defaultPadding,
              ),
              child: BlocBuilder<LoadPageBloc, LoadPageState>(
                bloc: context.read<LoadPageBloc>()
                  ..add(const OnLoadPageEvent(
                    PageInput(
                      slug: "returns",
                    ),
                  )),
                builder: (context, state) {
                  if (state is LoadPageFailureState) {
                    return const Text("Content not found");
                  }

                  if (state is! LoadPageLoadedState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final PageEntity pageEntity = state.page;

                  return MarkdownBody(
                    data: pageEntity.content,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
