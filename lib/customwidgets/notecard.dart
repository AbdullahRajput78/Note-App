import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/notesmodel.dart';
import '../theme/theme.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onArchive;

  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onFavorite,
    this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(note.createdAt);
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 6),
      child: GestureDetector(
        onTap: onTap, //  use callback
        child: Container(
          height: height * 0.16,
          decoration: BoxDecoration(
            color: note.backgroundColorValue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: elmsans,
                          color: textcolorblack,
                          fontWeight: elmsbold,
                          fontSize: 19,
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: onFavorite, ///// callback
                          child: Icon(
                            Icons.star,
                            color: note.isFavorite ? starcolor : Colors.grey,
                          ),
                        ),

                        const SizedBox(width: 10),

                        GestureDetector(
                          onTap: onArchive, ////////////./ callback
                          child: Icon(
                            Icons.archive_outlined,
                            color: note.isArchived
                                ? mainthemecolor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Text(
                  note.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontFamily: elmsans,
                    color: textcolorblack,
                    fontWeight: elmssemibold,
                    fontSize: 14,
                  ),
                ),

                const Spacer(),

                Text(
                  DateFormat('h:mm a').format(date),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: elmsans,
                    color: textcolorgrey,
                    fontWeight: elmssemibold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
