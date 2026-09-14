import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../customwidgets/notecard.dart';
import '../../theme/theme.dart';
import '../description/view.dart';
import '../newnote/logic.dart';
import '../newnote/view.dart';
import 'logic.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final NotesLogic logic = Get.put(NotesLogic());

  //final NavigationLogic navlogic = Get.put(NavigationLogic());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 15),
        //   child: Icon(Icons.menu),
        // ),

        title: Text('My Notes'),
        titleTextStyle: TextStyle(
          fontFamily: elmsans,
          fontWeight: elmsbolditalic,
          fontSize: 20,
          color: textcolorblack,
        ),
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.search),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Get.isRegistered<NewnoteLogic>()) {
            Get.delete<NewnoteLogic>();
          }

          Get.to(NewnotePage());
        },
        backgroundColor: mainthemecolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
        child: Icon(Icons.add, color: textcolorwhite),
      ),
      //------------------------------------------ 1st container blue --------------------
      body:



      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 23, right: 23),
            child: Container(
              height: height * 0.17,
              decoration: BoxDecoration(
                color: mainthemecolor,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/notepadpic.png',
                      height: height * 0.13,
                    ),
                    SizedBox(
                      width: width * 0.47,
                      // color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Morning! 👋',
                            style: TextStyle(
                              fontFamily: elmsans,
                              color: textcolorwhite,
                              fontWeight: elmsbold,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            'Capture your ideas and keep your thoughts organized.',
                            style: TextStyle(
                              fontFamily: elmsans,
                              color: textcolorwhite,
                              fontWeight: elmssemibold,
                              fontSize: 14,
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

          //------------------------------------------ Row 2 All notes --------------------
          SizedBox(height: height * 0.015),
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Notes',
                  style: TextStyle(
                    fontFamily: elmsans,
                    color: textcolorblack,
                    fontWeight: elmsbold,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.menu),
              ],
            ),
          ),

          //------------------------------------------ Row 3 Listview --------------------
          SizedBox(height: height * 0.005),



          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Obx(() {
                final homeNotes = logic.notes
                    .where((e) => !e.isArchived)
                    .toList();

                if (logic.notes.isEmpty){
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/emptynotes.svg',height: 400)]
                      )
                  );
                }
                return ListView.builder(
                  itemCount: homeNotes.length,
                  itemBuilder: ((context, index) {
                    // logic.notes.where((e) => !e.isArchived).toList();
                    final note = homeNotes[index];
                    // final date = DateTime.parse(note.createdAt);

                    return NoteCard(
                      note: note,
                      onTap: () {
                        Get.to(() => DescriptionPage(), arguments: note);
                      },

                      onFavorite: () {
                        logic.toggleFavorite(note);
                      },

                      onArchive: () {
                        logic.toggleArchive(note);
                      },
                    );
                  }),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
