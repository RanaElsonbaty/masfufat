import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_up_sec_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/widgets/sign_up_widget.dart';
import 'package:provider/provider.dart';


class SignUpPageBuilder extends StatefulWidget {
  const SignUpPageBuilder({super.key});

  @override
  State<SignUpPageBuilder> createState() => _SignUpPageBuilderState();
}

class _SignUpPageBuilderState extends State<SignUpPageBuilder>    with TickerProviderStateMixin{
  late PageController _pageViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder:(context, auth, child) {

          if(auth.pageIndex==0){
          return const SignUpWidget();
          }else{
            return const SignUpSecWidget();

          }

      },
    );
  }
  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }



}
