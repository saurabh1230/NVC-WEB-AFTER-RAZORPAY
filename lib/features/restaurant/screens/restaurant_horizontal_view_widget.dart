// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
// import 'package:stackfood_multivendor/common/widgets/custom_ink_well_widget.dart';
// import 'package:stackfood_multivendor/common/widgets/custom_snackbar_widget.dart';
// import 'package:stackfood_multivendor/common/widgets/hover_widgets/hover_zoom_widget.dart';
// import 'package:stackfood_multivendor/common/widgets/particular_category_view_widget.dart';
// import 'package:stackfood_multivendor/common/widgets/product_view_widget.dart';
// import 'package:stackfood_multivendor/features/auth/controllers/auth_controller.dart';
// import 'package:stackfood_multivendor/features/category/controllers/category_controller.dart';
// import 'package:stackfood_multivendor/features/favourite/controllers/favourite_controller.dart';
// import 'package:stackfood_multivendor/features/home/widgets/arrow_icon_button_widget.dart';
// import 'package:stackfood_multivendor/features/home/widgets/icon_with_text_row_widget.dart';
// import 'package:stackfood_multivendor/features/home/widgets/item_card_widget.dart';
// import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
// import 'package:stackfood_multivendor/features/restaurant/screens/restaurant_screen.dart';
// import 'package:stackfood_multivendor/features/restaurant/screens/restaurant_screen_web.dart';
// import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
// import 'package:stackfood_multivendor/helper/route_helper.dart';
// import 'package:stackfood_multivendor/util/images.dart';
//
// import '../../../common/models/product_model.dart';
// import '../../../common/models/restaurant_model.dart';
// import '../../../common/widgets/home_category_product_view.dart';
// import '../../../helper/responsive_helper.dart';
// import '../../../util/dimensions.dart';
// import '../../../util/styles.dart';
// import '../../language/controllers/localization_controller.dart';
//
// class RestaurantViewHorizontal extends StatelessWidget {
//   final List<Restaurant?>? restaurants;
//   final bool isAll;
//
//   const RestaurantViewHorizontal({super.key, this.restaurants,  this.isAll = false});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isMobile(context)  ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeExtraLarge,
//           horizontal:ResponsiveHelper.isMobile(context)  ? Dimensions.paddingSizeDefault : 0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: Dimensions.paddingSizeDefault,),
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal:ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0),
//             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Popular Fish Items Nearby", style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Colors.black.withOpacity(0.90))),
//                     // Text("Farm Fresh Meat At Your Door", style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Colors.black.withOpacity(0.80))),
//
//                   ],
//                 ),
//                 // const Spacer(),
//                 // ArrowIconButtonWidget(
//                 //   onTap: () => Get.toNamed(
//                 //       RouteHelper.getCategoryProductRoute(
//                 //         14,
//                 //         "Fish",
//                 //       )),
//                 // ),
//               ],
//             ),
//           ),
//           const SizedBox(height: Dimensions.paddingSizeDefault,),
//           // ParticularCategoryViewWidget(
//           //   isRestaurant: false,
//           //   products: products,
//           //   restaurants: null,
//           //   noDataText: 'no_category_food_found'.tr, categoryBanner: widget.categoryBanner,
//           // ),
//           restaurants != null ? restaurants!.isNotEmpty ? SizedBox(
//             height: ResponsiveHelper.isMobile(context) ? 265 : 280,
//             child: ListView.builder(
//               itemCount: isAll ? restaurants!.length: restaurants!.length > 8 ? 8 : restaurants!.length ,
//               // itemCount: products!.length,
//               padding: EdgeInsets.only(right: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0),
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(left: (ResponsiveHelper.isDesktop(context) && index == 0 && Get.find<LocalizationController>().isLtr) ? 0 : Dimensions.paddingSizeDefault),
//                   child:   restaurantView(context, restaurants![index]!),
//                 );
//               },
//             ),
//           ) :  Center(child: Padding(
//               padding: const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
//               child: Text('no_restaurant_available'.tr, style: robotoMedium)
//           ) ) :
//            Center(child: Padding(
//               padding:  EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
//               child: Text('no_restaurant_available'.tr, style: robotoMedium)
//           ) ),
//         ],
//       ),
//     );
//   }
//   Widget restaurantView(BuildContext context, Restaurant restaurant) {
//     bool isAvailable = restaurant.open == 1 && restaurant.active!;
//     return HoverZoom(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//         ),
//         child: CustomInkWellWidget(
//           onTap: () {
//             if(restaurant.restaurantStatus == 1){
//               ResponsiveHelper.isMobile(context) ? Get.toNamed(RouteHelper.getRestaurantRoute(restaurant.id), arguments: RestaurantScreen(restaurant: restaurant)):
//               Get.toNamed(RouteHelper.getRestaurantWebRoute(restaurant.id), arguments: RestaurantScreenWeb(restaurant: restaurant));
//
//             }else if(restaurant.restaurantStatus == 0){
//               showCustomSnackBar('restaurant_is_not_available'.tr);
//             }
//           },
//           radius: Dimensions.radiusDefault,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
//                   child: CustomImageWidget(
//                     image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantCoverPhotoUrl}'
//                         '/${restaurant.coverPhoto}',
//                     fit: BoxFit.cover, height: 93, width: double.infinity,
//                   ),
//                 ),
//               ),
//
//               !isAvailable ? Positioned(top: 10, left: 10, child: Container(
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.error.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(Dimensions.radiusLarge)
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: Dimensions.fontSizeExtraLarge, vertical: Dimensions.paddingSizeExtraSmall),
//                 child: Row(children: [
//                   Icon(Icons.access_time, size: 12, color: Theme.of(context).cardColor),
//                   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
//
//                   Text('closed_now'.tr, style: robotoMedium.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall)),
//                 ]),
//               )) : const SizedBox(),
//
//               Positioned(
//                 top: 60, left: 10, right: 0,
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(2),
//                       height: 70, width: 70,
//                       decoration:  BoxDecoration(
//                         color: Theme.of(context).cardColor,
//                         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                         child: CustomImageWidget(
//                           image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantImageUrl}'
//                               '/${restaurant.logo}',
//                           fit: BoxFit.cover, height: 70, width: 70,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: Dimensions.paddingSizeSmall),
//
//                     Text(
//                       restaurant.name!,
//                       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
//                       maxLines: 1, overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//
//                     Text(
//                       restaurant.address!,
//                       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
//                       maxLines: 1, overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconWithTextRowWidget(
//                           icon: Icons.star_border, text: restaurant.avgRating.toString(),
//                           style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                         ),
//
//                         restaurant.freeDelivery! ? Padding(
//                           padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
//                           child: ImageWithTextRowWidget(
//                             widget: Image.asset(Images.deliveryIcon, height: 20, width: 20),
//                             text: 'free'.tr,
//                             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                           ),
//                         ) : const SizedBox(),
//                         const SizedBox(width: Dimensions.paddingSizeDefault),
//
//                         IconWithTextRowWidget(
//                           icon: Icons.access_time_outlined, text: '${restaurant.deliveryTime}',
//                           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                         ),
//
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               Positioned(
//                 top: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,
//                 child: GetBuilder<FavouriteController>(builder: (favouriteController) {
//                   bool isWished = favouriteController.wishRestIdList.contains(restaurant.id);
//                   return InkWell(
//                     onTap: () {
//                       if(Get.find<AuthController>().isLoggedIn()) {
//                         isWished ? favouriteController.removeFromFavouriteList(restaurant.id, true)
//                             : favouriteController.addToFavouriteList(null, restaurant, true);
//                       }else {
//                         showCustomSnackBar('you_are_not_logged_in'.tr);
//                       }
//                     },
//                     child: Icon(
//                       Icons.favorite,  size: 20,
//                       color: isWished ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4),
//                     ),
//                   );
//                 }),
//               ),
//
//               Positioned(
//                 top: 73, right: 5,
//                 child: Container(
//                   height: 23,
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
//                     color: Theme.of(context).cardColor,
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
//                   child: Center(
//                     child: Text('${Get.find<RestaurantController>().getRestaurantDistance(
//                       LatLng(double.parse(restaurant.latitude!), double.parse(restaurant.longitude!)),
//                     ).toStringAsFixed(2)} ${'km'.tr}',
//                         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:stackfood_multivendor/common/models/product_model.dart';
import 'package:stackfood_multivendor/common/widgets/custom_ink_well_widget.dart';
import 'package:stackfood_multivendor/common/widgets/hover_widgets/hover_zoom_widget.dart';
import 'package:stackfood_multivendor/common/widgets/not_available_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/arrow_icon_button_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/icon_with_text_row_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/what_on_your_mind_view_widget.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/features/restaurant/screens/RestaurantProductScreenWeb.dart';

import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/common/models/restaurant_model.dart';
import 'package:stackfood_multivendor/features/auth/controllers/auth_controller.dart';
import 'package:stackfood_multivendor/features/favourite/controllers/favourite_controller.dart';
import 'package:stackfood_multivendor/features/splash/controllers/theme_controller.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_image_widget.dart';
import 'package:stackfood_multivendor/common/widgets/custom_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer_animation/shimmer_animation.dart';



class RestaurantsViewHorizontalWidget extends StatelessWidget {
  final List<Restaurant?>? restaurants;
  final bool isCooked;
  final List<Product>? products;
  final String? categoryName;
  final String? categoryId;
  // final bool? isWebRestaurant;
  // final bool isRestaurant;
  // final bool showTheme1Restaurant;
  const RestaurantsViewHorizontalWidget({super.key, this.restaurants,  this.isCooked = false, this.products,required this.categoryName,required this.categoryId, });

  @override
  Widget build(BuildContext context) {
    // bool isAvailable = restaurants.open == 1 && restaurant.active!;
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeDefault : 0.0),
      child: Column(
        children: [
          SizedBox(
            // height: 172,
            child:
            restaurants != null
                ? restaurants!.isNotEmpty
                ?
            GridView.builder(
              itemCount: restaurants!.length,
              physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeLarge,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeDefault,
                  //childAspectRatio: ResponsiveHelper.isDesktop(context) && !isWebRestaurant! ? 3 : isWebRestaurant! ? 1.5 : showTheme1Restaurant ? 1.9 : 3.3,
                  mainAxisExtent: ResponsiveHelper.isDesktop(context)  ? 300 : 300,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 4,
                ),
                // physics: isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildContainer(context, restaurants![index]!,categoryName!);
              },
            ) :
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
                child: Text('no_restaurant_available'.tr, style: robotoMedium),
              ),
            ) :
            const PopularRestaurantShimmer(),
          ),
        ],
      ),
    );
  }

  HoverZoom buildContainer(BuildContext context, Restaurant restaurant, String categoryName) {
    bool isAvailable = /*restaurant.open == 1 &&*/ restaurant.active!;
    print(' buildContainer ${restaurant.active!}');
    return HoverZoom(
      child: Container(
        // height: 172, width: 253,
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: InkWell(
          onTap: () {
            if (restaurant.restaurantStatus == 1) {
              String slug = restaurant.name!.toLowerCase().replaceAll(' ', '-'); // Generate slug from restaurant name
              int id = restaurant.id!; // Get restaurant id

              print('check meta ');
              print(restaurant.meta_title.toString());
              print(restaurant.meta_description.toString());
              updateMetaTitleAndDescription(restaurant.meta_title.toString(), restaurant.meta_description.toString());
              // Navigate using the constructed route with slug and id
              Get.toNamed(
                RouteHelper.getRestaurantProductsRoute(slug, id), // Pass slug and id as arguments
                arguments: RestaurantProductScreenWeb(
                  restaurant: restaurant,
                  product: null,
                  categoryName: '',
                  categoryID: '',
                ),
              );
            } else if (restaurant.restaurantStatus == 0) {
              showCustomSnackBar('restaurant_is_not_available'.tr);
            }
          },

          // onTap: () {
          //   onTap: () {
          //     if (restaurant.restaurantStatus == 1) {
          //       String slug = restaurant.name!.toLowerCase().replaceAll(' ', '-'); // Create slug from restaurant name
          //       int id = restaurant.id!;
          //       Get.toNamed(
          //         RouteHelper.getRestaurantProductsRoute(id, slug),
          //         arguments: RestaurantProductScreenWeb(
          //           restaurant: restaurant,
          //           product: null,
          //           categoryName: '',
          //           categoryID: '',
          //         ),
          //       );
          //     } else if (restaurant.restaurantStatus == 0) {
          //       showCustomSnackBar('restaurant_is_not_available'.tr);
          //     }
          //   };
          //
          // },
          // onTap: () =>
          //     Get.toNamed(RouteHelper.getRestaurantProductsRoute(restaurant.id),
          //   arguments: RestaurantProductScreenWeb(restaurant: restaurant,
          //     product: null, categoryName: categoryName, categoryID: categoryId!,),
          //  ),
          radius: Dimensions.radiusDefault,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 160,
                    width: Get.size.width,
                    clipBehavior: Clip.hardEdge,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                    child: CustomImageWidget(
                      placeholder: Images.placeholder,
                      image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantImageUrl}'
                          '/${restaurant.logo}',
                      fit: BoxFit.cover, /*height: 58, width: 58,*/
                    ),
                  ),
                  Positioned(
                    top: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,
                    child: GetBuilder<FavouriteController>(builder: (favouriteController) {
                      bool isWished = favouriteController.wishRestIdList.contains(restaurant.id);
                      return InkWell(
                        onTap: () {
                          if(Get.find<AuthController>().isLoggedIn()) {
                            isWished ? favouriteController.removeFromFavouriteList(restaurant.id, true)
                                : favouriteController.addToFavouriteList(null, restaurant, true);
                          } else {
                            showCustomSnackBar('you_are_not_logged_in'.tr);
                          }
                        },
                        child: Icon(isWished ? Icons.favorite : Icons.favorite_border,
                            color: isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, size: 20),
                      );
                    }
                    ),
                  ),
                  isAvailable ? const SizedBox() : const NotAvailableWidget(isRestaurant: true),
                ],
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Row(
                    children: [
                      Expanded(
                        child: Text(restaurant.name!,
                            overflow: TextOverflow.ellipsis, maxLines: 1, style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Text( restaurant.address!, overflow: TextOverflow.ellipsis, maxLines: 2,
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Row(
                    children: [
                      IconWithTextRowWidget(
                        icon: Icons.stars_sharp,
                        text: restaurant.avgRating!.toStringAsFixed(1),
                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                      Container(height: 6,width: 6,decoration:  BoxDecoration(
                          color: Colors.black.withOpacity(0.60),
                          shape: BoxShape.circle),),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                      IconWithTextRowWidget(
                        icon: Icons.access_time_outlined,
                        text: '${restaurant.deliveryTime}',
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                      // const Spacer(),
                      // Row(children: [
                      //   Text('Starting From', style: robotoRegular.copyWith(
                      //     fontSize: Dimensions.fontSizeExtraSmall , color: Theme.of(context).disabledColor,
                      //   )),
                      //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      //   Text(
                      //     PriceConverter.convertPrice(restaurant.minimumOrder), textDirection: TextDirection.ltr,
                      //     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                      //   ),
                      // ]),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),


      ),
    );
  }
}


class PopularRestaurantShimmer extends StatelessWidget {
  const PopularRestaurantShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeDefault,
          //childAspectRatio: ResponsiveHelper.isDesktop(context) && !isWebRestaurant! ? 3 : isWebRestaurant! ? 1.5 : showTheme1Restaurant ? 1.9 : 3.3,
          mainAxisExtent: ResponsiveHelper.isDesktop(context)  ? 300 : 300,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1  : 4,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Shimmer(
            duration: const Duration(seconds: 2),
            enabled: true,
            child: Container(
              // height: 172, width: 253,
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 160, width: Get.size.width,
                        clipBehavior: Clip.hardEdge,
                        decoration:  BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Container(height: 6,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Container(height: 6,width: 180,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),),
                      const SizedBox(height: Dimensions.paddingSizeDefault,),
                      Container(height: 6,width: 120,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),)
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

