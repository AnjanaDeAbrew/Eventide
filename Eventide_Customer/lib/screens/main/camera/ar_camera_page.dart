import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:eventide_app/components/custom_text_poppins.dart';
import 'package:eventide_app/screens/main/camera/list_item.dart';
import 'package:eventide_app/utils/app_colors.dart';
import 'package:eventide_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARCamera extends StatefulWidget {
  const ARCamera({super.key});

  @override
  State<ARCamera> createState() => _ARCameraState();
}

class _ARCameraState extends State<ARCamera> {
  late ArCoreController arCoreController;
  late String objectSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.black),
          title: const CustomText(
            'Place your camera to view items',
            fontSize: 15,
            color: AppColors.black,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                UtilFunction.goBack(context);
              },
              icon: const Icon(Icons.close))),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ListItems(
              onTap: (value) {
                objectSelected = value;
              },
            ),
          )
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => removeObject(name);
    arCoreController.onPlaneTap = handleOnPlaneTap;
  }

  void handleOnPlaneTap(List<ArCoreHitTestResult> hitsResults) {
    final hit = hitsResults.first;
    addObject(hit);
  }

  removeObject(String name) {
    arCoreController.removeNode(nodeName: name);
  }

  Future addObject(ArCoreHitTestResult plane) async {
    final bytes = (await rootBundle.load(objectSelected)).buffer.asUint8List();
    final objectNodde = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 270, height: 240),
      position: plane.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: plane.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );
    arCoreController.addArCoreNodeWithAnchor(objectNodde);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
