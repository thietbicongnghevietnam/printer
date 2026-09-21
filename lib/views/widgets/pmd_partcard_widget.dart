import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';

class PMDPartCardWidget extends StatefulWidget {
  const PMDPartCardWidget({super.key, this.barcode});
  final PMDBarcode? barcode;

  @override
  State<PMDPartCardWidget> createState() => _PMDPartCardWidgetState();
}

class _PMDPartCardWidgetState extends State<PMDPartCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      height: 185,
      width: double.infinity,
      child:  Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 0, left: 10),
            width: 60,
            height: 60,
            child: Image.asset(Assets.images.qrSample.path),
          ),
          const Padding(padding: EdgeInsets.only(left: 140, top: 20),child: Text('PMG', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), ),
          const Padding(padding: EdgeInsets.only( top: 65),child: Text('PartName', style: TextStyle(fontSize: 10),), ),
          const Padding(padding: EdgeInsets.only( top: 85),child: Text('PartNo', style: TextStyle(fontSize: 10),), ),
          const Padding(padding: EdgeInsets.only( top: 105),child: Text('Qty', style: TextStyle(fontSize: 10),), ),
          const Padding(padding: EdgeInsets.only( top: 125),child: Text('Maker', style: TextStyle(fontSize: 10),), ),
          const Padding(padding: EdgeInsets.only( top: 145),child: Text('Type', style: TextStyle(fontSize: 10),), ),
          const Padding(padding: EdgeInsets.only( top: 165),child: Text('Recycle', style: TextStyle(fontSize: 10),), ),
          Padding(padding: const EdgeInsets.only( top: 85, left:  75),child: Text(widget.barcode?.material ?? '' , style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),), ),
          const Padding(padding: EdgeInsets.only( top: 105, left:  190),child: Text('Pcs' , style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),), ),
          const Padding(padding: EdgeInsets.only( top: 125, left:  190),child: Text('Process' , style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),), ),
          const Padding(padding: EdgeInsets.only( top: 145, left:  190),child: Text('Grade', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),), ),
          const Padding(padding: EdgeInsets.only( top: 165, left:  190),child: Text('Colour', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),), ),
          const Padding(padding: EdgeInsets.only(top: 55), child: Divider( color: Colors.black,),),
          const VerticalDivider(width: 140, color: Colors.black,),
          const Padding(padding: EdgeInsets.only(top: 75), child: Divider( color: Colors.black,),),
          const Padding(padding: EdgeInsets.only(top: 95), child: Divider( color: Colors.black,),),
          const Padding(padding: EdgeInsets.only(top: 115), child: Divider( color: Colors.black,),),
          const Padding(padding: EdgeInsets.only(top: 135), child: Divider( color: Colors.black,),),
          const Padding(padding: EdgeInsets.only(top: 155), child: Divider( color: Colors.black,),),
          const Padding(padding: EdgeInsets.only(top: 102, left: 160), child: VerticalDivider( color: Colors.black,),),
          const Padding(padding: EdgeInsets.only(top: 102, left: 220), child: VerticalDivider( color: Colors.black,),),
        ],
      ),
    );
  }
}
