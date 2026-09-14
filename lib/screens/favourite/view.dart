import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../customwidgets/notecard.dart';
import '../../theme/theme.dart';
import '../description/view.dart';
import '../home/logic.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({Key? key}) : super(key: key);

  final NotesLogic logic = Get.find<NotesLogic>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 15),
        //   child: Icon(Icons.menu),
        // ),

        title: Text('Favourites'),
        titleTextStyle:
        TextStyle(
            fontFamily: elmsans,
            fontWeight: elmsbolditalic,
            fontSize: 20,
            color: textcolorblack
        ),
        centerTitle: true,

        actions: [Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.search),
        )
        ],
      ),


      body: Obx(() {
        final favouriteNotes = logic.notes
            .where((e) => e.isFavorite && !e.isArchived)
            .toList();

        if (favouriteNotes.isEmpty){
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/favourite.svg',height: 320)]
              )
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 23,right: 23),
          child: ListView.builder(
            itemCount: favouriteNotes.length,
            itemBuilder: (context, index) {

              final note = favouriteNotes[index];

              return NoteCard(
                note: note,
                onTap: () {
                  Get.to(() => DescriptionPage(),
                    arguments: note,
                  );
                },

                onFavorite: () {
                  logic.toggleFavorite(note);{
                    // note.isFavorite = !note.isFavorite;
                  }

                },
                onArchive: () {
                  logic.toggleArchive(note);
                },
              );
            },
          ),
        );
      })
    );
  }
}
