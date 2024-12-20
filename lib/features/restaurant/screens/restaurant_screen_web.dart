
import 'package:stackfood_multivendor/features/cart/controllers/cart_controller.dart';
import 'package:stackfood_multivendor/features/coupon/controllers/coupon_controller.dart';
import 'package:stackfood_multivendor/features/home/widgets/arrow_icon_button_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/item_card_widget.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/common/models/restaurant_model.dart';
import 'package:stackfood_multivendor/features/category/controllers/category_controller.dart';
import 'package:stackfood_multivendor/helper/date_converter.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/bottom_cart_widget.dart';
import 'package:stackfood_multivendor/common/widgets/footer_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/menu_drawer_widget.dart';
import 'package:stackfood_multivendor/common/widgets/paginated_list_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/product_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/web_menu_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_image_widget.dart';
import '../../splash/controllers/splash_controller.dart';

class RestaurantScreenWeb extends StatefulWidget {
  final Restaurant? restaurant;
  // final String slug;
  const RestaurantScreenWeb({super.key, required this.restaurant, /*this.slug = ''*/});

  @override
  State<RestaurantScreenWeb> createState() => _RestaurantScreenWebState();
}

class _RestaurantScreenWebState extends State<RestaurantScreenWeb> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _initDataCall();
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  Future<void> _initDataCall() async {
    if(Get.find<RestaurantController>().isSearching) {
      Get.find<RestaurantController>().changeSearchStatus(isUpdate: false);
    }
    await Get.find<RestaurantController>().getRestaurantDetails(Restaurant(id: widget.restaurant!.id), /*slug: widget.slug*/);
    if(Get.find<CategoryController>().categoryList == null) {
      Get.find<CategoryController>().getCategoryList(true);
    }
    Get.find<CouponController>().getRestaurantCouponList(restaurantId: widget.restaurant!.id ?? Get.find<RestaurantController>().restaurant!.id!);
    Get.find<RestaurantController>().getRestaurantRecommendedItemList(widget.restaurant!.id ?? Get.find<RestaurantController>().restaurant!.id!, false);
    Get.find<RestaurantController>().getRestaurantProductList(widget.restaurant!.id ?? Get.find<RestaurantController>().restaurant!.id!, 1, 'all', false);
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    bool isAvailable = widget.restaurant!.open == 1 && widget.restaurant!.active!;
    return Scaffold(
        appBar: isDesktop ?  WebMenuBar() : null,
        endDrawer: const MenuDrawerWidget(), endDrawerEnableOpenDragGesture: false,
        backgroundColor: Theme.of(context).cardColor,
        body: GetBuilder<RestaurantController>(builder: (restController) {
          return GetBuilder<CategoryController>(builder: (categoryController) {
            Restaurant? restaurant;
            if(restController.restaurant != null && restController.restaurant!.name != null && categoryController.categoryList != null) {
              restaurant = restController.restaurant;
            }
            restController.setCategoryList();

            if ((restController.restaurant != null && restController.restaurant!.name != null && categoryController.categoryList != null)) {
              return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize100),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeDefault,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: ArrowIconButtonWidget(
                            isLeft: true,
                            paddingLeft: Dimensions.paddingSizeSmall,
                            onTap: () {
                              Get.toNamed(RouteHelper.getMainRoute(1.toString()));
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault,),
                        SizedBox(
                          width: Get.size.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                            child: CustomImageWidget(
                              height: 240,
                              fit: BoxFit.fitWidth, placeholder: Images.restaurantCover,
                              image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantCoverPhotoUrl}/${restaurant!.coverPhoto}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top:Dimensions.paddingSizeDefault,left: Dimensions.paddingSize100,right:  Dimensions.paddingSize100 ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // ClipRRect(
                            //   borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                            //   child: CustomImageWidget(
                            //     height: 90,width: 90,
                            //     fit: BoxFit.cover, placeholder: Images.restaurantCover,
                            //     image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantImageUrl}/${restaurant.logo}',
                            //   ),
                            // ),
                            const SizedBox(width: Dimensions.paddingSizeSmall,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name!, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).textTheme.bodyMedium!.color),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  restaurant.address!, style: robotoLight.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.60)),
                                  maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Divider(color: Theme.of(context).primaryColor,),
                        const SizedBox(height: Dimensions.paddingSizeDefault,),
                        Row(
                          children: [
                            Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverLarge),
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall,), ),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time,color: Theme.of(context).primaryColor,size: 20 ),
                                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                  Text(restaurant.deliveryTime!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
                                      ),
                                ],),),

                            const SizedBox(width: Dimensions.paddingSizeSmall,),
                            Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverLarge),
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall,)),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Theme.of(context).primaryColor,size: 20 ),
                                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                  !isAvailable ?
                                  Text('closed_now'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)) :
                                  Text('Opened', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)),
                                  // Text(restaurant.minimumShippingCharge.toString(), style: robotoLight.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColor)),

                                ],
                              ),
                            ),const SizedBox(width: Dimensions.paddingSizeSmall,),
                            Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverLarge),
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall,)),
                              child: Row(
                                children: [
                                  Icon(Icons.star,color: Theme.of(context).primaryColor,size: 20 ),
                                  const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                  Text('${restaurant.ratingCount} + ${'ratings'.tr}', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),),

                                ],
                              ),
                            ),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: Center(child: Container(
                  width: Dimensions.webMaxWidth,
                  color: Theme.of(context).cardColor,
                  child: Column(children: [
                    // isDesktop ? const SizedBox() : RestaurantDescriptionView(restaurant: restaurant),
                    restaurant.discount != null ? Container(
                      width: context.width,
                      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Theme.of(context).primaryColor),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          restaurant.discount!.discountType == 'percent' ? '${restaurant.discount!.discount}% ${'off'.tr}'
                              : '${PriceConverter.convertPrice(restaurant.discount!.discount)} ${'off'.tr}',
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).cardColor),
                        ),
                        Text(
                          restaurant.discount!.discountType == 'percent'
                              ? '${'enjoy'.tr} ${restaurant.discount!.discount}% ${'off_on_all_categories'.tr}'
                              : '${'enjoy'.tr} ${PriceConverter.convertPrice(restaurant.discount!.discount)}'
                              ' ${'off_on_all_categories'.tr}',
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                        ),
                        SizedBox(height: (restaurant.discount!.minPurchase != 0 || restaurant.discount!.maxDiscount != 0) ? 5 : 0),
                        restaurant.discount!.minPurchase != 0 ? Text(
                          '[ ${'minimum_purchase'.tr}: ${PriceConverter.convertPrice(restaurant.discount!.minPurchase)} ]',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                        ) : const SizedBox(),
                        restaurant.discount!.maxDiscount != 0 ? Text(
                          '[ ${'maximum_discount'.tr}: ${PriceConverter.convertPrice(restaurant.discount!.maxDiscount)} ]',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                        ) : const SizedBox(),
                        Text(
                          '[ ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(restaurant.discount!.startTime!)} '
                              '- ${DateConverter.convertTimeToTime(restaurant.discount!.endTime!)} ]',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).cardColor),
                        ),
                      ]),
                    ) : const SizedBox(),
                    SizedBox(height: (restaurant.announcementActive! && restaurant.announcementMessage != null) ? 0 : Dimensions.paddingSizeSmall),

                    ResponsiveHelper.isMobile(context) ? (restaurant.announcementActive! && restaurant.announcementMessage != null) ? Container(
                      decoration: const BoxDecoration(color: Colors.green),
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
                      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                        Image.asset(Images.announcement, height: 26, width: 26),
                        const SizedBox(width: Dimensions.paddingSizeSmall),

                        Flexible(child: Text(restaurant.announcementMessage ?? '',
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                        ),
                        ),
                      ]),
                    ) : const SizedBox() : const SizedBox(),

                    restController.recommendedProductModel != null && restController.recommendedProductModel!.products!.isNotEmpty ? Container(
                      color: Theme.of(context).primaryColor.withOpacity(0.10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Dimensions.paddingSizeLarge, left: Dimensions.paddingSizeLarge,
                              bottom: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeLarge,
                            ),
                            child: Row(children: [
                              Expanded(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text('popular_in_this_restaurant'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                  Text('here_is_what_you_might_like_to_test'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                                ]),
                              ),

                              ArrowIconButtonWidget(
                                onTap: () => Get.toNamed(RouteHelper.getPopularFoodRoute(false, fromIsRestaurantFood: true, restaurantId: widget.restaurant!.id ?? Get.find<RestaurantController>().restaurant!.id!)),
                              ),
                            ]),
                          ),

                          SizedBox(
                            height: 260, width: context.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: restController.recommendedProductModel!.products!.length,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraSmall, right: Dimensions.paddingSizeDefault),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                                  child: ItemCardWidget(
                                    product: restController.recommendedProductModel!.products![index],
                                    isBestItem: false,
                                    isPopularNearbyItem: false,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ) : const SizedBox(),
                  ]),
                ))),

                (restController.categoryList!.isNotEmpty) ? SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(height: 120, child: Center(child: Container(
                    width: Dimensions.webMaxWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: isDesktop ? [] : [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, top: Dimensions.paddingSizeSmall),
                        child: Row(children: [
                          Text('all_food_items'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                          const Expanded(child: SizedBox()),

                          isDesktop ?  Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                            height: 35,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).cardColor,
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.40)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                      hintText: 'search_for_products'.tr,
                                      hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), borderSide: BorderSide.none),
                                      filled: true, fillColor:Theme.of(context).cardColor,
                                      isDense: true,
                                      prefixIcon: InkWell(
                                        onTap: (){
                                          if(!restController.isSearching) {
                                            Get.find<RestaurantController>().getRestaurantSearchProductList(
                                              _searchController.text.trim(), Get.find<RestaurantController>().restaurant!.id.toString(), 1, restController.type,
                                            );
                                          } else {
                                            _searchController.text = '';
                                            restController.initSearchData();
                                            restController.changeSearchStatus();
                                          }
                                        },
                                        child: Icon(restController.isSearching ? Icons.clear : CupertinoIcons.search, color: Theme.of(context).primaryColor.withOpacity(0.50)),
                                      ),
                                    ),
                                    onSubmitted: (String? value) {
                                      if(value!.isNotEmpty) {
                                        restController.getRestaurantSearchProductList(
                                          _searchController.text.trim(), Get.find<RestaurantController>().restaurant!.id.toString(), 1, restController.type,
                                        );
                                      }
                                    } ,
                                    onChanged: (String? value) { } ,
                                  ),
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall),

                              ],
                            ),
                          ) : InkWell(
                            onTap: () async {
                              await Get.toNamed(RouteHelper.getSearchRestaurantProductRoute(restaurant!.id));
                              if(restController.isSearching) {
                                restController.changeSearchStatus();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                              ),
                              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                              child: Image.asset(Images.search, height: 25, width: 25, color: Theme.of(context).primaryColor, fit: BoxFit.cover),
                            ),
                          ),

                          // restController.type.isNotEmpty ? VegFilterWidget(
                          //   type: restController.type,
                          //   onSelected: (String type) {
                          //     restController.getRestaurantProductList(restController.restaurant!.id, 1, type, true);
                          //   },
                          // ) : const SizedBox(),

                        ]),
                      ),
                      const Divider(thickness: 0.2, height: 10),

                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: restController.categoryList!.length,
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => restController.setCategoryIndex(index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                                margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                  color: index == restController.categoryIndex ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text(
                                    restController.categoryList![index].name!,
                                    style: index == restController.categoryIndex
                                        ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
                                        : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ))),
                ) : const SliverToBoxAdapter(child: SizedBox()),

                SliverToBoxAdapter(child: FooterViewWidget(
                  child: Center(child: Container(
                    width: Dimensions.webMaxWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: PaginatedListViewWidget(
                      scrollController: scrollController,
                      onPaginate: (int? offset) {
                        if(restController.isSearching){
                          restController.getRestaurantSearchProductList(
                            restController.searchText, Get.find<RestaurantController>().restaurant!.id.toString(), offset!, restController.type,
                          );
                        } else {
                          restController.getRestaurantProductList(Get.find<RestaurantController>().restaurant!.id, offset!, restController.type, false);
                        }
                      },
                      totalSize: restController.isSearching
                          ? restController.restaurantSearchProductModel?.totalSize
                          : restController.restaurantProducts != null ? restController.foodPageSize : null,
                      offset: restController.isSearching
                          ? restController.restaurantSearchProductModel?.offset
                          : restController.restaurantProducts != null ? restController.foodPageOffset : null,
                      productView: ProductViewWidget(
                        isRestaurant: false, restaurants: null,
                        products: restController.isSearching
                            ? restController.restaurantSearchProductModel?.products
                            : restController.categoryList!.isNotEmpty ? restController.restaurantProducts : null,
                        inRestaurantPage: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall,
                          vertical: Dimensions.paddingSizeLarge,
                        ),
                      ),
                    ),
                  )),
                )),
              ],
            );
            } else {
              return const RestaurantWebShimmer();
            }
          });
        }),

        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
          return cartController.cartList.isNotEmpty && !isDesktop ? BottomCartWidget(restaurantId: cartController.cartList[0].product!.restaurantId!) : const SizedBox();
        })
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;

  SliverDelegate({required this.child, this.height = 100});

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

