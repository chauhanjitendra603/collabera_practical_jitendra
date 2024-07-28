import 'package:collabera_test_jitendra/views/product_list_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../splash_screen.dart';
import 'router_constants.dart';

class NavRouter {
  static final generateRoute = [
    GetPage(
      name: splashscreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: productlistscreen,
      page: () => ProductListScreen(),
    ),
  ];
}
