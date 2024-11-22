import 'package:stackfood_multivendor/common/widgets/menu_drawer_widget.dart';
import 'package:stackfood_multivendor/features/home/screens/mobile_all_restaurant.dart';
import 'package:stackfood_multivendor/features/home/screens/mobile_category_widget.dart';
import 'package:stackfood_multivendor/features/home/screens/mobile_popular_restaurant_widget.dart';
import 'package:stackfood_multivendor/features/home/screens/petfood_and_masala_particle_view.dart';
import 'package:stackfood_multivendor/features/home/widgets/all_restaurant_filter_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/mobile_view_particle/cooked_particle_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/mobile_view_particle/uncooked_particle_view.dart';
import 'package:stackfood_multivendor/features/product/controllers/campaign_controller.dart';
import 'package:stackfood_multivendor/features/home/controllers/home_controller.dart';
import 'package:stackfood_multivendor/features/home/screens/web_home_screen.dart';
import 'package:stackfood_multivendor/features/home/widgets/all_restaurants_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/bad_weather_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/banner_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/best_review_item_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/enjoy_off_banner_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/popular_foods_nearby_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/popular_restaurants_view_widget.dart';
import 'package:stackfood_multivendor/features/home/screens/theme1_home_screen.dart';
import 'package:stackfood_multivendor/features/home/widgets/what_on_your_mind_view_widget.dart';
import 'package:stackfood_multivendor/features/language/controllers/localization_controller.dart';
import 'package:stackfood_multivendor/features/order/controllers/order_controller.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/features/notification/controllers/notification_controller.dart';
import 'package:stackfood_multivendor/features/profile/controllers/profile_controller.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/splash/domain/models/config_model.dart';
import 'package:stackfood_multivendor/features/address/controllers/address_controller.dart';
import 'package:stackfood_multivendor/features/auth/controllers/auth_controller.dart';
import 'package:stackfood_multivendor/features/category/controllers/category_controller.dart';
import 'package:stackfood_multivendor/features/cuisine/controllers/cuisine_controller.dart';
import 'package:stackfood_multivendor/features/product/controllers/product_controller.dart';
import 'package:stackfood_multivendor/features/review/controllers/review_controller.dart';
import 'package:stackfood_multivendor/helper/responsive.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/footer_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/web/cooked_and_uncooked_view_widget.dart';
import '../widgets/web/web_banner_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  static Future<void> loadData(bool reload) async {
    Get.find<HomeController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(reload);
    Get.find<CuisineController>().getCuisineList();
    Get.find<CategoryController>().getFilCategoryList("1");
    Get.find<CategoryController>().getFilUncookedCategoryList("2");
    if(Get.find<SplashController>().configModel!.popularRestaurant == 1) {
      Get.find<RestaurantController>().getPopularRestaurantList(reload, 'all', false);
    }
    Get.find<CampaignController>().getItemCampaignList(reload);
    if(Get.find<SplashController>().configModel!.popularFood == 1) {
      Get.find<ProductController>().getPopularProductList(reload, 'all', false);
    }
    if(Get.find<SplashController>().configModel!.newRestaurant == 1) {
      print('APi Check getLatestRestaurantList');
      Get.find<RestaurantController>().getLatestRestaurantList(reload, 'all', false);
    }
    if(Get.find<SplashController>().configModel!.mostReviewedFoods == 1) {
      Get.find<ReviewController>().getReviewedProductList(reload, 'all', false);
    }
    Get.find<RestaurantController>().getRestaurantList(1, reload);
    Get.find<CategoryController>().getAllProductList(1, reload,'');

    if(Get.find<AuthController>().isLoggedIn()) {
      Get.find<RestaurantController>().getRecentlyViewedRestaurantList(reload, 'all', false);
      Get.find<RestaurantController>().getOrderAgainRestaurantList(reload);
      Get.find<ProfileController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<OrderController>().getRunningOrders(1, notify: false);
      Get.find<AddressController>().getAddressList();
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController _scrollController = ScrollController();
  final ConfigModel? _configModel = Get.find<SplashController>().configModel;
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    _isLogin = Get.find<AuthController>().isLoggedIn();
    HomeScreen.loadData(false);

  }


  @override
  Widget build(BuildContext context) {

    double scrollPoint = 0.0;

    return GetBuilder<LocalizationController>(builder: (localizationController) {
      return Scaffold(
        appBar:/* Responsive.isLargeMobile(context)  ? null:const*/ WebMenuBar() ,
        endDrawer: const MenuDrawerWidget(), endDrawerEnableOpenDragGesture: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          top: (Get.find<SplashController>().configModel!.theme == 2),
          child: RefreshIndicator(
            onRefresh: () async {
              await Get.find<HomeController>().getBannerList(true);
              await Get.find<CategoryController>().getCategoryList(true);
              await Get.find<CuisineController>().getCuisineList();
              Get.find<CategoryController>().getFilCategoryList("1");
              Get.find<CategoryController>().getFilUncookedCategoryList("2");
              await Get.find<RestaurantController>().getPopularRestaurantList(true, 'all', false);
              await Get.find<CampaignController>().getItemCampaignList(true);
              await Get.find<ProductController>().getPopularProductList(true, 'all', false);
              await Get.find<RestaurantController>().getLatestRestaurantList(true, 'all', false);
              await Get.find<ReviewController>().getReviewedProductList(true, 'all', false);
              await Get.find<RestaurantController>().getRestaurantList(1, true);
              if(Get.find<AuthController>().isLoggedIn()) {
                await Get.find<ProfileController>().getUserInfo();
                await Get.find<NotificationController>().getNotificationList(true);
                await Get.find<RestaurantController>().getRecentlyViewedRestaurantList(true, 'all', false);
                await Get.find<RestaurantController>().getOrderAgainRestaurantList(true);


              }
            },
            child: ResponsiveHelper.isDesktop(context) ? WebHomeScreen(
              scrollController: _scrollController,
            ) : (Get.find<SplashController>().configModel!.theme == 2) ? Theme1HomeScreen(
              scrollController: _scrollController,
            ) : CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Center(child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ResponsiveHelper.isMobile(context) ?
                      BannerViewWidget() :
                      CarouselBannerWidget(),
                      MobileWhatOnYourMindViewWidget(),
                      const CookedAndUnCookedView(),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Image.asset(Images.uncookedPromotionalBanner),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      const UNCookedParticleViewWidget(isPopular: false,),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Image.asset(Images.cookedPromotionalBanner),
                      const CookedParticleViewWidget(isPopular: false,),
                      // const PetFoodAndMasalaParticle(),
                      _configModel!.mostReviewedFoods == 1 ?   const BestReviewItemViewWidget(isPopular: false) : const SizedBox(),
                      _configModel.popularRestaurant == 1 ? const MobilePopularRestaurantsViewWidget() : const SizedBox(),
                      _configModel.popularFood == 1 ? const PopularFoodNearbyViewWidget() : const SizedBox(),
                      const PromotionalBannerViewWidget(),

                    ]),
                  )),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                    height: 50,
                    child:  const AllRestaurantFilterWidget(),
                  ),
                ),


                SliverToBoxAdapter(child: Center(child: FooterViewWidget(
                  child: Padding(
                    padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : const EdgeInsets.only(bottom: Dimensions.paddingSizeOverLarge),
                    child: MobileAllRestaurantsWidget(scrollController: _scrollController),
                  ),
                ))),

                // SliverToBoxAdapter(child: Center(child: FooterViewWidget(child: Padding(
                //     padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : const EdgeInsets.only(bottom: Dimensions.paddingSizeOverLarge),
                //     child: Column(
                //       children: [
                //         const SizedBox(height: Dimensions.paddingSizeDefault,),
                //         Text("All Food Items", style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).primaryColor)),
                //         const SizedBox(height: Dimensions.paddingSizeDefault,),
                //         AllRestaurantsWidget(scrollController: _scrollController),
                //       ],
                //     ),
                //   ),),),),

              ],
            ),
          ),
        ),
      );
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;

  SliverDelegate({required this.child, this.height = 50});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
