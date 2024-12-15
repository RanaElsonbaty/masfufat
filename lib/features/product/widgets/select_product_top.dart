import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../category/controllers/category_controller.dart';
import '../../my shop/controllers/my_shop_controller.dart';
import '../domain/models/product_model.dart';

class SelectProductTop extends StatefulWidget {
  const SelectProductTop({super.key, this.filterTap, this.selectIndexCategory, this.selectIndexBrand, this.selectBrandName, required this.select, required this.products, this.showOrgnalWidget=true});
  final Function? filterTap;
  final int? selectIndexCategory;
  final int? selectIndexBrand;
  final String? selectBrandName;
  final bool select;
  final   List<Product> products;
  final bool? showOrgnalWidget;


  @override
  State<SelectProductTop> createState() => _SelectProductTopState();
}

class _SelectProductTopState extends State<SelectProductTop> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder:(context, product, child) =>  Consumer<CategoryController>(
        builder:(context, category, child) {
          if(widget.showOrgnalWidget==true&&widget.select==false){
          return Container(
          height: 50,
          // width: MediaQuery.of(context).size.width/1.25,
          decoration:  BoxDecoration(
              color: widget.select==false? Colors.black:Theme.of(context).primaryColor,
              // borderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(8),
              //     topRight: Radius.circular(8)
              // )
          ),
          child:

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(product.productCount.toString(),style: GoogleFonts.cairo(
                color: Colors.white,
              ),),
              Text('${category.brandCategoryList.isNotEmpty?category.brandCategoryList[widget.selectIndexCategory!].name.toString():''} ${widget.selectIndexBrand!=null?'/':''} ${widget.selectIndexBrand!=null?widget.selectBrandName:""}',style: GoogleFonts.cairo(
                color: Colors.white,
              ),),
              InkWell(onTap: () {
             widget.filterTap!();

              },
                  child: Stack(children: [
                    Container(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,
                    ),
                      child:  SizedBox(width: 20,height: 20,child: Image.asset(Images.filterIcon)),),])),

            ],)
        );}else if(widget.select==true){
            return Container(
              height: 50,
              // width:widget.showOrgnalWidget==true? MediaQuery.of(context).size.width/1.25:MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  // borderRadius: const BorderRadius.only(
                  //     topLeft: Radius.circular(8),
                  //     topRight: Radius.circular(8)
                  // )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.productSelect.length.toString(),style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w500,fontSize: 14,color: Colors.white
                    ),),
                    Text(getTranslated('Specific_products', context)!,style: GoogleFonts.cairo(
                        fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white
                    ),),

                    Consumer<MyShopController>(
                      builder:
                          (context, myShopController, child) => PullDownButton(

                        itemBuilder: (context) => [
                          // PullDownMenuHeader(title: 'title', leading: SizedBox.shrink(), ),
                          PullDownMenuTitle(title: Center(child: Text('${getTranslated('Specific_products', context)!} ${product.productSelect.length}',style: GoogleFonts.tajawal(
                              color: Colors.black
                          ),))),
                          PullDownMenuItem(
                            title: getTranslated('Add_to_my_store', context)!,
                            onTap: () async{
                              await product.addProductToSync().then((value) {
                                product.clear();
                                showCustomSnackBar(getTranslated('Products_synced_successfully', context), context,isError: false);
                              });
                            },
                          ),
                          PullDownMenuItem(
                            title: getTranslated('Select_all', context)!,
                            onTap: () async{
                              // if(Provider.of<MyShopController>(context,listen: false).pendingList.isEmpty||Provider.of<MyShopController>(context,listen: false).linkedList.isEmpty){
                              //   await  Provider.of<MyShopController>(context,listen: false).getList();
                              //
                              // }
                              for (var element in widget.products) {
                                bool  sync=false;
                                for (var elm in myShopController.pendingList) {
                                  if(elm.id==element.id){
                                    sync=true;
                                  }
                                } for (var elm in myShopController.deleteList) {
                                  if(elm.id==element.id!){
                                    sync=true;
                                  }
                                } for (var elm in myShopController.linkedList) {
                                  if(elm.id==element.id!){
                                    sync=true;
                                  }
                                }
                                if(element.currentStock!=0&&!sync){
                                  product.selectProduct(element.id!,false);

                                }

                              }
                            },
                          ),
                          PullDownMenuItem(
                            title: getTranslated('Deselect', context)!,
                            onTap: () {
                              product.clearSelectProduct();

                            },
                          ),
                        ],
                        buttonBuilder: (context, showMenu) => CupertinoButton(
                            onPressed: showMenu,
                            padding: EdgeInsets.zero,
                            child:  Image.asset(Images.selectIcon,width: 30,)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            return const SizedBox();
          }
        },
      ),
    );
  }

}
