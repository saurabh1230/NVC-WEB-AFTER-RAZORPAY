import 'package:flutter/cupertino.dart';
import 'package:stackfood_multivendor/features/category/controllers/category_controller.dart';
import 'package:stackfood_multivendor/features/home/widgets/filter_view_widget.dart';
import 'package:stackfood_multivendor/features/home/widgets/restaurant_filter_button_widget.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AllRestaurantFilterWidget extends StatelessWidget {
  const AllRestaurantFilterWidget({super.key, });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(
        builder: (restaurantController) {
          return Center(
            child:  Container(
              width: Dimensions.webMaxWidth,
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('All Restaurants', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Colors.black.withOpacity(0.80))),
                    Row(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                          child: Text(
                            '${restaurantController.restaurantModel != null ? restaurantController.restaurantModel!.totalSize : 0} ${'Available'}',
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: robotoMedium.copyWith(color: Colors.black.withOpacity(0.40), fontSize: Dimensions.fontSizeSmall),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const FilterViewWidget(),

                      ],
                    ),


                    // Flexible(
                    //   child: Text(
                    //     '${restaurantController.productModel != null ? restaurantController.productModel!.totalSize : 0} ${'Food Items Available'}',
                    //     maxLines: 1, overflow: TextOverflow.ellipsis,
                    //     style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                    //   ),
                    // ),
                  ]),
                  // filter(context,restaurantController)
                ],
              ),
            ),
          );
        }
    );
  }

  Widget filter(BuildContext context, RestaurantController restaurantController) {
    return SizedBox(
      height:  30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children:  [
          // Align(alignment: Alignment.centerLeft,
          //   child: Text(
          //     '${restaurantController.restaurantModel != null ? restaurantController.restaurantModel!.totalSize : 0} ${'Available'}',
          //     maxLines: 1, overflow: TextOverflow.ellipsis,
          //     style: robotoRegular.copyWith(color: Colors.black.withOpacity(0.70), fontSize: Dimensions.fontSizeSmall),
          //   ),
          // ),
          // // FilterViewWidget(),
          // const SizedBox(width: Dimensions.paddingSizeSmall),
          /*    RestaurantsFilterButtonWidget(
            buttonText: 'Cooked',
            onTap: () {},
            // isSelected: restaurantController.topRated == 1,
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          RestaurantsFilterButtonWidget(
            buttonText: 'Uncooked',
            onTap: () {},
            // isSelected: restaurantController.discount == 1,
          ),*/

          //  RestaurantsFilterButtonWidget(
          //   buttonText: 'top_rated'.tr,
          //   onTap: (){
          //     Get.find<CategoryController>().getCategoryProductList(
          //       Get.find<CategoryController>().subCategoryIndex == 0 ? "12"
          //           : Get.find<CategoryController>().subCategoryList![Get.find<CategoryController>().subCategoryIndex].id.toString(),
          //       Get.find<CategoryController>().offset+1, Get.find<CategoryController>().type, false,
          //     );
          //   },
          //   // isSelected: restaurantController.topRated == 1,
          // ),
          RestaurantsFilterButtonWidget(
            buttonText: "Top Rated",
            onTap: () => restaurantController.setTopRated(),
            isSelected: restaurantController.topRated == 1,
          ),
          RestaurantsFilterButtonWidget(
            buttonText: "Cooked",
            onTap: () => restaurantController.setRestaurantType('1'),
            isSelected: restaurantController.cooked == 1,
          ),
          RestaurantsFilterButtonWidget(
            buttonText: "Uncooked",
            onTap: () => restaurantController.setRestaurantType('2'),
            isSelected: restaurantController.uncooked == 1,
          ),
          // RestaurantsFilterButtonWidget(
          //   buttonText: "Top Rated",
          //   onTap: () => restaurantController.setTopRated(),
          //   isSelected: restaurantController.topRated == 1,
          // ),

          // const SizedBox(width: Dimensions.paddingSizeSmall),
          //
          // RestaurantsFilterButtonWidget(
          //   buttonText: 'discounted'.tr,
          //   onTap: () => restaurantController.setDiscount(),
          //   isSelected: restaurantController.discount == 1,
          // ),
          // const SizedBox(width: Dimensions.paddingSizeSmall),
          //
          // RestaurantsFilterButtonWidget(
          //   buttonText: 'veg'.tr,
          //   onTap: () => restaurantController.setVeg(),
          //   isSelected: restaurantController.veg == 1,
          // ),
          // const SizedBox(width: Dimensions.paddingSizeSmall),
          //
          // RestaurantsFilterButtonWidget(
          //   buttonText: 'non_veg'.tr,
          //   onTap: () => restaurantController.setNonVeg(),
          //   isSelected: restaurantController.nonVeg == 1,
          // ),
          // const SizedBox(width: Dimensions.paddingSizeSmall),

          // ResponsiveHelper.isDesktop(context) ? const FilterViewWidget() : const SizedBox(),

        ],
      ),
    );
  }
}
