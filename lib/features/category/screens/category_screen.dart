
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/screens/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    Provider.of<CategoryController>(context,listen: false).clear();
    // Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(false, Provider.of<CategoryController>(context, listen: false).categoryList[0].id.toString(), context,1,true,'','','','');
    super.initState();
  }
  TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('CATEGORY', context),
      // reset: Row(children: [
      //   const SizedBox(width: 10,),
      //
      //   InkWell(
      //       onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen(showBackButton: true,))),
      //       child: Image.asset(Images.bag2, width: 25, height: 25,color: Theme.of(context).iconTheme.color)),
      //
      //   const SizedBox(width: 15,),
      //   Stack(
      //     children: [
      //       InkWell(
      //           onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
      //           child:Image.asset(Images.search,width: 25, height: 25,
      //             color: Theme.of(context).iconTheme.color,)),
      //     ],
      //   ),
      //
      //   const SizedBox(width: 10,),
      //
      // ],),
      //   showResetIcon: true,

      ),
      body: Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
          // if (categoryProvider.searchCategoryList) {
            return SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: CustomTextFieldWidget(
                    borderRadius: 12,
                    showLabelText: false,
                    controller: controller,
                    hintText: getTranslated('search', context),
                    prefixIcon: Images.searchIcon,
                    onChanged: (val){

                      categoryProvider.search(val);
                    },

                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryProvider.searchCategoryList.length,
                    gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,crossAxisSpacing: 5,mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFEFECF5),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                                                  isBrand: false,
                                                  index: index,
                                                  id: categoryProvider.searchCategoryList[index].id.toString(),
                                                  name: categoryProvider.searchCategoryList[index].name,
                                                )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(children: [
                            // const SizedBox(height: 10,),
                            CustomImageWidget(image: categoryProvider.searchCategoryList[index].iconUrl,width: 80,height: 80,fit: BoxFit.fill,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(child: Text(

                                    categoryProvider.searchCategoryList[index].name,
                                  overflow: TextOverflow.visible,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.tajawal(
                                      color: Colors.black,

                                    ),
                                  )),
                                ],
                              ),
                            )
                          ],),
                        ),
                      ),
                      );
                    },
                ),
              )
              // Container(width: 100, margin: const EdgeInsets.only(top: 3),
              //   height: double.infinity,
              //   decoration: BoxDecoration(color: Theme.of(context).highlightColor,
              //     boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeController>(context).darkTheme ? 700 : 200]!, spreadRadius: 1, blurRadius: 1)]),
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: categoryProvider.categoryList.length,
              //     padding: const EdgeInsets.all(0),
              //     itemBuilder: (context, index) {
              //       CategoryModel category = categoryProvider.categoryList[index];
              //       return InkWell(onTap: () {
              //         categoryProvider.changeSelectedIndex(index);
              //         // Provider.of<ProductController>(context, listen: false).initBrandOrCategoryProductList(false, categoryProvider.categoryList[index].id.toString(), context);
              //
              //       },
              //         child: CategoryItem(title: category.name, icon: category.iconUrl, isSelected: categoryProvider.categorySelectedIndex == index));})),
              
              // Expanded(child: SingleChildScrollView(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       ListView.builder(
              //         physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              //         itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].childes.length+1,
              //         itemBuilder: (context, index) {
              //           late CategoryModel subCategory;
              //           if(index != 0) {
              //             subCategory = categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].childes[index-1];
              //           }
              //           if(index == 0) {
              //             return Ink(color: Theme.of(context).highlightColor,
              //               child: ListTile(
              //                 title: Text(getTranslated('all_products', context)!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
              //                     maxLines: 2, overflow: TextOverflow.ellipsis),
              //                 trailing: const Icon(Icons.navigate_next),
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
              //                     isBrand: false,
              //                     id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].id.toString(),
              //                     name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex!].name,
              //                   )));
              //                 },
              //               ),
              //             );
              //           } else {
              //             return Ink(
              //               color: Theme.of(context).highlightColor,
              //               child: ListTile(
              //                 title: Text(subCategory.name, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 2, overflow: TextOverflow.ellipsis),
              //                 trailing: Icon(Icons.navigate_next, color: Theme.of(context).textTheme.bodyLarge!.color),
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
              //                     isBrand: false, id: subCategory.id.toString(), name: subCategory.name)));
              //                 },
              //               ),
              //             );
              //           }
              //
              //         },
              //       ),
              //
              //     ],
              //   ),
              // )),
              
                        ]),
            );
          // } else {
          //   return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
          // }
        },
      ),
    );
  }

  // List<Widget> _getSubSubCategories(BuildContext context, SubCategory subCategory) {
  //   List<Widget> subSubCategories = [];
  //   subSubCategories.add(Container(
  //     color: ColorResources.getIconBg(context),
  //     margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
  //     child: ListTile(
  //       title: Row(children: [
  //         Container(height: 7, width: 7, decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle)),
  //         const SizedBox(width: Dimensions.paddingSizeSmall),
  //
  //         Flexible(child: Text(getTranslated('all_products', context)!, style: textRegular.copyWith(
  //           fontSize: Dimensions.fontSizeSmall,
  //           color: ColorResources.getTextTitle(context),
  //         ), maxLines: 2, overflow: TextOverflow.ellipsis)),
  //       ]),
  //       onTap: () {
  //         Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
  //           isBrand: false,
  //           id: subCategory.id.toString(),
  //           name: subCategory.name,
  //         )));
  //       },
  //     ),
  //   ));
  //   for(int index=0; index < subCategory.subSubCategories!.length; index++) {
  //     subSubCategories.add(Container(color: ColorResources.getIconBg(context),
  //       margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
  //       child: ListTile(title: Row(children: [
  //         Container(height: 7, width: 7,
  //             decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle)),
  //         const SizedBox(width: Dimensions.paddingSizeSmall),
  //
  //         Flexible(
  //           child: Text(subCategory.subSubCategories![index].name!, style: textRegular.copyWith(
  //             color: ColorResources.getTextTitle(context), fontSize: Dimensions.fontSizeSmall,
  //           ), maxLines: 2, overflow: TextOverflow.ellipsis),
  //         ),
  //
  //       ]),
  //         onTap: () {
  //           Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
  //             isBrand: false,
  //             id: subCategory.subSubCategories![index].id.toString(),
  //             name: subCategory.subSubCategories![index].name,
  //           )));
  //         },
  //       ),
  //     ));
  //   }
  //   return subSubCategories;
  // }
}

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  const CategoryItem({super.key, required this.title, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(width: 100,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? ColorResources.getPrimary(context) : null),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(height: 50, width: 50,
            decoration: BoxDecoration(border: Border.all(width: 2, color: isSelected ?
            Theme.of(context).highlightColor : Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(borderRadius: BorderRadius.circular(10),
              child: CustomImageWidget(fit: BoxFit.cover,
                image: '$icon'))),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
          child: Text(title!, maxLines: 2, style: textRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: isSelected ? Theme.of(context).highlightColor : ColorResources.getTextTitle(context),
          ), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
        ),

      ]),
      ),
    );
  }
}

