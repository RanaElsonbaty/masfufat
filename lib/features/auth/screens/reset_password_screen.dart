import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../helper/velidate_check.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  const ResetPasswordScreen({super.key,required this.email,required this.otp});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  final FocusNode _newPasswordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }


  void resetPassword() async {
      String password = _passwordController!.text.trim();
      String confirmPassword = _confirmPasswordController!.text.trim();

      if (password.isEmpty) {
        showCustomSnackBar(getTranslated('password_must_be_required', context), context);
      } else if (confirmPassword.isEmpty) {
        showCustomSnackBar(getTranslated('confirm_password_must_be_required', context), context);
      }else if (password != confirmPassword) {
        showCustomSnackBar(getTranslated('password_did_not_match', context), context);
      } else {
        Provider.of<AuthController>(context, listen: false).resetPassword(widget.email,widget.otp, password, confirmPassword);
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: 'title'),
      body: Column( children: [
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
  child: Padding(
    padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
    child: Column(children: [

      // Padding(padding: const EdgeInsets.all(50),
      //   child: Image.asset(Images.logoWithNameImage, height: 150, width: 200),),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSizeLarge),
        child: Row(
          children: [
            Text(getTranslated('password_reset', context)!, style: GoogleFonts.tajawal(
                fontWeight: FontWeight.w600,
                fontSize: 16
            )),
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
          ],
        ),
      ),
const SizedBox(height: 30,),
      Container(margin: const EdgeInsets.only(
          left: Dimensions.marginSizeLarge,
          right: Dimensions.marginSizeLarge,
          bottom: Dimensions.marginSizeSmall),
          child: CustomTextFieldWidget(
              hintText: getTranslated('new_password', context),
              focusNode: _newPasswordNode,
              showLabelText: false,

              // labelText: getTranslated('new_password', context),
              titleText: getTranslated('new_password', context),
              nextFocus: _confirmPasswordNode,
              isPassword: true,
              validator: (value)=> ValidateCheck.validatePassword(value,'password_must_be_required'),

              controller: _passwordController)),


      Container(margin: const EdgeInsets.only(
          left: Dimensions.marginSizeLarge,
          right: Dimensions.marginSizeLarge,
          bottom: Dimensions.marginSizeDefault),
          child: CustomTextFieldWidget(
              isPassword: true,
              hintText: getTranslated('confirm_password', context),
              // labelText:  getTranslated('confirm_password', context),
              titleText: getTranslated('confirm_password', context),
              showLabelText: false,
              inputAction: TextInputAction.done,
              focusNode: _confirmPasswordNode,
              validator: (value)=> ValidateCheck.validateConfirmPassword(value,_passwordController!.text),

              controller: _confirmPasswordController)),


      Container(margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
          child: Provider.of<AuthController>(context).isLoading ?
          Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
              : CustomButton(onTap: resetPassword, buttonText: getTranslated('reset_password', context))),

    ],),
  ),
)
        ],
      ),
    );
  }
}
