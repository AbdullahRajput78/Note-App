import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';
import 'logic.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({Key? key}) : super(key: key);

  final NavigationLogic logic = Get.put(NavigationLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,

        body: logic.pages[logic.selectedindex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            // color: backgroundcolor,
            // borderRadius: BorderRadius.circular(20),
            border: Border(
              top: BorderSide(color: textcolorgrey,width: 1),

            )
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: logic.selectedindex.value,
            onTap: (index) {
              logic.selectedindex.value = index;
            },

            unselectedLabelStyle: TextStyle(fontSize: 12),
            unselectedIconTheme: IconThemeData(size: 23),
            unselectedItemColor: textcolorblack,

            selectedLabelStyle: TextStyle(
              color: mainthemecolor,
              fontSize: 12,
              fontFamily: elmsans,
              fontWeight: elmsbold,
            ),
            selectedIconTheme: IconThemeData(color: mainthemecolor,size: 27),
            selectedItemColor: mainthemecolor,

            showUnselectedLabels: true,

            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  (logic.selectedindex.value == 0 ? Icons.sticky_note_2: Icons.sticky_note_2_outlined),
                ),
                label: 'Notes',
              ),

              BottomNavigationBarItem(
                  icon: Icon(  logic.selectedindex.value == 1
                      ? Icons.star
                      : Icons.star_border,),
                  label: 'Favourite'),

              BottomNavigationBarItem(
                icon: Icon(
                  logic.selectedindex.value == 2
                      ? Icons.archive
                      : Icons.archive_outlined,
                ),
                label: 'Archive',
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  logic.selectedindex.value == 3 ? Icons.person : Icons.person_outline,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      );
    });
  }
}
