import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/no_internet_screen_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewComSection extends StatefulWidget {
  const ReviewComSection({super.key, required this.productDetailsModel});
  final ProductDetailsModel productDetailsModel;

  @override
  State<ReviewComSection> createState() => _ReviewComSectionState();
}

class _ReviewComSectionState extends State<ReviewComSection> {
  @override
  Widget build(BuildContext context) {
    return widget.productDetailsModel.reviews!=null&&widget.productDetailsModel.reviews!.isNotEmpty? ListView.builder(
        itemCount: widget.productDetailsModel.reviews!=null?widget.productDetailsModel.reviews!.length:0,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
          padding: const EdgeInsets.all(0),
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:  CustomImageWidget(image: widget.productDetailsModel.reviews![index].customerImageUrl??'',width: 50,height: 50,)),
                  const SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 5,),
                    Text(widget.productDetailsModel.reviews![index].customerName??'',style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),),
                    //   Text(widget.productDetailsModel.reviews![index].c,style: GoogleFonts.poppins(
                    //   fontWeight: FontWeight.w500,
                    //   color: Theme.of(context).hintColor,
                    //   fontSize: 12
                    // ),),
                  ],),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(DateConverter.convertStringTimeToDate(widget.productDetailsModel.reviews![index].createdAt,),style: GoogleFonts.tajawal(
                      fontSize: 12,fontWeight: FontWeight.w400
                    ),),
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(widget.productDetailsModel.reviews![index].comment
                        ,
                      style: GoogleFonts.tajawal(
                        fontWeight: FontWeight.w400,
                        fontSize: 12
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(Icons.star,color:widget.productDetailsModel.reviews![index].rating>=1?const Color(0xffEEA651):Colors.grey,size: 20,),
                    Icon(Icons.star,color:widget.productDetailsModel.reviews![index].rating>=2?const Color(0xffEEA651):Colors.grey,size: 20,),
                    Icon(Icons.star,color: widget.productDetailsModel.reviews![index].rating>=3?const Color(0xffEEA651):Colors.grey,size: 20,),
                    Icon(Icons.star,color:widget.productDetailsModel.reviews![index].rating>=4?const Color(0xffEEA651):Colors.grey,size: 20,),
                    Icon(Icons.star,color: widget.productDetailsModel.reviews![index].rating>=5?const Color(0xffEEA651):Colors.grey,size: 20,),
                    const SizedBox(width: 5,),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(widget.productDetailsModel.reviews![index].rating.toString(),style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).hintColor
                      ),),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8,),
            
              Divider(
                color: Theme.of(context).hintColor.withOpacity(0.40),
                height: 0.5,
                
              )
            ],),
          );
        }, ):const NoInternetOrDataScreenWidget(isNoInternet: false);
  }
}
