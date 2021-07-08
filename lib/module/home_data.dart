import 'package:flutter/cupertino.dart';

class HomeData {
  final int key;
  final String name;
  final String branchandYear;
  final String profileImage;
  final String description;
  final String image;

  HomeData(this.key, this.name, this.branchandYear, this.profileImage,
      this.description, this.image);
}

class HomeDataProvider with ChangeNotifier {
  final List<HomeData> _data = [
    HomeData(
      1,
      'Deepak kumar',
      'CSE batch A passout 2021',
      'assets/profile1.jpg',
      ' I can come up with is to downgrade the flutter SDK.If you are using VS code then you easily switch between flutter SDKs from the bottom bar.To add flutter SDK -Goto file -> settings -> flutter SDK -> Add itemthen you can give the path of other SDK.If you are not using the VS code, change the path of SDK from environment variables.If this does not work out, try changing the drive for SDK of flutter and android both.Example- From D:\flutter to E:\flutter. I have not tried this but for my friend, it worked.If none of these workes, just ignore this error. They might fix this in future upgrades.',
      'assets/example.jpg',
    ),
    HomeData(
      2,
      'Nitesh kumar',
      'ECE batch B passout 2021',
      'assets/profile2.jpg',
      'Have also faced the same issue. It started coming when I upgraded the flutter SDK to version 1.17.3. The easiest solution I can come up with is to downgrade the flutter SDK.If you are using VS code then you easily switch between flutter SDKs from the bottom bar.To add flutter SDK -Goto file -> settings -> flutter SDK -> Add itemthen you can give the path of other SDK.If you are not using the VS code, change the path of SDK from environment variables.If this does not work out, try changing the drive for SDK of flutter and android both.Example- From D:\flutter to E:\flutter. I have not tried this but for my friend, it worked.If none of these workes, just ignore this error. They might fix this in future upgrades.',
      'assets/secondpage.png',
    ),
    HomeData(
      3,
      'Rahul Gupta',
      'CSE batch B passout 2021',
      'assets/profile1.jpg',
      '  I have also faced the same issue. It started coming when I upgraded the flutter SDK to version 1.17.3. The easiest solution I can come up with is to downgrade the flutter SDK.If you are using VS code then you easily switch between flutter SDKs from the bottom bar.To add flutter SDK -Goto file -> settings -> flutter SDK -> Add itemthen you can give the path of other SDK.If you are not using the VS code, change the path of SDK from environment variables.If this does not work out, try changing the drive for SDK of flutter and android both.Example- From D:\flutter to E:\flutter. I have not tried this but for my friend, it worked.If none of these workes, just ignore this error. They might fix this in future upgrades.',
      'assets/example.jpg',
    ),
    HomeData(
      4,
      'Mohmmad Sharukh khan',
      'CSE batch A passout 2021',
      'assets/profile2.jpg',
      'Text form that has been written by use workes, just ignore this error. They might fix this in future upgrades.',
      'assets/thirdpage.png',
    ),
  ];
  List<HomeData> get data {
    return [..._data];
  }
}
