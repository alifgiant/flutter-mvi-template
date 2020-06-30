import 'package:aset_ku/core/resources/res_color.dart';
import 'package:aset_ku/core/resources/res_text_style.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/cupertino.dart';

class EmptyScreen extends StatelessWidget {
  final String imagePath;
  final String caption;
  final Color blobColor;
  final List<String> blobIds;

  const EmptyScreen(
    this.imagePath,
    this.caption,
    this.blobIds, {
    Key key,
    this.blobColor,
  }) : super(key: key);

  double getImageMaxSize(BuildContext context) {
    return MediaQuery.of(context).size.height / 4;
  }

  double getContentWidthPadding(BuildContext context) {
    final queryWidthPadding = MediaQuery.of(context).size.width / 3;
    final maxWidthPadding = 100.0;
    return queryWidthPadding <= maxWidthPadding
        ? queryWidthPadding
        : maxWidthPadding;
  }

  @override
  Widget build(BuildContext context) {
    final height = getImageMaxSize(context);
    final width = getContentWidthPadding(context);
    return Container(
      padding: EdgeInsets.all(width),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[createImage(height), createCaption(caption)],
        ),
      ),
    );
  }

  Widget createCaption(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: ResTextStyle.fullPageImageCaption,
    );
  }

  Widget createImage(double height) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Blob.fromID(
          id: blobIds,
          size: height,
          styles: BlobStyles(
            color: blobColor ?? ResColor.darkBlue.withOpacity(0.7),
          ),
        ),
        Image.asset(imagePath, height: height),
      ],
    );
  }
}
