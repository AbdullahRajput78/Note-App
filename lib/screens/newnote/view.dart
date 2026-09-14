import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';
import 'logic.dart';

class NewnotePage extends StatelessWidget {
  NewnotePage({Key? key}) : super(key: key);

  final NewnoteLogic logic = Get.put(NewnoteLogic());

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
    return  PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          if (!logic.hasChanges){
            Get.back();
            return;
          }

          final shouldLeave = await Get.dialog<bool>(
            AlertDialog(
              title: const Text("Discard Note?"),
              content: const Text(
                "Your changes will be lost.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );

          if (shouldLeave == true) {
            logic.clearFields();

            if (Get.isRegistered<NewnoteLogic>()) {
              Get.delete<NewnoteLogic>();
            }

            Get.back();
          }
        },

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GetBuilder<NewnoteLogic>(builder: (logic) {
          final colors = logic.isBackground
              ? apptheme.notebackgroundcolor
              : apptheme.notetextcolor;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 23, right: 23, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(

                            onTap: () async {

                              if (logic.titleController.text.isEmpty &&
                                  logic.descriptionController.text.isEmpty) {
                                logic.clearFields();
                                Get.back();
                                return;
                              }

                              final result = await Get.dialog<bool>(
                                AlertDialog(
                                  title: const Text("Discard note?"),
                                  content: const Text("Your changes will be lost."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back(result: false);
                                      },
                                      child: const Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back(result: true);
                                      },
                                      child: const Text("Yes"),
                                    ),
                                  ],
                                ),
                              );

                              if (result == true) {
                                logic.clearFields();
                                Get.back();
                              }
                              // If result == false or null, do nothing.

                          },
                          child: Icon(Icons.close, size: 20,)),

                      Text('My Notes', style:
                      TextStyle(
                          fontFamily: elmsans,
                          fontWeight: elmsbold,
                          fontSize: 20,
                          color: textcolorblack
                      ),),


                      TextButton(
                        onPressed: () {
                          logic.saveNote();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: mainthemecolor,
                        ),
                        child: Text("Save",style: TextStyle(fontSize: 15),),
                      ),
                    ],),

                  SizedBox(height: height * 0.02),

            //--------------------------------- Row 2 for form text field --------------------
                  TextField(
                    controller: logic.titleController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: 'Enter note title',
                      // labelText: 'Title',
                      filled: true,
                      fillColor: Colors.grey[200],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.4,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),

                  SizedBox(height: height * 0.01),


                  SizedBox(
                    height: height * 0.60,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.4,
                        ),
                      ),
                      child: Column(
                        children: [

                          Expanded(
                            child: TextField(
                              controller: logic.descriptionController,
                              expands: true,
                              maxLines: null,
                              minLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                hintText: 'Write Something....',
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          if (logic.imagePath != null) ...[
                            SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(logic.imagePath!),
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),


                  // SizedBox(height: height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              logic.setColorMode(true);
                            },
                            icon: Icon(
                              Icons.palette,
                              size: 23,
                              color: logic.isBackground ? mainthemecolor : Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              logic.setColorMode(false);
                            },
                            icon: Icon(
                              Icons.text_fields,
                              size: 23,
                              color: !logic.isBackground ? mainthemecolor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                     Row(children: [
                       IconButton(
                         onPressed: () {
                           logic.pickImagefromcamera();
                         },
                         icon:  Icon(Icons.camera_alt_outlined, size: 23),
                       ),
                       IconButton(
                         onPressed: () {
                           logic.pickImagefromgallery();
                         },
                         icon:  Icon(Icons.image_outlined, size: 23),
                       ),
                     ],)
                    ],
                  ),
                  Text('Colors', style:
                  TextStyle(
                      fontFamily: elmsans,
                      fontWeight: elmssemibold,
                      fontSize: 18,
                      color: textcolorblack
                  ),),

              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          logic.selectedcolor(colors[index]);
                         /////////////////// color adding later here
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: colors[index],
                          child: (logic.isBackground
                              ? logic.selectedbackgroundcolor
                              : logic.selectedtextcolor) ==
                              colors[index]
                              ?  Icon(
                            Icons.check,
                            color: logic.isBackground? Colors.black:
                            Colors.white,
                            size: 18,
                          )
                              : null,
                        ),
                        )
                      );
                  },
                ),
              )

                ],
              ),
            ),
          );
        })
    )
    );
  }
}
