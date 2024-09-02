
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'email_otp_verification.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();
  // String? _countryDialCode = '+880';

  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    // _countryDialCode = CountryCode.fromCountryCode(
    //     Provider.of<SplashController>(context, listen: false).configModel!.countryCode).dialCode;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,

      // appBar: CustomAppBar(title: getTranslated('forget_password', context)),
      body: Consumer<AuthController>(
        builder: (context, authProvider,_) {
          return Consumer<SplashController>(
            builder: (context, splashProvider, _) {
              return Column(
                children: [
                  Stack(children: [

                    Container(height: 200, decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.9))),
                    // Image.asset(Images.loginBg,fit: BoxFit.cover,height: 200, opacity : const AlwaysStoppedAnimation(.15)),

                    Positioned(
                        left: MediaQuery.of(context).size.width/3.5,
                        right:  MediaQuery.of(context).size.width/3.5,
                        bottom: 60,
                        child: Image.asset(Images.whiteLogoWithMame, width: 160, height: 55,fit: BoxFit.fill,)),


                  ]),
                  AnimatedContainer(transform: Matrix4.translationValues(0, -20, 0),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge))),
                    duration: const Duration(seconds: 2),
                    child: Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(padding: const EdgeInsets.symmetric(horizontal:  Dimensions.marginSizeLarge),
                            child: Row(children: [



                              const Spacer(),
                               InkWell(
                                onTap: (){
                               Navigator.pop(context);

                                },
                                child: Text(getTranslated('back', context)!,style: GoogleFonts.tajawal(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14
                                ),),
                              )
                            ])),
                        const SizedBox(height: 20,)
                      ],),
                    ),
                  ),








                  // splashProvider.configModel!.forgotPasswordVerification == "phone"?
                  // Text(getTranslated('enter_phone_number_for_password_reset', context)!,
                  //     style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                  //         fontSize: Dimensions.fontSizeDefault)):

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(getTranslated('forget', context)!,
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,


                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(getTranslated('enter_email_for_password_reset', context)!,
                        style: GoogleFonts.tajawal(
                          color: const Color(0xff222222),
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        )),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),




                  // splashProvider.configModel!.forgotPasswordVerification == "phone"?
                  // Container(margin: const EdgeInsets.only(top: Dimensions.marginSizeSmall),
                  //   child: CustomTextFieldWidget(
                  //     hintText: getTranslated('enter_mobile_number', context),
                  //     controller: _numberController,
                  //     focusNode: _numberFocus,
                  //     showCodePicker: true,
                  //     countryDialCode: authProvider.countryDialCode,
                  //     onCountryChanged: (CountryCode countryCode) {
                  //       authProvider.countryDialCode = countryCode.dialCode!;
                  //       authProvider.setCountryCode(countryCode.dialCode!);
                  //     },
                  //     isAmount: true,
                  //     validator: (value)=> ValidateCheck.validateEmptyText(value, "phone_must_be_required"),
                  //     inputAction: TextInputAction.next,
                  //     inputType: TextInputType.phone,
                  //   )) :

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomTextFieldWidget(
                      controller: _controller,
                      // lTf: true,
                      // labelText: getTranslated('email', context),
                      titleText: getTranslated('email', context),
                      showLabelText: false,

                      hintText: getTranslated('Enter_your_email_address', context),
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.emailAddress,
                      required: true,

                      showBorder: true,

                      validator: (value)=> ValidateCheck.validateEmptyText(value,'enter_email_or_mobile'),
                    ),
                  ),
                  const SizedBox(height: 70),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomButton(
                      isLoading: authProvider.isLoading,
                      buttonText:
                      // splashProvider.configModel?.forgotPasswordVerification == "phone"
                      //     ? getTranslated('send_otp', context)
                      //     :
                      getTranslated('Send_link', context),
                      onTap: () {
                    if(_controller.text.isNotEmpty){


                        // if(forgetFormKey.currentState?.validate() ?? false) {

                          authProvider.forgetPassword(_controller.text).then((value) {
                            if(value.response?.statusCode == 200) {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              Navigator.push(context,MaterialPageRoute(builder: (context) => const EmailOtpVerification(),));
                              _controller.clear();

                              // showAnimatedDialog(context, SuccessDialog(
                              //   icon: Icons.send,
                              //   title: getTranslated('sent', context),
                              //   description: getTranslated('recovery_link_sent', context),
                              //   rotateAngle: 5.5,
                              // ), dismissible: false);
                            }
                          });
                    }else{
                      showCustomSnackBar(getTranslated('enter_email_or_mobile', context), context,isError: true);

                    }
                        // }



                      },
                    ),
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }
}

