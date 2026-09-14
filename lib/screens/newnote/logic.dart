import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/notesmodel.dart';
import '../description/logic.dart';
import '../home/logic.dart';
import '../../theme/theme.dart';
import 'package:image_picker/image_picker.dart';

class NewnoteLogic extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

// ------------------- for finding notes -------------
  final homeLogic = Get.find<NotesLogic>();
  bool isBackground = false;

  //------------------- image picker object ---------------
  final ImagePicker picker = ImagePicker();

  //------------------- for image path -----------------
  String? imagePath;

  //------------------- for changing color ----------------
  void changeColors() {
    isBackground = !isBackground;
    update();
  }

  //--------------------- for editing note --------------------
  NoteModel? editingNote;

  //---------------------- it loads eveything -----------------
  @override
  void onInit() {
    super.onInit();
    // print(Get.arguments);
    if (Get.arguments != null) {
      editingNote = Get.arguments;
      titleController.text = editingNote!.title;
      descriptionController.text = editingNote!.description;
      selectedtextcolor = editingNote!.textColorValue;
      selectedbackgroundcolor = editingNote!.backgroundColorValue;
      imagePath=editingNote!.imagePath;

      update();
    }
  }

  //-------------------- for tick icon selection  ----------------

Color selectedtextcolor =apptheme.notetextcolor.first;
Color selectedbackgroundcolor =apptheme.notebackgroundcolor.first;


//--------------------- function for tick selection -------------
void selectedcolor (Color color){
      if(isBackground){
        selectedbackgroundcolor =color;
      }
      else{
        selectedtextcolor=color;
      }
      update();
    }

//---------------------- for saving notes --------------
  void saveNote() {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
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
              child: Icon(Icons.info_outline_rounded, color: Colors.white, size: 20),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Missing Information!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Please enter both title or description",
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
        duration: Duration(seconds: 3),
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
      return;
    }

    if (editingNote != null) {
      editingNote!.title = titleController.text;
      editingNote!.description = descriptionController.text;
      editingNote!.textColor = selectedtextcolor.value;
      editingNote!.backgroundColor = selectedbackgroundcolor.value;
      editingNote!.imagePath=imagePath;

      homeLogic.notes.refresh();

    } else {
      homeLogic.notes.insert(
        0,
        NoteModel(
          title: titleController.text,
          description: descriptionController.text,
          textColor: selectedtextcolor.value,
          backgroundColor: selectedbackgroundcolor.value,
          imagePath: imagePath,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
    }
    homeLogic.saveNotes();
    if (Get.isRegistered<DescriptionLogic>()) {
      Get.find<DescriptionLogic>().update();
    }
    clearFields();
    Get.back();
    Future.delayed(Duration(milliseconds: 100), () {

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
                    "Added Successfully.",
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
    });
}


  /////////////////////// it clears the text field and colors after saving
  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    selectedtextcolor = apptheme.notetextcolor.first;
    selectedbackgroundcolor = apptheme.notebackgroundcolor.first;

    // editingNote=null;
    isBackground = false;
    imagePath= null;
    update();
  }


  //-------------------- function for popscroll, error: always show disclaimer
  bool get hasChanges {
    return titleController.text.trim().isNotEmpty ||
        descriptionController.text.trim().isNotEmpty ||
        selectedtextcolor != apptheme.notetextcolor.first ||
        selectedbackgroundcolor != apptheme.notebackgroundcolor.first;
  }


  //---------------------- function for imagepicker --------------
  Future<void> pickImagefromgallery() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image.path;
      update();
    }
  }

  //---------------------- function for camerapicker --------------
  Future<void> pickImagefromcamera() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePath = image.path;
      update();
    }
  }

  //-------------------------- for changing color mode --------------
  void setColorMode(bool background) {
    isBackground = background;
    update();
  }

}

