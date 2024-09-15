import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/reset_password_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/custom_button_widget.dart';
import '../../../localization/language_constrants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/auth_controller.dart';

class EmailOtpVerification extends StatefulWidget {
  const EmailOtpVerification({super.key, required this.email});
  final String email;

  @override
  State<EmailOtpVerification> createState() => _EmailOtpVerificationState();
}

class _EmailOtpVerificationState extends State<EmailOtpVerification> {
  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();
TextEditingController pinController=TextEditingController();
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
                      AnimatedContainer(
                        transform: Matrix4.translationValues(0, -20, 0),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(getTranslated('Verification_code', context)!,
                                style: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,


                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(getTranslated('Enter_the_verification_code_sent_to_your_email', context)!,
                            style: GoogleFonts.tajawal(
                                color: const Color(0xff222222),
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            )),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),




                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(getTranslated('Verification_code', context)!,
                                style: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
const SizedBox(height: 5,),
                                Pinput(
controller: pinController,
                  validator: (s) {
                  return int.tryParse(s!).runtimeType==int ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                  ),
                      const SizedBox(height: 60   ,),





                      Consumer<AuthController>(
                        builder:(context, auth, child) =>  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: CustomButton(
                            isLoading: authProvider.isLoading,
                            buttonText:
                            // splashProvider.configModel?.forgotPasswordVerification == "phone"
                            //     ? getTranslated('send_otp', context)
                            //     :
                            getTranslated('Confirm_code', context),
                            onTap: () {
                        auth.verifyOtpForResetPassword(widget.email,pinController.text).then((value) {
                        if(value.response==null){
showCustomSnackBar(getTranslated('verify_otp', context), context);
                        }else if(value.response!.data=={ "message": "otp expired."}){
                          showCustomSnackBar(getTranslated('verify_otp', context), context);

                        }else{

                          Navigator.push(context,MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email, otp: pinController.text,),));

                        }

                        });



                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(getTranslated('Resend_code', context)!
                          ,
                            style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
            );
          }
      ),
    );
  }
}
