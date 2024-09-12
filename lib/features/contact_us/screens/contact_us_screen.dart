
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/controllers/contact_us_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/domain/models/contact_us_body.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_ticket_screen.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> contactFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    Provider.of<AuthController>(context, listen: false).setCountryCode(CountryCode.fromCountryCode(Provider.of<SplashController>(context, listen: false).configModel!.countryCode).dialCode!, notify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(centerTitle: true,title: '${getTranslated('contact_us', context)}'),
      body: Consumer<AuthController>(
        builder: (context, authProvider, _) {
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
            child: SingleChildScrollView(child: Form(
              key: contactFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(Images.appIcon, width: 160, height: 55,fit: BoxFit.fill,),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(getTranslated('Contact_us', context)!,style: GoogleFonts.tajawal(
                      fontSize: 16,fontWeight: FontWeight.w600
                    ),),
                  ],
                ),
                const SizedBox(height:30,),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: (){
                       _openUrl('tel:+966920031434');

                    },
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFECF5),
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset(Images.contactCall),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTranslated('Unified_number', context)!,style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                            ),),
                            Text('+966 920031434',
                              textDirection: TextDirection.ltr,
                              // textAlign: TextAlign.end,
                              style: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.60)
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: (){
                      // _openUrl();
                       _openUrl('mailto:care@masfufat.com');

                      },
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFECF5),
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset(Images.contactEmail),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTranslated('Email', context)!,style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                            ),),
                            Text('care@masfufat.com',
                              textDirection: TextDirection.ltr,
                              // textAlign: TextAlign.end,
                              style: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.60)
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFECF5),
                          shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Image.asset(Images.contactLocation),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated('the_address', context)!,style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ),),
                          Text('السعودية, الرياض,حي الراشد',
                            textDirection: TextDirection.ltr,
                            // textAlign: TextAlign.end,
                            style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                              color: Colors.black.withOpacity(0.60)
                          ),),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Image.asset(Images.whatsapp,width: 30,),
                    Image.asset(Images.twitter,width: 30,),
                    Image.asset(Images.threads,width: 30,),
                    Image.asset(Images.instagram,width: 30,),
                    Image.asset(Images.telegram,width: 30 ,),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Divider(color: Colors.grey.shade400,),
                const SizedBox(height: 20,),

                Row(
                  children: [
                  Text(getTranslated('Contact_Form', context)!,style: GoogleFonts.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),)
                  ],
                ),
                const SizedBox(height: 20,),
                
                // SizedBox(width: MediaQuery.of(context).size.width/2,child: Image.asset(Images.contactUsBg)),
                CustomTextFieldWidget(
                  // prefixIcon: Images.user,
                  titleText: getTranslated('full_name', context),
                  controller: fullNameController,
                  required: true,
                  showLabelText: false,

                  labelText: getTranslated('full_name', context),
                  hintText: getTranslated('enter_full_name', context),
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'name_is_required'),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                CustomTextFieldWidget(
                  titleText: getTranslated('email', context),
                  
                  hintText: getTranslated('email', context),
                    // prefixIcon: Images.email,
                    required: true,
                  showLabelText: false,

                    labelText: getTranslated('email', context),
                    controller: emailController,
                  validator: (value) =>ValidateCheck.validateEmail(value),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                CustomTextFieldWidget(
                    hintText: '920031434',
                    titleText: getTranslated('PHONE_NO', context),
                    labelText: getTranslated('enter_mobile_number', context),
                    controller: phoneController,
                    required: true,
                    showLabelText: false,
                    showCodePicker: true,
                    lTf: true,
                    countryDialCode: authProvider.countryDialCode,
                    onCountryChanged: (CountryCode countryCode) {
                      authProvider.countryDialCode = countryCode.dialCode!;
                      authProvider.setCountryCode(countryCode.dialCode!);
                    },
                    isAmount: true,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.phone,
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'phone_is_required'),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                CustomTextFieldWidget(
                  required: true,
                  titleText: getTranslated('the_topic', context),
                  labelText: getTranslated('the_topic', context),
                  hintText: getTranslated('the_topic', context),
                  controller: subjectController,
                  showLabelText: false,
                  
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'subject_is_required'),

                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                CustomTextFieldWidget(maxLines: 5,
                    required: true,
                  showLabelText: false,
titleText: getTranslated('message', context),
                    controller: messageController,
                    labelText: getTranslated('message', context),
                    hintText: getTranslated('message', context),
                  validator: (value)=> ValidateCheck.validateEmptyText(value, 'message_is_required'),

                ),
              ],),
            )),
          );
        }
      ),
      bottomNavigationBar: Consumer<ContactUsController>(
        builder: (context, profileProvider, _) {
          return Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 20  ),
            child: CustomButton(
              isLoading: profileProvider.isLoading,
              buttonText: getTranslated('send_request', context),
              onTap: (){
                if(contactFormKey.currentState?.validate() ?? false) {

                  String name = fullNameController.text.trim();
                  String email = emailController.text.trim();
                  String phone = phoneController.text.trim();
                  String subject = subjectController.text.trim();
                  String message = messageController.text.trim();

                  ContactUsBody contactUsBody = ContactUsBody(name: name, email: email, phone: phone, subject: subject, message: message);

                   profileProvider.contactUs(contactUsBody).then((isSuccess){
                     if(isSuccess) {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SupportTicketScreen()));

                     }


                  });
                }


              },
            ),
          );
        }
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
