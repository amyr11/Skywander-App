import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DestinationCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Function() onTap;

  const DestinationCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  Future<Color> getProminentColor(ImageProvider imageProvider) async {
    // Generate a PaletteGenerator from the image
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

    // Get the dominant color from the PaletteGenerator
    Color prominentColor =
        paletteGenerator.dominantColor?.color ?? Colors.black;

    // Darken the color if it's too light so that the text is readable
    int shift = 90;
    prominentColor = Color.fromRGBO(
      prominentColor.red - shift,
      prominentColor.green - shift,
      prominentColor.blue - shift,
      1,
    );

    return prominentColor;
  }

  @override
  Widget build(BuildContext context) {
    Color prominentColor = Colors.transparent;

    double width = 200;
    double height = 200;

    Image image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          image,
          FutureBuilder<Color>(
            future: getProminentColor(NetworkImage(imageUrl)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                prominentColor = Colors.transparent;
              } else if (snapshot.hasError) {
                prominentColor = Colors.black87;
              } else {
                prominentColor = snapshot.data!;
              }

              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, prominentColor],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
