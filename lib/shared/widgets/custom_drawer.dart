import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interatividadeapp/pages/battery/battery_page.dart';
import 'package:interatividadeapp/pages/camera/camera_page.dart';
import 'package:interatividadeapp/pages/connectivity_plus/connectivity_plus_page.dart';
import 'package:interatividadeapp/pages/gps/geolocator_page.dart';
import 'package:interatividadeapp/pages/qr_code/qr_code_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:device_info_plus/device_info_plus.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            currentAccountPicture: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Camera"),
                        leading: const Icon(Icons.camera),
                      ),
                      ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.folder))
                    ],
                  ),
                );
              },
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                      "https://hermes.digitalinnovation.one/assets/diome/logo.png")),
            ),
            accountName: const Text("Guilherme Santos"),
            accountEmail: const Text("email@email.com")),
        InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BatteryPage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.batteryHalf, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Indicador da bateria"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              await launchUrl(Uri.parse('https://dio.me'));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.internetExplorer,
                        color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Abrir DIO"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              await launchUrl(
                  Uri.parse('google.navigation:q=Orlando FL&mode=d'));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.mapLocationDot, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Abrir no Mapa"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              Share.share("Olhem este site, que legal! https://dio.me");
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.shareNodes, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Compartilhar"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              var tempDir = await path_provider.getTemporaryDirectory();
              print(tempDir.path);
              tempDir = await path_provider.getApplicationSupportDirectory();
              print(tempDir.path);
              tempDir = await path_provider.getApplicationDocumentsDirectory();
              print(tempDir.path);
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.solidFolder, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Path"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              String appName = packageInfo.appName;
              String packageName = packageInfo.packageName;
              String version = packageInfo.version;
              String buildNumber = packageInfo.buildNumber;

              print(appName);
              print(packageName);
              print(version);
              print(buildNumber);
              print(Platform.operatingSystem);
              print(Platform.operatingSystemVersion);
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.appStoreIos, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Informações Pacote"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

              if (Platform.isAndroid) {
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
              } else if (Platform.isIOS) {
                IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                print(
                    'Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
              } else {
                WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
                print(
                    'Running on ${webBrowserInfo.userAgent}'); // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
              }
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.robot, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Informações Dispositivo"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConnectivityPlusPage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.wifi, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Conexão"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GeolocatorPage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.mapPin, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("GPS"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QrCodePage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.qrcode, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("QR Code"),
                  ],
                ))),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CameraPage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                child: const Row(
                  children: [
                    FaIcon(FontAwesomeIcons.camera, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Câmera"),
                  ],
                ))),
      ]),
    );
  }
}
