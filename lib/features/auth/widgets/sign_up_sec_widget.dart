import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_button_widget.dart';
import '../../../common/basewidget/custom_textfield_widget.dart';
import '../../../common/basewidget/show_custom_snakbar_widget.dart';
import '../../../helper/velidate_check.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../utill/dimensions.dart';
import '../../address/controllers/address_controller.dart';
import '../../banner/controllers/banner_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../deal/controllers/featured_deal_controller.dart';
import '../../deal/controllers/flash_deal_controller.dart';
import '../../notification/controllers/notification_controller.dart';
import '../../payment /controller/payment_controller.dart';
import '../../product/controllers/product_controller.dart';
import '../../profile/controllers/profile_contrroller.dart';
import '../../shop/controllers/shop_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';
import '../controllers/auth_controller.dart';
import '../domain/models/register_model.dart';
import 'min_googleMap_sign_up.dart';

class SignUpSecWidget extends StatefulWidget {
  const SignUpSecWidget({super.key});

  @override
  State<SignUpSecWidget> createState() => _SignUpSecWidgetState();
}

class _SignUpSecWidgetState extends State<SignUpSecWidget> {
  // final TextEditingController _companyName = TextEditingController();
  // final TextEditingController _licenseHolderName = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  // final TextEditingController _referController = TextEditingController();

String cityId='';
  RegisterModel register = RegisterModel();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();



route(bool isRoute, String? token, String? tempToken, String? errorMessage) async {
  Provider.of<SplashController>(context,listen: false);
  var authController = Provider.of<AuthController>(context, listen: false);
  var profileController = Provider.of<ProfileController>(context, listen: false);
  // String phone = authController.countryDialCode +_phoneController.text.trim();
  if (isRoute) {
    // if(splashController.configModel!.emailVerification!){
    //   authController.sendOtpToEmail(_emailController.text.toString(), tempToken!).then((value) async {
    //     if (value.response?.statusCode == 200) {
    //       authController.updateEmail(_emailController.text.toString());
    //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>
    //           VerificationScreen(tempToken,'',_emailController.text.toString())), (route) => false);
    //
    //     }
    //   });
    // }else if(splashController.configModel!.phoneVerification!){
    //   authController.sendOtpToPhone(phone,tempToken!).then((value) async {
    //     if (value.isSuccess) {
    //       authController.updatePhone(phone);
    //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) =>
    //           VerificationScreen(tempToken,phone,'')), (route) => false);
    //
    //     }
    //   });
    // }else{c
      await profileController.getUserInfo(context);
      loadData(true);
       authController.companyName.clear();
       authController.certificateImage=null;
       authController.commercialRegisterImage=null;
       authController.emailController.clear();
       authController.phoneController.clear();
       authController.address.clear();
       authController.commercialRegistrationNo.clear();
       authController.companyName.clear();
       authController.licenseHolderName.clear();
       authController.phoneController.clear();
       authController.lot.clear();
       authController.lan.clear();
       authController.passwordController.clear();
       authController.taxNumber.clear();
       authController.confirmPasswordController.clear();
      cityId='';

      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) =>
      const DashBoardScreen()), (route) => false);
    // }

    }
    else {
      showCustomSnackBar(errorMessage, context);
    }
  }
