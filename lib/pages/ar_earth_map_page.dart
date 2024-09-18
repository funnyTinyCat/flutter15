import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArEarthMapPage extends StatefulWidget {
  const ArEarthMapPage({super.key});

  @override
  State<ArEarthMapPage> createState() => _ArEarthMapPageState();
}

class _ArEarthMapPageState extends State<ArEarthMapPage> {

  ArCoreController? augmentedRealityCoreController;


  augmentedRealityViewCreated(ArCoreController coreController)
  {

    augmentedRealityCoreController = coreController;

    displayEarthMapSphere(augmentedRealityCoreController!);
  }

  displayEarthMapSphere(ArCoreController? coreController) async {

    final ByteData earthTextureBytes = await rootBundle.load("images/earth_map.jpg");

    final materials = ArCoreMaterial(

      color: Colors.blue,
      textureBytes: earthTextureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(

      materials: [materials],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5 ),
    );

    augmentedRealityCoreController!.addArCoreNode(node);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AR Earth Map"
        ),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}