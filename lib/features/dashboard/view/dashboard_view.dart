import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leetcode_tracker/core/constants/app_colors.dart';
import 'package:leetcode_tracker/features/dashboard/data/model/leetcode_data_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardView extends StatelessWidget {
  final String name;
  final LeetcodeDataModel? userState;

  const DashboardView({super.key, required this.name, required this.userState});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: matteBlack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            50,
          ),
          bottomRight: Radius.circular(
            50,
          ),
        ),
      ),
      // height: MediaQuery.of(context).size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5 - 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'NotoSerif',
                    ),
                  ),
                  Text(userState != null ? userState!.displayName : 'Loading..',
                      style: const TextStyle(
                        color: appYellow,
                      ))
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5 - 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    child: CircularPercentIndicator(
                      radius: 70,
                      lineWidth: 10,
                      percent: userState != null
                          ? userState!.acSubmissions / userState!.submissions
                          : 0,
                      progressColor: appYellow,
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            userState != null
                                ? userState!.acSubmissions.toString()
                                : "0",
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '/${userState != null ? userState!.submissions : 0}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      footer: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Easy\n${userState != null ? userState!.easySubmissions : 0}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 119, 233, 123),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Medium\n${userState != null ? userState!.mediumSubmissions : 0}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 236, 217, 53),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Hard\n${userState != null ? userState!.hardSubmissions : 0}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 232, 85, 75),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
