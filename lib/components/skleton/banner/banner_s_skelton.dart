import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../skelton.dart';

class BannerSSkelton extends StatelessWidget {
  const BannerSSkelton({
    Key? key,
    this.isShowCircle = false,
  }) : super(key: key);

  final bool isShowCircle;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.56,
      child: Stack(
        children: [
          const Skeleton(),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Skeleton(
                        width: 160,
                        height: 24,
                      ),
                      SizedBox(height: defaultPadding / 2),
                      Skeleton(
                        width: 100,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                if (isShowCircle) const CircleSkeleton(size: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
