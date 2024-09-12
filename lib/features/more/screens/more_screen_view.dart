import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/screens/contact_us_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/html_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/logout_confirm_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/more_horizontal_section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/profile_info_section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/title_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/screens/guest_track_order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/setting/screens/settings_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_ticket_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/basewidget/webView.dart';
import '../../../localization/controllers/localization_controller.dart';
import '../../Store settings/screen/store_setting_screen.dart';
import '../../order/controllers/order_controller.dart';
import '../../payment /controller/payment_controller.dart';
import '../../setting/widgets/select_currency_bottom_sheet_widget.dart';
import '../../setting/widgets/select_language_bottom_sheet_widget.dart';
import 'faq_screen_view.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late bool isGuestMode;
  String? version;
  bool singleVendor = false;

  @override
  void initState() {
    isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<SplashController>(context, listen: false).initConfig(context);
      Provider.of<ProfileController>(context, listen: false)
          .getUserInfo(context);
      Provider.of<PaymentController>(context,listen: false).getPaymentMethod(context,'wallet');

      Provider.of<PaymentController>(context,listen: false).getType('wallet_charge');
      Provider.of<PaymentController>(context,listen: false).getAmount(0);
      if (Provider.of<SplashController>(context, listen: false)
              .configModel!
              .walletStatus ==
          1) {
        Provider.of<WalletController>(context, listen: false)
            .getTransactionList(context, 1, 'all');
      }
      if (Provider.of<SplashController>(context, listen: false)
              .configModel!
              .loyaltyPointStatus ==
          1) {
        Provider.of<LoyaltyPointController>(context, listen: false)
            .getLoyaltyPointList(context, 1);
      }
    }
    singleVendor =
        Provider.of<SplashController>(context, listen: false).configModel !=
                null
            ? Provider.of<SplashController>(context, listen: false)
                    .configModel!
                    .businessMode ==
                "single"
            : true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashController>(context, listen: false);
    Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              elevation: 0,
              expandedHeight: 160,
              pinned: true,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).highlightColor,
              collapsedHeight: 160,
              flexibleSpace: const ProfileInfoSectionWidget()),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeSmall),
                        child: Center(child: MoreHorizontalSection())),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 30, right: 40),
                      child: Text(
                        getTranslated('general', context) ?? '',
                        style: GoogleFonts.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),

                    Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(children: [
                          if (Provider.of<AuthController>(context,
                                  listen: false)
                              .isLoggedIn())
                            MenuButtonWidget(
                                image: Images.profileIcon,
                                title: getTranslated('profile', context),
                                navigateTo: const WepView(
                                  url: '${AppConstants.baseUrl}/api/v1/auth/login_',
                                  check: false,
                                  sub: false,
                                )
                            ),
                          MenuButtonWidget(
                              image: Images.shoppingIcon,
                              title: getTranslated('TRACK_ORDER', context),
                              navigateTo: const GuestTrackOrderScreen()),

                          MenuButtonWidget(
                              image: Images.saveAddress,
                              title: getTranslated('addresses', context),
                              navigateTo: const AddressListScreen()),

                          singleVendor
                              ? const SizedBox()
                              : MenuButtonWidget(
                                  image: Images.chatsIcon,
                                  title: getTranslated('inbox', context),
                                  navigateTo: const InboxScreen()),
                          // if(!isGuestMode)
                          //   MenuButtonWidget(image: Images.refIcon, title: getTranslated('refer_and_earn', context),
                          //       isProfile: true,
                          //       navigateTo: const ReferAndEarnScreen()),

                          // if(splashController.configModel!=null&&splashController.configModel!.activeTheme != "default" && authController.isLoggedIn())
                          //   MenuButtonWidget(image: Images.compare, title: getTranslated('compare_products', context),
                          //       navigateTo: const CompareProductScreen()),
                        ])),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 0.5,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(width: 0.5, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 0, left: 30, right: 40),
                        child: Text(
                          getTranslated('settings', context) ?? '',
                          style: GoogleFonts.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        )),

                    Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(children: [
                                                  SwitchListTile(
                        value:
                            Provider.of<ThemeController>(context).darkTheme,
                        activeColor: Colors.white,
                        activeTrackColor: Theme.of(context).primaryColor,
                        inactiveThumbColor: Theme.of(context).primaryColor,
                        trackOutlineColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        onChanged: (bool isActive) =>
                            Provider.of<ThemeController>(context,
                                    listen: false)
                                .toggleTheme(),
                        title: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Theme.of(context).primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  Images.darkModeIcon,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(getTranslated('dark_theme', context)!,
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge)),
                          ],
                        ),
                                                  ),
                                                  TitleButton(
                          image: Images.languageChange,
                          title: '${getTranslated('choose_language', context)} (${AppConstants.languages[Provider.of<LocalizationController>(context, listen: false).languageIndex!].languageName})',
                          onTap: () => showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (_) =>
                                  const SelectLanguageBottomSheetWidget())),
                                                  TitleButton(
                          image: Images.currencyIcon,
                          title:
                              '${getTranslated('currency', context)} (${Provider.of<SplashController>(context).myCurrency!.name})',
                          onTap: () => showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (_) =>
                                  const SelectCurrencyBottomSheetWidget())),
                                                  MenuButtonWidget(
                          image: Images.myStoreIcons,
                          title: getTranslated(
                              'Settings_for_linking_my_online_store',
                              context),
                          navigateTo: const StoreSettingScreen()),
                                                ])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 0.5,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(width: 0.5, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 30, right: 40),
                      child: Text(
                        getTranslated('SUPPORT_CENTER', context) ?? '',
                        style: GoogleFonts.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ),

                    Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(children: [
                          // MenuButtonWidget(image: Images.notification, title: getTranslated('notification', context,),
                          //     isNotification: true,
                          //     navigateTo: const NotificationScreen()),

                          // if(Provider.of<SplashController>(context, listen: false).configModel!.refundPolicy!.status ==1)
                          //   MenuButtonWidget(image: Images.termCondition, title: getTranslated('refund_policy', context),
                          //       navigateTo: HtmlViewScreen(title: getTranslated('refund_policy', context),
                          //         url: Provider.of<SplashController>(context, listen: false).configModel!.refundPolicy!.content,)),

                          // if(Provider.of<SplashController>(context, listen: false).configModel!.returnPolicy!.status ==1)
                          //   MenuButtonWidget(image: Images.termCondition, title: getTranslated('return_policy', context),
                          //       navigateTo: HtmlViewScreen(title: getTranslated('return_policy', context),
                          //         url: Provider.of<SplashController>(context, listen: false).configModel!.returnPolicy!.content,)),

                          // if(Provider.of<SplashController>(context, listen: false).configModel!.cancellationPolicy!.status ==1)
                          //   MenuButtonWidget(image: Images.termCondition, title: getTranslated('cancellation_policy', context),
                          //       navigateTo: HtmlViewScreen(title: getTranslated('cancellation_policy', context),
                          //         url: Provider.of<SplashController>(context, listen: false).configModel!.cancellationPolicy!.content,)),
                          MenuButtonWidget(
                              image: Images.supportIcon,
                              title: getTranslated('support_ticket', context),
                              navigateTo: const SupportTicketScreen()),
                          MenuButtonWidget(
                              image: Images.call,
                              title: getTranslated('contact_us', context),
                              navigateTo: const ContactUsScreen()),
                          MenuButtonWidget(
                              image: Images.instruction,
                              title: getTranslated('faq', context),
                              navigateTo: FaqScreen(
                                title: getTranslated('faq', context),
                              )),
                          MenuButtonWidget(
                              image: Images.terms_conditionIcon,
                              title: getTranslated('terms_condition', context),
                              navigateTo: HtmlViewScreen(
                                title:
                                    getTranslated('terms_condition', context),
                                url: Provider.of<SplashController>(context,
                                                listen: false)
                                            .configModel !=
                                        null
                                    ? Provider.of<SplashController>(context,
                                            listen: false)
                                        .configModel!
                                        .termsConditions
                                        .sa
                                    : '',
                              )),

                          MenuButtonWidget(
                              image: Images.about_us,
                              title: getTranslated('about_us', context),
                              navigateTo: HtmlViewScreen(
                                title: getTranslated('about_us', context),
                                url: Provider.of<SplashController>(context,
                                                listen: false)
                                            .configModel !=
                                        null
                                    ? Provider.of<SplashController>(context,
                                            listen: false)
                                        .configModel!
                                        .aboutUs
                                        .sa
                                    : '',
                              )),
                          // MenuButtonWidget(image: Images.settings, title: getTranslated('settings', context),
                          //     navigateTo: const SettingsScreen()),
                          // MenuButtonWidget(image: Images.category, title: getTranslated('CATEGORY', context),
                          //     navigateTo: const CategoryScreen()),

                          MenuButtonWidget(
                              image: Images.info,
                              title: getTranslated('privacy_policy', context),
                              navigateTo: HtmlViewScreen(
                                title: getTranslated('privacy_policy', context),
                                url: Provider.of<SplashController>(context,
                                                listen: false)
                                            .configModel !=
                                        null
                                    ? Provider.of<SplashController>(context,
                                            listen: false)
                                        .configModel!
                                        .privacyPolicy
                                        .sa
                                    : "",
                              )),
                          ListTile(
                            trailing:  const Icon(Icons.arrow_forward_ios_sharp,size: 15,),
                              leading: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.red),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      Images.logOutIcon,
                                      color: Colors.white,
                                    ),
                                  )),
                              title: Text(
                                  isGuestMode
                                      ? getTranslated('sign_in', context)!
                                      : getTranslated('sign_out', context)!,
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge)),
                              onTap: () {
                                if (isGuestMode) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AuthScreen()));
                                } else {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (_) =>
                                          const LogoutCustomBottomSheetWidget());
                                }
                              }),
                        ])),
                    //

                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${getTranslated('version', context)} ${AppConstants.appVersion}',
                                  style: textRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: Theme.of(context).hintColor))
                            ]))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
