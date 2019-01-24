import com.adobe.xmp.*;
import com.drew.imaging.*;
import com.drew.metadata.*;
import java.io.*;
import javax.imageio.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

// https://developers.google.com/depthmap-metadata/encoding
// https://www.codeproject.com/Articles/991837/Googles-Depth-Map
// https://developers.google.com/depthmap-metadata/reference
// https://github.com/drewnoakes/metadata-extractor/wiki/Getting-Started-(Java)

byte[] bytes;
int byteSize = 0;

PImage imageToXmpData(String url) {
  return xmpParser(imageToInputStream(url, "jpg"));
}

PImage xmpParser(InputStream imageStream) {
  try {
    try {
      try {
        return xmpImageParser(imageStream);  
      } catch (ImageProcessingException eee) { 
        println(eee);
      }
    } catch (XMPException ee) { 
      println(ee);
    }
  } catch (IOException e) { 
    println(e);
  }
  return null;
}

InputStream imageToInputStream(String url, String imgType) {
  url = sketchPath() + "/data/" + url;
  println(url);
  BufferedImage origImg;
  try {
    origImg = ImageIO.read(new File(url));
    ByteArrayOutputStream os = new ByteArrayOutputStream();
    ImageIO.write(origImg, imgType, os); 
    bytes = os.toByteArray();
    byteSize = bytes.length;
    println("Raw bytes: " + bytes.length + " " + bytes[10000]);
    InputStream returns = new ByteArrayInputStream(bytes);
    return returns;
  } catch (IOException e) { 
    println(e);
  }
  return null;
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
byte[] extractSegment(byte[] segmentBytes, Metadata metadata, JpegSegmentType segmentType) {
  for (XmpDirectory directory : metadata.getDirectoriesOfType(XmpDirectory.class)) {
    // XMP in a JPEG file has a 29 byte preamble which is not valid XML.
    final int preambleLength = 29;

    ByteArrayReader reader = new ByteArrayReader(segmentBytes);

    String preamble = new String(segmentBytes, 0, preambleLength);

    byte[] xmlBytes = new byte[segmentBytes.length - preambleLength];
    println("!!!!" + xmlBytes.length);
    System.arraycopy(segmentBytes, 29, xmlBytes, 0, xmlBytes.length);
    if (xmlBytes.length > 0) return xmlBytes;
  }
  return null;
}

PImage xmpImageParser(InputStream imageStream) throws XMPException, ImageProcessingException, IOException {
  Metadata metadata = ImageMetadataReader.readMetadata(imageStream);
  byte[] xmlBytes = new byte[byteSize];
  
  return imageFromBytes(extractSegment(xmlBytes, metadata, null));
}

// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

/**
 * Shows basic extraction and iteration of XMP data.
 * <p>
 * For more information, see the project wiki: https://github.com/drewnoakes/metadata-extractor/wiki/GettingStarted
 *
 * @author Drew Noakes https://drewnoakes.com
 */

void xmpExampleParser(InputStream imageStream) throws XMPException, ImageProcessingException, IOException {

  // Extract metadata from the image
  Metadata metadata = ImageMetadataReader.readMetadata(imageStream);

  // Iterate through any XMP directories we may have received
  for (XmpDirectory xmpDirectory : metadata.getDirectoriesOfType(XmpDirectory.class)) {
    // Usually with metadata-extractor, you iterate a directory's tags. However XMP has
    // a complex structure with many potentially unknown properties. This doesn't map
    // well to metadata-extractor's directory-and-tag model.
    //
    // If you need to use XMP data, access the XMPMeta object directly.
    XMPMeta xmpMeta = xmpDirectory.getXMPMeta();

    XMPIterator itr = xmpMeta.iterator();

    // Iterate XMP properties
    while (itr.hasNext()) {
      XMPPropertyInfo property = (XMPPropertyInfo) itr.next();
      // Print details of the property
      println(property.getPath() + ": " + property.getValue());
    }
  }
}
