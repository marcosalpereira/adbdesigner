package br.com.marcosoft.dbdesigner;

import java.io.IOException;

import org.junit.Test;

import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.util.FileUtil;

public class ParseDatabaseTest {

	@Test
	public void testParse() throws IOException {
		final Database parse = new ParseDatabase().parse(FileUtil.getFile("/sgc.dbxml"));
		System.out.println(parse);
	}

}
