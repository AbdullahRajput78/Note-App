import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/notesmodel.dart';
import '../home/logic.dart';
import 'package:pdf/widgets.dart' as pw;

class DescriptionLogic extends GetxController {
  final homeLogic = Get.find<NotesLogic>();
  final NoteModel note = Get.arguments;

  // -------------------- function for delete note ----------
  void deleteCurrentNote() {
    homeLogic.deleteNote(note);
    Get.back();
  }

  void toggleFavorite() {
    homeLogic.toggleFavorite(note);
    update();
  }

  //--------------- function for pdf saving -----------------------
  Future<void> shareNoteAsPdf(NoteModel note, {String? fileName}) async {
    try {
      final pdf = pw.Document();

      // ---------------- load image bytes if the note has one ----------------
      pw.MemoryImage? pdfImage;
      if (note.imagePath != null && note.imagePath!.isNotEmpty) {
        final imageFile = File(note.imagePath!);
        final exists = await imageFile.exists();
        debugPrint('Image path: ${note.imagePath} | exists: $exists');

        if (exists) {
          final bytes = await imageFile.readAsBytes();
          try {
            pdfImage = pw.MemoryImage(bytes);
          } catch (imgErr) {
            debugPrint('Image decode failed: $imgErr');
          }
        }
      }

      // ---------------- format the date nicely ----------------
      final formattedDate = DateFormat('MMMM d, yyyy - h:mm a')
          .format(DateTime.parse(note.createdAt));

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  note.title,
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Text(
                  note.description,
                  style: const pw.TextStyle(fontSize: 14),
                ),

                if (pdfImage != null) ...[
                  pw.SizedBox(height: 16),
                  pw.ClipRRect(
                    horizontalRadius: 8,
                    verticalRadius: 8,
                    child: pw.Image(
                      pdfImage,
                      width: context.page.pageFormat.availableWidth,
                      fit: pw.BoxFit.contain,
                    ),
                  ),
                ],

                pw.SizedBox(height: 20),
                pw.Text(
                  'Created: $formattedDate',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey,
                  ),
                ),
              ],
            );
          },
        ),
      );

      // ---------------- build a safe, custom file name ----------------
      final rawName = (fileName ?? note.title).trim();
      final baseName = rawName.isEmpty ? 'note' : rawName;
      final safeName = baseName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$safeName.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Shared from My Notes app',
      );
    } catch (e, stack) {
      debugPrint('PDF share error: $e');
      debugPrint(stack.toString());
      Get.snackbar(
        'Error',
        'Could not create PDF. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}