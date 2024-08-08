import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoreSettingsShimmer extends StatefulWidget {
  const StoreSettingsShimmer({super.key, });

  @override
  State<StoreSettingsShimmer> createState() => _StoreSettingsShimmerState();
}

class _StoreSettingsShimmerState extends State<StoreSettingsShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder:(context, index) =>  Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
            child: Container(
              height: 225 ,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).highlightColor,
                  border: Border.all(width: 0.5,color: Colors.grey)
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey.withOpacity(0.3),
                //       spreadRadius: 1,
                //       blurRadius: 5)
                // ],
              ),
              child: Shimmer.fromColors(

                baseColor: Colors.grey[300]!,
                highlightColor: Theme.of(context).highlightColor,
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Row(
                      children: [
                      Container(height: 65, width:65, decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),),
                      const SizedBox(width: 10,)
      ,                        Container(height: 20, width:120, decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),),
                      const Spacer(),
                      Container(height: 30,width: 60, decoration: BoxDecoration(
                          // color: Colors.grey,
                        border: Border.all(width: 1,),
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                            ),
                          ),
                        ],
                      ),
                      ),
                    ],),

                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: [
                            Container(height: 15, width:80, decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),),
                            // Spacer(),
                            const SizedBox(width: 10,),
                            Container(height: 20,width: 15, decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)
                            ),),
                            const Spacer(),

                            Container(height: 15, width:70, decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),),
                            const SizedBox(width: 10,),
                            Container(height: 35,width: 120, decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),),
                          ],
                        ),





                        const SizedBox(
                          height: 10  ,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            Container(height: 80,width:350, decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                            ),),
                          ],
                        ),

                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
