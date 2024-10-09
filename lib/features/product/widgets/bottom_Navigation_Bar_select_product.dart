import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/my%20shop/controllers/my_shop_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utill/images.dart';
import '../controllers/product_controller.dart';
import '../domain/models/product_model.dart';

class SelectProductWidget extends StatefulWidget {
final   List<Product> products;
  const SelectProductWidget({super.key, required this.products});

  @override
  State<SelectProductWidget> createState() => _SelectProductWidgetState();
}

class _SelectProductWidgetState extends State<SelectProductWidget> {
  @override
  Widget build(BuildContext context) {
    return  Consumer<ProductController>(
      builder:(context, product, child) => product.productSelect.isNotEmpty? Container(
        height: 90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            LinearProgressIndicator(value: product.value,color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<MyShopController>(
                          builder:(context, myShopController, child) =>  InkWell(
                            onTap: (){

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
                            child: Container(
                              height: 30,
                              width: 125,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(children: [
                                  const Icon(Icons.select_all,color: Colors.white,),
                                  const SizedBox(width: 5,),
                                  Text('تحديد الكل',style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,color: Colors.white
                                  ),)
                                ],),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            product.clearSelectProduct();
                          },
                          child: Container(
                            height: 30,
                            width: 125,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(children: [
                                const Icon(Icons.select_all,color: Colors.white,),
                                const SizedBox(width: 5,),

                                Text('الغاء التحديد',style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,color: Colors.white
                                ),)
                              ],),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Text('المنتجات المحددة : ${product.productSelect.length}',style: GoogleFonts.tajawal(
                        fontSize: 14,fontWeight: FontWeight.bold
                    ),),
                  ),

                  InkWell(
                    onTap: ()async{
                      await product.addProductToSync().then((value) {
                        product.clear();
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 105,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(children: [
                          const SizedBox(height: 5,),

                          Image.asset(Images.myStoreIcon,width: 20 ,color: Colors.white,),

                          const SizedBox(height: 5,),

                          Text('اضف لمتجري',style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,color: Colors.white
                          ),)
                        ],),
                      ),
                    ),
                  ),
                ],),
            ),
          ],
        ),

      ):const SizedBox.shrink(),
    );
  }
}
