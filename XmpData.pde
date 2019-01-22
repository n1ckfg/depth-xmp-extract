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

void imageToXmpSample(String url) {
  xmpParser(imageToInputStream(url));
}

void xmpParser(InputStream imageStream) {
  try {
    try {
      try {
        xmpImageParser(imageStream);  
      } catch (ImageProcessingException eee) { 
        println(eee);
      }
    } catch (XMPException ee) { 
      println(ee);
    }
  } catch (IOException e) { 
    println(e);
  }
}

InputStream imageToInputStream(String url) {
  url = sketchPath() + "/data/" + url;
  println(url);
  BufferedImage origImg;
  try {
    origImg = ImageIO.read(new File(url));
    ByteArrayOutputStream os = new ByteArrayOutputStream();
    ImageIO.write(origImg,"png", os); 
    println("Found bytes of size " + os.toByteArray().length);
    InputStream returns = new ByteArrayInputStream(os.toByteArray());
    return returns;
  } catch (IOException e) { 
    println(e);
  }
  return null;
}

void xmpImageParser(InputStream imageStream) throws XMPException, ImageProcessingException, IOException {
  // Extract metadata from the image
  Metadata metadata = ImageMetadataReader.readMetadata(imageStream);
  for (Directory directory : metadata.getDirectories()) {
    for (Tag tag : directory.getTags()) {
      System.out.println(tag);
    }
  }
  
  // obtain a specific directory
  ExifImageDirectory directory = metadata.getFirstDirectoryOfType(ExifImageDirectory.class);
  
  // create a descriptor
  ExifImageDescriptor descriptor;
  descriptor = new ExifImageDescriptor(directory);
  println(descriptor);
  
  // get tag description
}

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