class RestaurantWebShimmer extends StatelessWidget {
  const RestaurantWebShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize100),
            child: Column(
              children: [
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                Align(
                  alignment: Alignment.topLeft,
                  child: ArrowIconButtonWidget(
                    isLeft: true,
                    paddingLeft: Dimensions.paddingSizeSmall,
                    onTap: () {
                      // Get.toNamed(RouteHelper.getMainRoute(1.toString()));
                    },
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                SizedBox(width: Get.size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                    child: CustomImageWidget(
                      height: 240,
                      fit: BoxFit.cover, placeholder: Images.restaurantCover,
                      image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantCoverPhotoUrl}/',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top:Dimensions.paddingSizeDefault,left: Dimensions.paddingSize100,right:  Dimensions.paddingSize100 ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ClipRRect(
                    //   borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                    //   child: CustomImageWidget(
                    //     height: 90,width: 90,
                    //     fit: BoxFit.cover, placeholder: Images.restaurantCover,
                    //     image: '${Get.find<SplashController>().configModel!.baseUrls!.restaurantImageUrl}/',
                    //   ),
                    // ),
                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize40),
                            child: Text(
                              'Restaurant Name', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.transparent),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall,),
                        Container(  decoration: BoxDecoration(color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize40),
                            child: Text(
                              "Restaurant Address", style: robotoLight.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.transparent),
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                Row(
                  children: [
                    Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverLarge),
                      decoration: BoxDecoration(color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall,), ),
                      child: const Row(
                        children: [
                          // Icon(Icons.access_time,color: Theme.of(context).primaryColor,size: 20 ),
                          SizedBox(width: Dimensions.paddingSizeLarge,),

                        ],),),

                    const SizedBox(width: Dimensions.paddingSizeSmall,),
                    Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverLarge),
                      decoration: BoxDecoration(color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall,)),
                      child: const Row(
                        children: [
                          // Icon(Icons.home,color: Theme.of(context).primaryColor,size: 20 ),
                          SizedBox(width: Dimensions.paddingSizeLarge,),

                          // Text(restaurant.minimumShippingCharge.toString(), style: robotoLight.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColor)),

                        ],
                      ),
                    ),const SizedBox(width: Dimensions.paddingSizeSmall,),
                    Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverLarge),
                      decoration: BoxDecoration(color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall,)),
                      child: const Row(
                        children: [
                          // Icon(Icons.star,color: Theme.of(context).primaryColor,size: 20 ),
                          SizedBox(width: Dimensions.paddingSizeLarge,),


                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: Dimensions.webMaxWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, top: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                        Container(
                            decoration: BoxDecoration(color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize40),
                              child: Text('all_food_items'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.transparent)),
                            )),
                        const Expanded(child: SizedBox()),
                        Container(
                            decoration: BoxDecoration(color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize40),
                              child: Text('all_food_items  ', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Colors.transparent)),
                            )),

                        // restController.type.isNotEmpty ? VegFilterWidget(
                        //   type: restController.type,
                        //   onSelected: (String type) {
                        //     restController.getRestaurantProductList(restController.restaurant!.id, 1, type, true);
                        //   },
                        // ) : const SizedBox(),

                      ]),
                    ),

                  ]),
                ),
                const Divider(thickness: 0.2, height: 10),



              ],
            ),
          ),
        ),


      ],
    );
  }
}
