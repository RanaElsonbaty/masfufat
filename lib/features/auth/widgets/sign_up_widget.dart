import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/domain/models/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {


  RegisterModel register = RegisterModel();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();






  @override
  void initState() {
    super.initState();
    if(Provider.of<SplashController>(context, listen: false).configModel!=null) {

    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(children: [
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
                        hintText: getTranslated('Enter_company_organization_name', context),
                        inputType: TextInputType.name,
                        required: true,
                        showLabelText: false,

                        focusNode: authProvider.fNameFocus,
                        nextFocus: authProvider.lNameFocus,
                        titleText: getTranslated('Company_Institution_Name', context),
                        capitalization: TextCapitalization.words,
                        controller: authProvider.companyName,
                        validator: (value)  => ValidateCheck.validateEmptyText(value, "Company_Institution_Name_Required"))),


                    Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault,
                        top: Dimensions.marginSizeSmall),
                      child: CustomTextFieldWidget(
                        hintText: getTranslated('Enter_the_owner_full_name', context),
                        // labelText: getTranslated('Full_name_of_the_license_holder', context),
                        focusNode: authProvider.lNameFocus,
                        titleText: getTranslated('Owner_name', context),
                        nextFocus: authProvider.emailFocus,
                        showLabelText: false,
                        required: true,
                        capitalization: TextCapitalization.words,
                        controller: authProvider.licenseHolderName,
                        validator: (value)  => ValidateCheck.validateEmptyText(value, "Full_name_of_license_holder_is_required"))),

                      Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault, right: Dimensions.marginSizeDefault,
                          top: Dimensions.marginSizeSmall),
                        child: CustomTextFieldWidget(
                          hintText: getTranslated('enter_your_email', context),
                          // labelText: getTranslated('enter_your_email', context),
                          focusNode: authProvider.emailFocus,
                            lTf: true,
showLabelText: false,
titleText: getTranslated('email', context),
                          nextFocus: authProvider.phoneFocus,
                          required: true,
                          inputType: TextInputType.emailAddress,
                          controller: authProvider.emailController,

                          validator: (value) => ValidateCheck.validateEmail(value))),



                      Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                          right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                        child: CustomTextFieldWidget(
                          hintText: getTranslated('enter_mobile_number', context),
                          // labelText: getTranslated('enter_mobile_number', context),
                          controller: authProvider.phoneController,
                          titleText: getTranslated('phone_number', context),
                          showLabelText: false,
                          focusNode: authProvider.phoneFocus,
                          nextFocus: authProvider.passwordFocus,
                          required: true,
                            lTf: true,

                          showCodePicker: true,


                          countryDialCode: authProvider.countryDialCode,
                          onCountryChanged: (CountryCode countryCode) {
                            authProvider.phoneFocus.requestFocus();
                            authProvider.countryDialCode = countryCode.dialCode!;
                            authProvider.setCountryCode(countryCode.dialCode!);
                          },
                            textAlign: TextAlign.center,
                          isAmount: true,
                          validator: (value)=> ValidateCheck.validateEmptyText(value, "phone_must_be_required"),
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.phone
                        )),




                      Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                          right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                        child: CustomTextFieldWidget(
                          hintText: getTranslated('minimum_password_length', context),
                          // labelText: getTranslated('password', context),
                          titleText: getTranslated('password', context),
                          showLabelText: false,
                          controller: authProvider.passwordController,
                          focusNode: authProvider.passwordFocus,
                          isPassword: true,required: true,
                          lTf: true,

                          nextFocus: authProvider.confirmPasswordFocus,
                          inputAction: TextInputAction.next,
                          validator: (value)=> ValidateCheck.validatePassword(value, "password_must_be_required"),
                        )),



                      Hero(tag: 'user',
                        child: Container(margin: const EdgeInsets.only(left: Dimensions.marginSizeDefault,
                            right: Dimensions.marginSizeDefault, top: Dimensions.marginSizeSmall),
                          child: CustomTextFieldWidget(
                            isPassword: true,required: true,
                            lTf: true,

                            hintText: getTranslated('re_enter_password', context),
                            // labelText: getTranslated('re_enter_password', context),
                            titleText: getTranslated('re_enter_password', context),
                            showLabelText: false,
                            controller: authProvider.confirmPasswordController,
                            onChanged: (text) {
                              setState(() {

                              });
                            },
                            focusNode: authProvider.confirmPasswordFocus,
                            inputAction: TextInputAction.done,
                              validator: (value)=> ValidateCheck.validateConfirmPassword(value, authProvider.passwordController.text.trim()),
                          ))),



                    Container(margin: const EdgeInsets.all(Dimensions.marginSizeLarge), child: Hero(
                      tag: 'onTap',
                      child: CustomButton(
                        isLoading: authProvider.isLoading,

                        onTap:     authProvider.companyName.text!=''&&authProvider.licenseHolderName.text!=''&&
                            authProvider.emailController.text!=''&&authProvider.phoneController.text!=''
                            &&authProvider.passwordController.text!='' &&authProvider.passwordController.text.length>=8&&authProvider.passwordController.text.trim()==authProvider.confirmPasswordController.text.trim()?(){
                          if(
                          authProvider.companyName.text!=''&&authProvider.licenseHolderName.text!=''&&
                              authProvider.emailController.text!=''&&authProvider.phoneController.text!=''
                             &&authProvider.passwordController.text!='' &&authProvider.passwordController.text.length>=8&&authProvider.passwordController.text.trim()==authProvider.confirmPasswordController.text.trim()){
                            authProvider.initPageIndex(false);

                          }
                        }:null, buttonText: getTranslated('next', context),
                      ),
                    )),


                    ],
                  ),
                );
              }
            );
          }
        ),
      ],
    );
  }
}
