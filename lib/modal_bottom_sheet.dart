import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      onDragStart: (DragStartDetails dragStartDetails) {},
      builder: (BuildContext ctx) {
        return Container(
          height: 400,
          child: Text('This is the sheet I wanted'),
        );
      },
    );
  }
}
