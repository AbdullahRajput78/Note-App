import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/notesmodel.dart';


class NotesLogic extends GetxController {
  final box = GetStorage();

  static const String noteKey = "notes";

  RxList<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadNotes();
  }


  void loadNotes() {
    final data = box.read(noteKey);
    if (data != null) {
      notes.assignAll(
        (data as List)
            .map((e) => NoteModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }
  }

  void saveNotes() {
    box.write(
      noteKey,
      notes.map((e) => e.toJson()).toList(),
    );
  }

  //--------------------- for deleting note in description -----------------
  void deleteNote(NoteModel note) {
    notes.remove(note);
    saveNotes();
  }


  //----------------------- for adding to favourite -------------
  void toggleFavorite(NoteModel note) {
    note.isFavorite = !note.isFavorite;
    notes.refresh();
    saveNotes();
    // update();

    if(note.isFavorite){
      Get.rawSnackbar(
        messageText: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.greenAccent, Colors.teal],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 20),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Note!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Added to Favourite",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1C1C28),
        borderRadius: 20,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: EdgeInsets.all(14),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 500),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      );
    }
    else{
      Get.rawSnackbar(
        messageText: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.red.shade600,Colors.red.shade900],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Note!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Removed from Favourites",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1C1C28),
        borderRadius: 20,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: EdgeInsets.all(14),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 500),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      );
    }
  }

  //---------------------- for adding to archive ---------------
  void toggleArchive(NoteModel note){
    note.isArchived=!note.isArchived;
    notes.refresh();
    saveNotes();
    if(note.isArchived){
      Get.rawSnackbar(
        messageText: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.greenAccent, Colors.teal],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 20),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Note!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Added to Archived",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1C1C28),
        borderRadius: 20,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: EdgeInsets.all(14),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 500),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      );
    }
    else{
      Get.rawSnackbar(
        messageText: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.red.shade600,Colors.red.shade900],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Note!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Removed from Archive",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1C1C28),
        borderRadius: 20,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: EdgeInsets.all(14),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 500),
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeIn,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      );
    }

  }

  }

