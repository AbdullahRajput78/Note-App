import 'package:get/get.dart';

import '../archive/view.dart';
import '../favourite/view.dart';
import '../home/view.dart';
import '../profile/view.dart';



class NavigationLogic extends GetxController {
  List pages =[
    HomeView(),
    FavouritePage(),
    ArchivePage(),
    ProfilePage()
  ];

  var selectedindex =0.obs;


}
