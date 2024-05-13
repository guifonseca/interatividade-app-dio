import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? _photo;

  void cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      _photo = XFile(croppedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Câmera"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_photo == null)
            Container()
          else
            Center(
                child: SizedBox(
                    width: 250, child: Image.file(File(_photo!.path)))),
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const FaIcon(FontAwesomeIcons.camera),
                          title: const Text("Câmera"),
                          onTap: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                              () => Navigator.pop(context),
                            );
                            final ImagePicker picker = ImagePicker();
                            _photo = await picker.pickImage(
                                source: ImageSource.camera);
                            if (_photo != null) {
                              String path = (await path_provider
                                      .getApplicationDocumentsDirectory())
                                  .path;
                              await _photo!.saveTo("$path/${_photo!.name}");
                              cropImage(_photo!);
                            }
                          },
                        ),
                        ListTile(
                          leading: const FaIcon(FontAwesomeIcons.images),
                          title: const Text("Galeria"),
                          onTap: () async {
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                              () => Navigator.pop(context),
                            );
                            final ImagePicker picker = ImagePicker();
                            _photo = await picker.pickImage(
                                source: ImageSource.gallery);
                            cropImage(_photo!);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: const Text("Câmera")),
        ],
      ),
    ));
  }
}
