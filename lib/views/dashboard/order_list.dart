import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webingo_dash/constants/app_constants.dart';
import 'package:webingo_dash/styles/app_colors.dart';
import 'package:webingo_dash/styles/custom_text_style.dart';
import 'package:get/get.dart';

import '../../database_manager/database_manager.dart';
import '../auth/sign_in.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List orderList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }


  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        orderList = resultant;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryButtonColor,
      appBar: AppBar(
        title: Text(
          "Order List",
          style: CustomTextStyle.ultraBoldTextStyle1(
              color: AppColors.primaryColor, letterSpacing: 2),
        ),
        elevation: 0,
        backgroundColor: AppColors.primaryButtonColor,
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.to(const Login());
            },
            child: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.screenHorizontalPadding),
            child: Row(
              children: [
                Text("Day",style: CustomTextStyle.boldMediumTextStyle(color: Colors.white),),
                const SizedBox(width: 20,),
                Text("Week",style: CustomTextStyle.boldMediumTextStyle(color: Colors.white),),
                const SizedBox(width: 20,),
                Text("Month",style: CustomTextStyle.boldMediumTextStyle(color: Colors.white),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.screenHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.backgroundColor,),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: Text("Sort by: Parcel Weight", style: CustomTextStyle.boldMediumTextStyle(color: AppColors.backgroundColor),),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                            child: Text("Filter (2)", style: CustomTextStyle.boldMediumTextStyle(color: AppColors.primaryButtonColor),),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      color: Colors.grey[900],
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "HS Code",
                                style: CustomTextStyle.boldMediumTextStyle(
                                    color: AppColors.backgroundColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("L / W / H (cm)",
                                  style: CustomTextStyle.boldMediumTextStyle(
                                      color: AppColors.backgroundColor)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("DATE",
                                  style: CustomTextStyle.boldMediumTextStyle(
                                      color: AppColors.backgroundColor)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("TIME",
                                  style: CustomTextStyle.boldMediumTextStyle(
                                      color: AppColors.backgroundColor)),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.settings,color: AppColors.primaryColor,),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: Get.height,
                      child: ListView.builder(
                          itemCount:  orderList.length,
                          itemBuilder: (context, index) {
                            return Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(3),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      orderList[index]["hsCode"],
                                      style: CustomTextStyle.ultraSmallTextStyle(
                                          color: AppColors.secondaryColor ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${orderList[index]["length"]} / ${orderList[index]["width"]} / ${orderList[index]["height"]}",
                                        style: CustomTextStyle.ultraSmallTextStyle(
                                            color: AppColors.secondaryColor)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(orderList[index]["date"],
                                        style: CustomTextStyle.ultraSmallTextStyle(
                                            color: AppColors.secondaryColor)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(orderList[index]["time"],
                                        style: CustomTextStyle.ultraSmallTextStyle(
                                            color: AppColors.secondaryColor)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.primaryColor,),
                                  )
                                ]),
                              ],
                            );
                          }),
                    )

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
