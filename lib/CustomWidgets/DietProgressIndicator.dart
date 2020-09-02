import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DietProgressIndicator extends StatefulWidget {
  final boxCount;
  List<Color> colors;
  DietProgressIndicator(this.boxCount, this.colors);
  @override
  _DietProgressIndicatorState createState() => _DietProgressIndicatorState();
}

class _DietProgressIndicatorState extends State<DietProgressIndicator> {
  List<Widget> getBoxes(){
    List<Widget> boxes = [];
    for(int i=0; i< widget.boxCount; i++){
      boxes.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container( child: SizedBox(height: 20, width: 20,), color: i>=widget.colors.length?Colors.white70:widget.colors[i],),
      ));
    }
    return boxes;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: getBoxes(),
      ),
    );
  }
}
