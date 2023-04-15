import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LocalAndWebObjectsView extends StatefulWidget {
  const LocalAndWebObjectsView({Key? key}) : super(key: key);

  @override
  State<LocalAndWebObjectsView> createState() => _LocalAndWebObjectsViewState();
}

class _LocalAndWebObjectsViewState extends State<LocalAndWebObjectsView> {

  late ARObjectManager arObjectManagerx;
  bool nodeAdded=false;
  late ARNode node;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local / Web Objects"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  color: Colors.red,
                  child: ARView(onARViewCreated: (ARSessionManager arSessionManager, ARObjectManager arObjectManager, ARAnchorManager arAnchorManager, ARLocationManager arLocationManager) {
                    // arSessionManager.onInitialize(customPlaneTexturePath: "triangle.png",showFeaturePoints: false,showPlanes: true,showWorldOrigin: true,handleTaps: false);
                    arObjectManager.onInitialize();
                    arObjectManagerx=arObjectManager;
                  },),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        //TODO
                        if(nodeAdded){
                          arObjectManagerx.removeNode(node);
                        }
                        node=ARNode(
                          type: NodeType.localGLTF2,
                          uri: "assets/Chicken_01/Chicken_01.gltf",
                          position: vector.Vector3(0.0,0.0,-0.5),
                          scale: vector.Vector3(0.1, 0.1, 0.1),
                          rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0)
                        );
                        arObjectManagerx.addNode(node);
                        nodeAdded=true;
                        setState(() {
                        });
                      },
                      child: const Text("Add / Remove Local Object")),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text("Add / Remove Web Object")),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
