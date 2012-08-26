package br.com.marcosoft.dbdesigner;

import java.io.File;
import java.io.IOException;

import org.junit.Test;

import br.com.marcosoft.dbdesigner.model.Database;

public class ParseDatabaseTest {

	@Test
	public void testParse() throws IOException {
		Database parse = new ParseDatabase().parse(getFile("/sgc.dbxml"));
		System.out.println(parse);
	}

    private static File getFile(String filename) throws IOException {
        final String fullname = ParseDatabase.class.getResource(filename).getFile();
        final File file = new File(fullname);
        return file;
    }
}
