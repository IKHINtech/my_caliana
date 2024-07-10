import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_caliana/const/colors.dart';
import 'package:my_caliana/views/identitas_screen.dart';
import 'package:my_caliana/widgets/clock.dart';
import 'package:my_caliana/widgets/custom_text.dart';
import 'package:my_caliana/widgets/custom_text_fields.dart';
import 'package:my_caliana/widgets/rounded_button.dart';
import 'package:permission_handler/permission_handler.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);
  Future<void> _checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    if (!locationStatus.isGranted) {
      await Permission.location.request();
    }
  }

  final TextEditingController _searchController = TextEditingController();
  ValueNotifier<int> _selectedFilter = ValueNotifier<int>(0);

  var renderOverlay = true;
  var visibled = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);

  @override
  void initState() {
    _checkPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        surfaceTintColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 16),
          child: Image.asset('assets/images/icon-removebg-preview.png'),
        ),
        actions: [
          // Container(
          //   color: Colors.red,
          //   child: Text(
          //     'recruitment',
          //     style: TextStyle(color: customGrey, fontSize: 16),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Container(
                  transform: Matrix4.translationValues(4.0, 0.0, 0.0),
                  padding:
                      EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: LimitedLengthText(
                    text: "recruitment",
                    maxLength: 8,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white, // Warna border
                      width: 2.0, // Lebar border
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(right: 16),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 30,
                    color: customGrey,
                  ),
                ),
              ))
        ],
      ),
      body: Container(
        color: bgGrey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Clock(),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: customTextField(
                          isBorder: false,
                          controller: _searchController,
                          hint: "Cari",
                          prefixIcon: Icon(Icons.search),
                          required: false,
                          onSaved: (val) {}),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fitur",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 32,
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _selectedFilter,
                            builder: (context, value, child) => Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [filterWidget(value)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 100,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        mainAxisSpacing:
                            8.0, // Jarak antara elemen dalam satu baris
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1,
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(TablerIcons.chart_histogram,
                                      color: customGrey),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Text(
                                    "Dashboard",
                                    style: TextStyle(
                                        fontSize: 12, color: customGrey),
                                  )
                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(TablerIcons.address_book,
                                      color: customGrey),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Text(
                                    "Daftar Pengunjung",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12, color: customGrey),
                                  )
                                ]),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _selectedFilter,
                            builder: (context, value, child) {
                              if (value != 2) {
                                return Container(
                                  padding: EdgeInsets.all(3),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(TablerIcons.home_heart,
                                            color: customGrey),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Text(
                                          "Residen",
                                          style: TextStyle(
                                              fontSize: 12, color: customGrey),
                                        )
                                      ]),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hari ini",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tidak ada pengunjung",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: customGrey),
                            ),
                            Text(
                              "Daftar pengunjung akan ditampilkan disini.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: customGrey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RoundedButton(
                                      title: "Refresh",
                                      isMain: false,
                                      isSmal: true,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        icon: Icons.add,
        spacing: 2,
        mini: mini,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        buttonSize: buttonSize,
        label: extend ? const Text("Open") : null,
        activeLabel: extend ? const Text("Close") : null,
        childrenButtonSize: childrenButtonSize,
        visible: visibled,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,
        closeManually: closeManually,
        renderOverlay: renderOverlay,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        useRotationAnimation: useRAnimation,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        children: [
          SpeedDialChild(
            shape: CircleBorder(),
            child: !rmicons
                ? const Icon(
                    TablerIcons.file_plus,
                    size: 20,
                  )
                : null,
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue[500],
            label: 'Pra Registrasi',
            visible: true,
            onTap: () async {},
          ),
          SpeedDialChild(
            shape: CircleBorder(),
            child: !rmicons
                ? const Icon(
                    TablerIcons.file_certificate,
                    size: 20,
                  )
                : null,
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue[500],
            label: 'Registrasi',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IdentitasScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipPath(
        clipper: MyBottomAppBarClipper(),
        child: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          height: 70,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: mainColor,
                    ),
                    height: 3,
                    width: 80,
                  ),
                  Expanded(
                      flex: 2,
                      child: Icon(
                        TablerIcons.home,
                        color: mainColor,
                      )),
                  Expanded(
                    child: Text(
                      "Beranda",
                      style: TextStyle(color: mainColor),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.transparent,
                    ),
                    height: 3,
                    width: 80,
                  ),
                  Expanded(
                      flex: 2,
                      child: Icon(
                        TablerIcons.ticket,
                        color: customGrey,
                      )),
                  Expanded(
                    child: Text(
                      "Tiket",
                      style: TextStyle(color: customGrey),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell fiturFilterButton(VoidCallback? onTap, String title, bool isActive) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isActive ? Colors.blue[50] : Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 13),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.blue : customGrey),
        ),
      ),
    );
  }

  ListView filterWidget(int value) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        width: 8,
      ),
      itemCount: 3,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return index == 0
            ? fiturFilterButton(() {
                _selectedFilter.value = 0;
              }, "Semua Fitur", value == 0)
            : index == 1
                ? fiturFilterButton(() {
                    _selectedFilter.value = 1;
                  }, "Visitor Management Sistem", value == 1)
                : fiturFilterButton(() {
                    _selectedFilter.value = 2;
                  }, "Access Control System", value == 2);
      },
    );
  }
}

class MyBottomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double notchRadius = 24.0;
    path.moveTo(0, notchRadius);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, notchRadius);
    path.arcToPoint(
      Offset(size.width - notchRadius, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(notchRadius, 0);
    path.arcToPoint(
      Offset(0, notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
