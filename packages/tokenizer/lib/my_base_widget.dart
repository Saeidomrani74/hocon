part of tokenizer;

class MyBaseWidget extends StatelessWidget {
  final Widget mobileChild;
  final Widget? tabletChild;
  final Widget? desktopChild;
  final PlatformAppBar? platformAppBar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Key? scaffoldKey;
  final Color? backgroundColor;
  final bool hasSafeArea;
  final bool hasScrollView;

  const MyBaseWidget({
    Key? key,
    required this.mobileChild,
    this.tabletChild,
    this.desktopChild,
    this.platformAppBar,
    this.bottomNavigationBar,
    this.drawer,
    this.scaffoldKey,
    this.backgroundColor,
    this.hasSafeArea = false,
    this.hasScrollView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasSafeArea

        /// This [GestureDetector] is for closing soft keyboard when touching anywhere
        /// of the device. specially in IOS
        ? GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: PlatformScaffold(
                scaffoldKey: scaffoldKey,
                backgroundColor: backgroundColor,
                appBar: platformAppBar,
                drawer: drawer,
                body: hasScrollView
                    ? _buildResponsive()
                    : _buildScrollableResponsive(),
                bottomNavigationBar: bottomNavigationBar,
              ),
            ),
          )

        /// This [GestureDetector] is for closing soft keyboard when touching anywhere
        /// of the device. specially in IOS
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: PlatformScaffold(
              scaffoldKey: scaffoldKey,
              backgroundColor: backgroundColor,
              appBar: platformAppBar,
              drawer: drawer,
              body: hasScrollView
                  ? _buildResponsive()
                  : _buildScrollableResponsive(),
              bottomNavigationBar: bottomNavigationBar,
            ),
          );
  }

  Widget _buildScrollableResponsive() {
    return MyResponsive(
      mobile: mobileChild,
      tablet: tabletChild ?? mobileChild,
      desktop: desktopChild ?? mobileChild,
    );
  }

  Widget _buildResponsive() {
    return SingleChildScrollView(
      child: MyResponsive(
        mobile: mobileChild,
        tablet: tabletChild ?? mobileChild,
        desktop: desktopChild ?? mobileChild,
      ),
    );
  }
}

class MyResponsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const MyResponsive({
    Key? key,
    @required this.mobile,
    @required this.tablet,
    @required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      /// If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop ?? Container();
        }

        /// If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet ?? Container();
        }

        /// Or less then that we called it mobile
        else {
          return mobile ?? Container();
        }
      },
    );
  }
}
