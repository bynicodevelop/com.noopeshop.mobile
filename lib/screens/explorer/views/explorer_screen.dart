import "package:flutter/material.dart";
import "package:shop/components/network_image_with_loader.dart";
import "package:shop/utils/assets_network.dart";

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              NetworkImageWithLoader(
                networkImage("13234522-cf3d-4b1b-850d-1d4a45b227fd"),
                radius: 0,
              ),
            ],
          ),
          Stack(
            children: [
              NetworkImageWithLoader(
                networkImage("61ff33a2-9ad3-4535-ad2d-3971e324cc77"),
                radius: 0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
