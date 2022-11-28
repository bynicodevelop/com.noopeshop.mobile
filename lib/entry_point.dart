import "package:animations/animations.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:shop/constants.dart";
import "package:shop/route/screen_export.dart";
import "package:shop/screens/explorer/views/explorer_screen.dart";

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List _pages = const [
    HomeScreen(),
    // DiscoverScreen(),
    BookmarkScreen(),
    ExplorerScreen(),
    // EmptyCartScreen(), // if Cart is empty
    CartScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        color: color ??
            Theme.of(context).iconTheme.color!.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: _currentIndex == 2,
      extendBody: _currentIndex == 2,
      appBar: AppBar(
        // pinned: true,
        // floating: true,
        // snap: true,

        backgroundColor: _currentIndex != 2
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.transparent,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/logo/Shoplon.svg",
          color: Theme.of(context).iconTheme.color,
          height: 20,
          width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, searchScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Search.svg",
              height: 24,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, notificationsScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              height: 24,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
      // body: _pages[_currentIndex],
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            child: child,
            animation: animation,
            secondaryAnimation: secondAnimation,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          top: _currentIndex != 2 ? defaultPadding / 2 : 0,
        ),
        color: _currentIndex != 2
            ? Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : const Color(0xFF101015)
            : Colors.transparent,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: _currentIndex != 2
              ? Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF101015)
              : Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Shop.svg"),
              activeIcon: svgIcon(
                "assets/icons/Shop.svg",
                color: primaryColor,
              ),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bookmark.svg"),
              activeIcon: svgIcon(
                "assets/icons/Bookmark.svg",
                color: primaryColor,
              ),
              label: "Bookmark",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Category.svg"),
              activeIcon: svgIcon(
                "assets/icons/Category.svg",
                color: primaryColor,
              ),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bag.svg"),
              activeIcon: svgIcon(
                "assets/icons/Bag.svg",
                color: primaryColor,
              ),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Profile.svg"),
              activeIcon: svgIcon(
                "assets/icons/Profile.svg",
                color: primaryColor,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
