import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../auth/controllers/auth_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;
  OnBoardingScreen({super.key, this.indicatorColor = Colors.grey, this.selectedIndicatorColor = Colors.black});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingController>(context, listen: false).getOnBoardingList();



    return Scaffold(
      body: Consumer<OnBoardingController>(
        builder: (context, onBoardingList, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                if(onBoardingList.selectedIndex != onBoardingList.onBoardingList.length - 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: (){
                          Provider.of<SplashController>(context, listen: false).disableIntro();
                          Provider.of<AuthController>(context, listen: false).getGuestIdUrl();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
              
                            Text('${getTranslated('skip', context)}',
                                style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                            const SizedBox(width: 5,),
                             Icon(Icons.arrow_forward_ios,size: 15,color: Theme.of(context).primaryColor,)
                          ],
                        )),
                  ),
              
                SizedBox(
                  height: MediaQuery.of(context).size.height>300? MediaQuery.of(context).size.height-300: MediaQuery.of(context).size.height-200,
                  child: PageView.builder(
                  
                    // physics: const NeverScrollableScrollPhysics(),
                      itemCount: onBoardingList.onBoardingList.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center, children: [
                              // const SizedBox(height: 100,),
                              Image.asset(onBoardingList.onBoardingList[index].imageUrl,),
                              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,horizontal: 15),
                                child: Text(onBoardingList.onBoardingList[index].title,
                                    style: GoogleFonts.tajawal(fontSize: 24,fontWeight: FontWeight.w500), textAlign: TextAlign.center),),
                              Expanded(
                                child: Text(onBoardingList.onBoardingList[index].description,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.center, style: GoogleFonts.tajawal(
                                        fontSize: 16,fontWeight: FontWeight.w400)),
                              ),
                              // const SizedBox(height: Dimensions.paddingSizeDefault),
              
                            ],
                          ),
                        );
                      },
                      onPageChanged: (index) {
                        // if(index != onBoardingList.onBoardingList.length){
                        onBoardingList.changeSelectIndex(index);
                        // }else{
                        // Provider.of<SplashController>(context, listen: false).disableIntro();
                        // Provider.of<AuthController>(context, listen: false).getGuestIdUrl();
                        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
                        // }
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 5,width: 8,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:onBoardingList.selectedIndex==0? Theme.of(context).primaryColor:Colors.grey
                    ),),
                    const SizedBox(width: 5,),
                    Container(height: 5,width: 8,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: onBoardingList.selectedIndex==1? Theme.of(context).primaryColor:Colors.grey
                    ),),
                    const SizedBox(width: 5,),
              
                    Container(height: 5,width: 8,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:onBoardingList.selectedIndex==2? Theme.of(context).primaryColor:Colors.grey
                    ),),
                    const SizedBox(width: 5,),
              
                    Container(height: 5,width: 8,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: onBoardingList.selectedIndex==3? Theme.of(context).primaryColor:Colors.grey
                    ),),
              
                  ],
                ),
                const SizedBox(height: 20,),
                onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1?
                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                    child: Center(child: SizedBox(
                        height: 50,
                        width: 120,child: CustomButton(
                      textColor: Colors.white,
                      radius: 5,backgroundColor: Theme.of(context).primaryColor,
                      buttonText: getTranslated("Start_your_experience_now", context),
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
                      },))))
                    :
                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                  child: Stack(children: [
                    if(onBoardingList.onBoardingList.isNotEmpty)
                      Center(child: SizedBox(height: 50, width: 50,
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                              value: (onBoardingList.selectedIndex + 1) / onBoardingList.onBoardingList.length,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor))),
                  
                    Align(alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              if (onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1) {
                                Provider.of<SplashController>(context, listen: false).disableIntro();
                                // Provider.of<AuthController>(context, listen: false).getGuestIdUrl();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
                              } else {
                                _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                              }
                            },
                            child: Container(height: 40, width: 40,
                                margin: const EdgeInsets.only(top: 4,right: 3),
                                decoration: const BoxDecoration(shape: BoxShape.circle,),
                                child: const Center(child: Icon(Icons.arrow_forward_ios,size: 20,))))),
                  ]),
                ),
              
              //     Consumer<OnBoardingController>(
              //       builder: (context, onBoardingList, child) => Column(
              //         // padding: const EdgeInsets.all(0),
              //         children: [
              //
              //
              //       // Padding(
              //       //   padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
              //       //   child: CustomButton(buttonText: getTranslated('Start_your_experience_now', context),onTap: (){
              //       //     Provider.of<SplashController>(context, listen: false).disableIntro();
              //       //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
              //       //
              //       //   },),
              //       // ),
              //
              //     ],
              //   ),
              // ),
                  
                  
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}