static Future<void> loadData(bool reload) async {
  Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload,'main_banner');
  Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(reload);
  Provider.of<FlashDealController>(Get.context!, listen: false).getFlashDealList(reload, false);
  Provider.of<ProductController>(Get.context!, listen: false).getFeaturedProductList('1', reload: reload);
  Provider.of<FeaturedDealController>(Get.context!, listen: false).getFeaturedDealList(reload);
  Provider.of<ShopController>(Get.context!, listen: false).getTopSellerList(reload, 1, type: "top");
  Provider.of<ProductController>(Get.context!, listen: false).getRecommendedProduct();
  Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload,'main_section_banner');
  Provider.of<ProductController>(Get.context!, listen: false).getHomeCategoryProductList(reload);
  Provider.of<AddressController>(Get.context!, listen: false).getAddressList();
  Provider.of<CartController>(Get.context!, listen: false).getCartData(Get.context!);
  Provider.of<ProductController>(Get.context!, listen: false).getLatestProductList(1, reload: reload);

  Provider.of<WishListController>(Get.context!, listen: false).getWishList();
  // await Provider.of<ProductController>(Get.context!, listen: false).getLProductList('1', reload: reload);
  Provider.of<NotificationController>(Get.context!, listen: false).getNotificationList(1);
  if(Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()){
    await     Provider.of<ProfileController>(Get.context!, listen: false).getUserInfo(Get.context!);
  }
  Provider.of<PaymentController>(Get.context!,listen: false).getIsLoading(true,false);
  Provider.of<PaymentController>(Get.context!,listen: false).getAmount(( 0));
  Provider.of<PaymentController>(Get.context!,listen: false).getApiKey(Get.context!);
  Provider.of<PaymentController>(Get.context!,listen: false).initiate(Get.context!);
  Provider.of<PaymentController>(Get.context!,listen: false).getPaymentMethod(Get.context!,'cart');
  Provider.of<PaymentController>(Get.context!,listen: false).cardViewStyle();
  Provider.of<PaymentController>(Get.context!,listen: false).getIsLoading(false,true);
}
  @override
  void initState() {
    super.initState();
    Provider.of<AddressController>(context, listen: false).getCityList('20');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Consumer<AuthController>(
            builder: (context, authProvider, _) {
              return Consumer<SplashController>(
                  builder: (context, splashProvider,_) {
                    return Form(
                      key: signUpFormKey,
                      child: Column(children: [
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                        Container(
                            margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault),
                            child: CustomTextFieldWidget(
                                hintText: getTranslated('Commercial_Registration_Number_Self_Employment_Document', context),
                                labelText: getTranslated('Commercial_Registration_Number_Self_Employment_Document', context),
                                inputType: TextInputType.name,
                                required: true,
                                focusNode: authProvider.commercialRegistrationNoFocus,
                                nextFocus: authProvider.taxNumberFocus,
                                // prefixIcon: Images.username,
                                capitalization: TextCapitalization.words,
                                controller: authProvider.commercialRegistrationNo,
                                validator: (value)  => ValidateCheck.validateEmptyText(value, "Commercial_Registration_Number_Self_Employment_Document"))),
      
      
                        Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault,
                            top: Dimensions.marginSizeSmall),
                            child: CustomTextFieldWidget(
                                hintText: getTranslated('Tax_Number', context),
                                labelText: getTranslated('Tax_Number', context),
                                focusNode: authProvider.taxNumberFocus,
                                // prefixIcon: Images.username,
                                nextFocus: authProvider.storeLinkFocus,
                                required: true,
                                capitalization: TextCapitalization.words,
                                controller: authProvider.taxNumber,
                                validator: (value)  => ValidateCheck.validateEmptyText(value, "Tax_Number"))),
      
                        Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault,
                            top: Dimensions.marginSizeSmall),
                            child: CustomTextFieldWidget(
                                hintText: getTranslated('Store_Link', context),
                                labelText: getTranslated('Store_Link', context),
                                focusNode: authProvider.storeLinkFocus,
                                nextFocus: authProvider.governorateFocus,
                                required: true,
                                inputType: TextInputType.emailAddress,
                                controller: authProvider.storeLink,
                                // prefixIcon: Images.email,
                                validator: (value) => ValidateCheck.validateEmptyText(value!,"Store_Link"))),
      
      
      
                        Consumer<AddressController>(
                          builder:(context, address, child) =>  Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    DropDownState(
                                      DropDown(
                                        bottomSheetTitle: Text(
                                          getTranslated('city', context)!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        data: address.cityList
                                            .map((e) => SelectedListItem(
                                          value: e.id.toString(),
                                          name: e.name,
                                        ))
                                            .toList(),
                                        isSearchVisible: true,

                                        selectedItems:
                                            (selectedList) async {

                                          if (selectedList.isNotEmpty) {
                                           setState(() {
                                             cityId=selectedList.first.value!;
                                             authProvider.governorate.text=selectedList.first.name;
                                           });
                                          }



                                        },
                                        enableMultipleSelection: false,
                                      ),
                                    ).showModal(context);
                                  },
                                  child: Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault,
                                      top: Dimensions.marginSizeSmall),
                                      child: CustomTextFieldWidget(
                                          hintText: getTranslated('Governorate', context),
                                          labelText: getTranslated('Governorate', context),
                                          // focusNode: authProvider.governorateFocus,
                                          // nextFocus: authProvider.addressFocus,
                                          required: true,
                                          isEnabled: false,
                                          // inputType: TextInputType.emailAddress,
                                          controller: authProvider.governorate,
                                          // prefixIcon: Images.email,
                                          validator: (value) => ValidateCheck.validateEmptyText(authProvider.governorate.text,"Governorate")
                                      )),
                                ),
                              ),

                              Expanded(
                                child: Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                                    right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                                    child: CustomTextFieldWidget(
                                        hintText: getTranslated('the_address', context),
                                        labelText: getTranslated('the_address', context),
                                        controller: authProvider.address,
                                        focusNode: authProvider.addressFocus,
                                        isPassword: false,required: true,
                                        nextFocus: authProvider.lanFocus,
                                        inputAction: TextInputAction.next,
                                        validator: (value)=> ValidateCheck.validateEmptyText(value, "the_address"),
                                )),
                              ),
                            ],
                          ),
                        ),
                        const MinGoogleMap(),
                      Row(children: [
      
                        Expanded(
                          child: Hero(tag: 'Coordinates_Longitude',
                              child: Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                                  right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                                  child: CustomTextFieldWidget(
                                      isPassword: false,required: true,
                                    isEnabled: false,
                                      
                                      hintText: getTranslated('Coordinates_Longitude', context),
                                      labelText: getTranslated('Coordinates_Longitude', context),
                                      controller: authProvider.lan,
                                      // focusNode: _confirmPasswordFocus,
                                      inputAction: TextInputAction.done,
                                      // validator: (value)=> ValidateCheck.validateConfirmPassword(value, _passwordController.text.trim()),
                                  ))),
                        ),
                        Expanded(
                          child: Hero(tag: 'Coordinates_Latitude',
                              child: Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                                  right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                                  child: CustomTextFieldWidget(
                                      isPassword: false,required: true,
                                      isEnabled: false,
                                      hintText: getTranslated('Coordinates_Latitude', context),
                                      labelText: getTranslated('Coordinates_Latitude', context),
                                      controller: authProvider.lot,
                                      // focusNode: _confirmPasswordFocus,
                                      inputAction: TextInputAction.done,
                                      // validator: (value)=> ValidateCheck.validateConfirmPassword(value, _passwordController.text.trim()),
                                      ))),
                        ),
                      ],),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(getTranslated('Online_store_logo', context)!,
                                style: GoogleFonts.tajawal(
                                  fontSize: 18
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            authProvider.pickImage(false, 0);

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child:authProvider.storeImage!=null?Image.file(File(authProvider.storeImage!.path)): ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                child: SizedBox(
                                  height: 50,
                                  child:Row(
                                    children: [
                                      Text(getTranslated('Online_store_logo', context)!,style: GoogleFonts.tajawal(
                                        fontSize: 16,

                                      ),),
                                      const SizedBox(width: 5,),
                                      Text('(Ratio 1:1)',style: GoogleFonts.tajawal(
                                        fontSize: 16,
                                        color: Colors.cyan

                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(getTranslated('Commercial_Register_Self_Employment_Document', context)!,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 18
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            authProvider.pickImage(false, 1);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child:authProvider.commercialRegisterImage!=null?Image.file(File(authProvider.commercialRegisterImage!.path)): ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                child: SizedBox(
                                  height: 50,
                                  child:Row(
                                    children: [
                                      Expanded(
                                        child: Text(getTranslated('Commercial_Register_Self_Employment_Document', context)!,
                                          overflow: TextOverflow.ellipsis,
                                            
                                          style: GoogleFonts.tajawal(
                                          fontSize: 16,

                                        ),),
                                      ),
                                      const SizedBox(width: 5,),
                                      Text('(Ratio 1:1)',style: GoogleFonts.tajawal(
                                        fontSize: 16,
                                        color: Colors.cyan
                                
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(getTranslated('Certificate_attached', context)!,
                                style: GoogleFonts.tajawal(
                                  fontSize: 18
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            authProvider.pickImage(false, 2);

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child:authProvider.certificateImage!=null?Image.file(File(authProvider.certificateImage!.path)): ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                child: SizedBox(
                                  height: 50,
                                  child:Row(
                                    children: [
                                      Text(getTranslated('Certificate_attached', context)!,style: GoogleFonts.tajawal(
                                        fontSize: 16,

                                      ),),
                                      const SizedBox(width: 5,),
                                      Text('(Ratio 1:1)',style: GoogleFonts.tajawal(
                                        fontSize: 16,
                                        color: Colors.cyan

                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: authProvider.consent,
                                onChanged: (val){
                                  authProvider.getConsent();
                                },
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),                              Expanded(child: Text(getTranslated('I_acknowledge_that_I_am_the_owner', context)!,)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(child: Text(getTranslated('Use_the_invitation_code_to_get_credit_in_your_wallet_optional', context)!,

                            overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                        Hero(tag: 'Use_the_invitation_code_to_get_credit_in_your_wallet_optional',
                            child: Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                                right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                                child: CustomTextFieldWidget(
                                  isPassword: false,required: true,
                                  isEnabled: true,
                                  hintText: getTranslated('Use_the_invitation_code_to_get_credit_in_your_wallet_optional', context),
                                  labelText: getTranslated('Use_the_invitation_code_to_get_credit_in_your_wallet_optional', context),
                                  controller: authProvider.walletCouponCode,
                                  // focusNode: authProvider.walletCouponCode,
                                  inputAction: TextInputAction.done,
                                  // validator: (value)=> ValidateCheck.validateConfirmPassword(value, _passwordController.text.trim()),
                                ))),
      
      
      
      
      
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: 'onTap',
                                  child: CustomButton(
                                    isLoading: authProvider.isLoading,
                                    onTap:   (){
                                      authProvider.initPageIndex(true);
                                    } , buttonText: getTranslated('back', context),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Expanded(
                                flex: 2,
                                child: Hero(
                                 tag: 'onTap',
                                 child: CustomButton(
                                   isLoading: authProvider.isLoading,
                                   onTap: authProvider.consent ?  (){
                                     if(signUpFormKey.currentState?.validate() ?? false) {

                                       RegisterModel model =RegisterModel(
                                         name: authProvider.companyName.text,
                                         taxCertificateImg: authProvider.certificateImage!=null?authProvider.certificateImage!.path:'',
                                         image: authProvider.storeImage!=null?authProvider.storeImage!.path:'',
                                         governorate: cityId,
                                         commercialRegistrationImg: authProvider.commercialRegisterImage!=null?authProvider.commercialRegisterImage!.path:'',
                                         email: authProvider.emailController.text,
                                         phone: authProvider.countryDialCode+authProvider.phoneController.text,
                                         address: authProvider.address.text,
                                         commercialRegistrationNo: authProvider.commercialRegistrationNo.text,
                                         companyName: authProvider.companyName.text,
                                         delegateName: authProvider.licenseHolderName.text,
                                         delegatePhone:authProvider.countryDialCode+ authProvider.phoneController.text,
                                         lat: authProvider.lot.text,
                                         lon: authProvider.lan.text,
                                         password: authProvider.passwordController.text,
                                         plan: '',
                                         remember: '1',
                                         taxNo: authProvider.taxNumber.text,
                                         code: authProvider.walletCouponCode.text,
                                       );
                                       authProvider.registration( model,(){});
                                       authProvider.registration(register, route);
                                       authProvider.registration(register, route);
                                     }
                                   } : null, buttonText: getTranslated('sign_up', context),
                                 ),
                                                                ),
                              ),
                            ],
                          ),
                        ),
      
      
                        // authProvider.isLoading ? const SizedBox() :
                        // Center(child: Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge),
                        //   child: InkWell(onTap: () {authProvider.getGuestIdUrl();
                        //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()));},
                        //     child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        //         Text(getTranslated('skip_for_now', context)!,
                        //           style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                        //               color: ColorResources.getPrimary(context))),
                        //         Icon(Icons.arrow_forward, size: 15,color: Theme.of(context).primaryColor,)
                        //       ],
                        //     ),
                        //   ),
                        // )),
                      ],
                      ),
                    );
                  }
              );
            }
        ),
      ],
      ),
    );
  }
}
