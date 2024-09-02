import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_in_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/sign_up_pageBuilder.dart';





class AuthScreen extends StatefulWidget{
    final bool fromLogout;
  const AuthScreen({super.key, this.fromLogout = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0, notify: false);
    super.initState();
  }
  bool scrolled = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        Future.delayed(Duration.zero, () {
          if (Provider.of<AuthController>(context, listen: false).selectedIndex != 0) {
            Provider.of<AuthController>(context, listen: false).updateSelectedIndex(0);
          } else {
            if(Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }else{
              if (widget.fromLogout) {
                if (!Provider.of<AuthController>(context, listen: false).isLoading) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
                }
              } else {
                //Navigator.of(context).pop();
              }
              //showModalBottomSheet(backgroundColor: Colors.transparent, context: context, builder: (_)=> const AppExitCard());
            }
          }
          //return val;
        });
      },
      child: Scaffold(
        body: Consumer<AuthController>(
          builder: (context, authProvider,_) {
            return Column(children: [
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

                          InkWell(onTap: () => authProvider.updateSelectedIndex(0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(getTranslated('login', context)!, style: authProvider.selectedIndex == 0 ?
                                GoogleFonts.tajawal(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w500) :
                                GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w500)),
                                // Container(height: 3, width: 25, margin: const EdgeInsets.only(top: 8),
                                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                //       color: authProvider.selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent))
                              ])),
                          const SizedBox(width: Dimensions.paddingSizeExtraLarge),


                          InkWell(onTap: () => authProvider.updateSelectedIndex(1),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              Text(getTranslated('sign_up', context)!, style: authProvider.selectedIndex == 1 ?
                              GoogleFonts.tajawal(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w500) :
                              GoogleFonts.tajawal(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w500)),
            ]
            )),
const Spacer(),
                          authProvider.selectedIndex==1&& authProvider.pageIndex==1?   InkWell(
                            onTap: (){
                              authProvider.initPageIndex(true);

                            },
                            child: Text(getTranslated('back', context)!,style: GoogleFonts.tajawal(
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                            ),),
                          ):const SizedBox.shrink()
                        ])),
                      const SizedBox(height: 20,)
                    ],),
                  ),
                ),

              Expanded(child:  SingleChildScrollView(
                
                padding: EdgeInsets.zero,
                child: authProvider.selectedIndex == 0 ? const SignInWidget() : const SignUpPageBuilder(),
              )),

            ],
            );
          }
        ),
      ),
    );
  }
}

