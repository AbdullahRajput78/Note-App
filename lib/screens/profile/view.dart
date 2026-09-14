import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';
import '../home/logic.dart';
import 'logic.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final NotesLogic logic = Get.find<NotesLogic>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //------------------------------------------ Header with gradient --------------------
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: height * 0.07,

                bottom: height * 0.035,
                left: 23,
                right: 23,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [mainthemecolor, mainthemecolor.withOpacity(0.75)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: mainthemecolor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  //------------------------------------------ Avatar --------------------
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person_rounded,
                          size: 52, color: mainthemecolor),
                    ),
                  ),

                  SizedBox(height: height * 0.018),

                  Text(
                    'My Notes',
                    style: TextStyle(
                      fontFamily: elmsans,
                      fontWeight: elmsbold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // child: Text(
                    //   'Capture ideas, keep favourites close,\nand archive what you\'re done with.',
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontFamily: elmsans,
                    //     fontWeight: elmssemibold,
                    //     fontSize: 13,
                    //     color: Colors.white.withOpacity(0.85),
                    //     height: 1.4,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),

            //------------------------------------------ Stat cards, overlapping the header --------------------
            Transform.translate(
              offset: const Offset(0, -30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Obx(() {
                  final all = logic.notes.where((e) => !e.isArchived).length;
                  final favourites = logic.notes
                      .where((e) => e.isFavorite && !e.isArchived)
                      .length;
                  final archived = logic.notes.where((e) => e.isArchived).length;

                  return Row(
                    children: [
                      StatCard(
                        icon: Icons.notes_rounded,
                        label: 'All Notes',
                        count: all,
                        gradientColors: [
                          mainthemecolor,
                          mainthemecolor.withOpacity(0.7),
                        ],
                      ),
                      const SizedBox(width: 12),
                      StatCard(
                        icon: Icons.star_rounded,
                        label: 'Favourites',
                        count: favourites,
                        gradientColors: const [
                          Color(0xFFFFA726),
                          Color(0xFFFF7043),
                        ],
                      ),
                      const SizedBox(width: 12),
                      StatCard(
                        icon: Icons.archive_rounded,
                        label: 'Archive',
                        count: archived,
                        gradientColors: const [
                          Color(0xFF66BB6A),
                          Color(0xFF43A047),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),

            //------------------------------------------ Extra info section --------------------
            Transform.translate(
              offset: const Offset(0, -14),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: mainthemecolor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.bolt_rounded,
                            color: mainthemecolor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stay organized',
                              style: TextStyle(
                                fontFamily: elmsans,
                                fontWeight: elmsbold,
                                fontSize: 14,
                                color: textcolorblack,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Your notes sync instantly across the app',
                              style: TextStyle(
                                fontFamily: elmsans,
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
