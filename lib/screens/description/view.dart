import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../datechanger.dart';
import '../../theme/theme.dart';
import '../newnote/logic.dart';
import '../newnote/view.dart';
import 'logic.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({Key? key}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final DescriptionLogic logic = Get.put(DescriptionLogic());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return GetBuilder<DescriptionLogic>(builder: (logic) {

      return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: logic.note.backgroundColorValue,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 23, right: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        }, child: Icon(Icons.arrow_back_ios_new)),
                    Row(
                      spacing: 15,
                      children: [

                        GetBuilder<DescriptionLogic>(
                          builder: (logic) {
                            return GestureDetector(
                              onTap: () {
                                logic.toggleFavorite();
                              },
                              child: Icon(
                                Icons.star,
                                color: logic.note.isFavorite
                                    ? starcolor
                                    : Colors.grey,
                              ),
                            );
                          },
                        ),
                        Icon(Icons.menu)
                      ],),
                  ],
                ),
              ),
              // SizedBox(height: height*0.10,),
              Padding(
                padding: const EdgeInsets.only(
                    left: 23, right: 23, top: 50, bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(logic.note.title, style: TextStyle(
                        color: Colors.black,
                        fontFamily: elmsans,
                        fontWeight: elmsbold,
                        fontSize: 18
                    ),),
                    Text(DateHelper.timeAgo(logic.note.createdAt),
                      style: TextStyle(
                          color: textcolorgrey,
                          fontFamily: elmsans,
                          fontWeight: elmsbold,
                          fontSize: 15
                      ),),
                  ],),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 28, left: 23, right: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          height: height * 0.52,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  logic.note.description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: logic.note.textColorValue,
                                  ),
                                ),

                                if (logic.note.imagePath != null) ...[
                                  const SizedBox(height: 20),

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(logic.note.imagePath!),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],

                              ],
                            ),
                          )
                        ),

/////////////////////////////////////////////// last container
                        SizedBox(height: height * 0.005,),
                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _showRenameDialog(context, logic);

                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.ios_share, color: Colors.black87,
                                        size: 22),
                                    SizedBox(height: 4),
                                    Text("Share", style: TextStyle(
                                        fontSize: 12, color: Colors.black87)),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  if (Get.isRegistered<NewnoteLogic>()) {
                                    Get.delete<NewnoteLogic>();
                                  }
                                  Get.to(() => NewnotePage(),
                                    arguments: logic.note,);
                                  // logic.update();

                                }, child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.edit_outlined,
                                      color: Colors.black87, size: 22),
                                  SizedBox(height: 4),
                                  Text("Edit", style: TextStyle(
                                      fontSize: 12, color: Colors.black87)),
                                ],
                              ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  // function call here ---------------
                                  logic.deleteCurrentNote();
                                  Get.rawSnackbar(
                                    messageText: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.redAccent,
                                                Colors.red.shade600,
                                                Colors.red.shade900
                                              ],
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.delete_forever,
                                              color: Colors.white, size: 20),
                                        ),
                                        SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
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
                                                "Your note has been deleted",
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
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: EdgeInsets.all(14),
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: true,
                                    dismissDirection: DismissDirection
                                        .horizontal,
                                    duration: Duration(seconds: 2),
                                    animationDuration: Duration(
                                        milliseconds: 500),
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
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.delete_outline,
                                        color: Colors.black87, size: 22),
                                    SizedBox(height: 4),
                                    Text("Delete", style: TextStyle(
                                        fontSize: 12, color: Colors.black87)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              )
            ],
          )
      );
    });

  }
  void _showRenameDialog(BuildContext context, DescriptionLogic logic) {
    final controller = TextEditingController(text: logic.note.title);

    Get.defaultDialog(
      title: 'Save PDF as',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter file name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      textConfirm: 'Share',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // close dialog
        logic.shareNoteAsPdf(logic.note, fileName: controller.text);
      },
    );
  }
}
