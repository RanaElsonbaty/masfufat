import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/widgets/search_filter_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/search_product/controllers/search_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';


class SearchSuggestion extends StatefulWidget{
  final bool fromCompare;
  final int? id;
  final  PagingController? pagingController;
  const SearchSuggestion({super.key,  this.fromCompare = false, this.id,  this.pagingController});
  @override
  State<SearchSuggestion> createState() => _SearchSuggestionState();
}
//    searchProvider.searchController = controller;
//                 searchProvider.searchFocusNode = focusNode;
class _SearchSuggestionState extends State<SearchSuggestion> {
  @override
  void initState() {
    super.initState();

    Future.delayed((const Duration(milliseconds: 500))).then((_){
      Provider.of<SearchProductController>(context, listen: false).searchProduct(query: '', categoryIds: '',brandIds: '',priceMax: '',priceMin: '',sort: '',offset: 1);

      FocusScope.of(context).requestFocus(Provider.of<SearchProductController>(context, listen: false).searchFocusNode);

    });
  }


  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Consumer<SearchProductController>(
        builder: (context, searchProvider, _) {
          return SizedBox(height: 56,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(

                  child: TextFormField(

                    controller: searchProvider.searchController,
                    focusNode: searchProvider.searchFocusNode,
                    textInputAction: TextInputAction.search,
                    onChanged: (val){
                      if(val.isNotEmpty){

                      }
                    },
                    onFieldSubmitted: (value) {
                      if(searchProvider.searchController.text.trim().isNotEmpty) {
                        try{
                          widget.pagingController!.refresh();

                        } catch(e){}
                      }else{
                        showCustomSnackBar(getTranslated('enter_somethings', context), context);
                      }
                    },

                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                    decoration: InputDecoration(
                      isDense: false,
                      contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      hintText: getTranslated('search_product', context),
                      // suffixIcon:
                    ),
                  ),
                ),
                SizedBox(width: searchProvider.searchController.text.isNotEmpty? 70 : 50,
                  child: Row(children: [
                    if(searchProvider.searchController.text.isNotEmpty)
                      InkWell(onTap: (){
                        setState(() {
                          searchProvider.searchController.clear();
                          try{
                            widget.pagingController!.refresh();

                          } catch(e){}
                          searchProvider.cleanSearchProduct(notify: true);
                        });
                      }, child: const Icon(Icons.clear, size: 20,)),


                    InkWell(onTap: (){
                      showModalBottomSheet(context: context,
                          isScrollControlled: true, backgroundColor: Colors.transparent,
                          builder: (c) =>   SearchFilterBottomSheet(pagingController: widget.pagingController! ,));

                    },
                      child: Padding(padding: const EdgeInsets.all(5),
                        child: Container(width: 40, height: 50,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall))),
                            child: SizedBox(width : 18,height: 18, child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Image.asset(Images.filterIcon, color: Colors.white),
                            ))),
                      ),
                    ),
                  ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
