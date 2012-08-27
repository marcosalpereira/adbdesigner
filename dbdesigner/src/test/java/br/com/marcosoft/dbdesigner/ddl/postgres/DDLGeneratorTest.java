package br.com.marcosoft.dbdesigner.ddl.postgres;

import java.io.IOException;

import org.junit.Test;

import br.com.marcosoft.dbdesigner.ParseDatabase;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.util.FileUtil;

public class DDLGeneratorTest {

	@Test
	public void testGenerate() throws IOException {
		final Database db = loadDatabase();
		final StringBuilder out = new StringBuilder();
		new DDLGenerator(out).generate(db.getTables());
		System.out.println(out.toString());
	}

	private Database loadDatabase() throws IOException {
	    return new ParseDatabase().parse(FileUtil.getFile("/sgc.db.xml"));
    }

}
