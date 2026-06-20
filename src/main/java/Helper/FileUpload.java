package Helper;

import java.io.FileOutputStream;
import java.io.InputStream;

//import Model.Service_insert;
import jakarta.servlet.http.Part;

public class FileUpload {


	public static String Image_upload (Part image, String uploadDir)
{
    String image_name = image.getSubmittedFileName();
    java.io.File dir = new java.io.File(uploadDir);
    if (!dir.exists()) {
        dir.mkdirs();
    }
    String upload_path = uploadDir + java.io.File.separator + image_name;
//		System.out.println(upload_path);
//		System.out.println("ok");
		byte data []=null;
		try
		{
			FileOutputStream fout = new FileOutputStream(upload_path);
			InputStream is = image.getInputStream();
			 data= new byte[is.available()];
			is.read(data);
			fout.write(data);
		
		
			
		}
		catch (Exception e) {
			System.out.println("image exp="+e);
		}
		return image_name;
	}
	
	
	
}