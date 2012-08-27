package br.com.marcosoft.dbdesigner.util;

import java.io.File;
import java.io.IOException;

public class FileUtil {

    public static File getFile(String filename) throws IOException {
        final String fullname = FileUtil.class.getResource(filename).getFile();
        final File file = new File(fullname);
        return file;
    }

}
