import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:zwm_app/screens.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.scale,
          settings: settings,
        );
        break;

      case '/login':
        return PageTransition(
          child: Login(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/register':
        return PageTransition(
          child: Register(),
          type: PageTransitionType.downToUp,
          settings: settings,
        );
        break;

      case '/nav':
        return PageTransition(
          child: Nav(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/qr-code':
        var auth = settings.arguments;

        return PageTransition(
          child: QrCode(auth: auth),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/classification':
        return PageTransition(
          child: Classification(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/classification-result':
        ClassificationResult classificationResult = settings.arguments;

        return PageTransition(
          child: ClassificationResult(
            classifications: classificationResult.classifications,
            imagePath: classificationResult.imagePath,
          ),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/categories':
        return PageTransition(
          child: Categories(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/merchants-list':
        var category = settings.arguments;

        return PageTransition(
          child: MerchantsList(category: category),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/merchant-detail':
        var merchant = settings.arguments;

        return PageTransition(
          child: MerchantDetail(merchant: merchant),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/coupons-list':
        return PageTransition(
          child: CouponsList(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/coupon-detail':
        var offer = settings.arguments;

        return PageTransition(
          child: CouponDetail(offer: offer),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/promocode-detail':
        var promocode = settings.arguments;

        return PageTransition(
          child: PromocodeDetail(promocode: promocode),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/guide-categories':
        return PageTransition(
          child: GuideCategories(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/guide-list':
        var category = settings.arguments;

        return PageTransition(
          child: GuideList(category: category),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/guide-search':
        return PageTransition(
          child: GuideSearch(),
          type: PageTransitionType.downToUp,
          settings: settings,
        );
        break;

      case '/guide-detail':
        var guide = settings.arguments;

        return PageTransition(
          child: GuideDetail(guide: guide),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/product-search':
        return PageTransition(
          child: ProductSearch(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;
      case '/product-detail':
        ProductDetail productDetail = settings.arguments;

        return PageTransition(
          child: ProductDetail(
            product: productDetail.product,
            redirect: productDetail.redirect,
          ),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      default:
        return null;
    }
  }
}
