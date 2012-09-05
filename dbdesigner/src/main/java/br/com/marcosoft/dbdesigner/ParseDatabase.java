package br.com.marcosoft.dbdesigner;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.helpers.DefaultHandler;

import br.com.marcosoft.dbdesigner.model.Association;
import br.com.marcosoft.dbdesigner.model.Column;
import br.com.marcosoft.dbdesigner.model.Database;
import br.com.marcosoft.dbdesigner.model.Index;
import br.com.marcosoft.dbdesigner.model.Restriction;
import br.com.marcosoft.dbdesigner.model.Table;

public class ParseDatabase {
	private Database database;
	private Table table;
	private Column column;
	private File file;
	private final Map<String, String> map = new HashMap<String, String>();

	{
		map.put("public.questao_cartao_resposta","4226,356");
		map.put("public.vaga","4205,2167");
		map.put("public.usuario","4652,2671");
		map.put("public.uf_estrutura","4279,2650");
		map.put("public.uf","3752,2538");
		map.put("public.orgao_contratante","5292,2447");
		map.put("public.orgao_concurso","5329,1668");
		map.put("public.local_prova","3505,2029");
		map.put("public.estrutura","4622,2533");
		map.put("public.concurso","3971,1463");
		map.put("public.vistoria_local_prova","3530,1791");
		map.put("public.cidades_concurso","3890,1944");
		map.put("public.cidade","3845,2130");
		map.put("public.cargo","4899,2347");
		map.put("public.campo_orgao","5042,2040");
		map.put("public.oferta_cargo_concurso","4139,1916");
		map.put("public.campo_atuacao","4709,2182");
		map.put("public.disciplina_prova_objetiva","2489,411");
		map.put("public.localidade_prova_inscricao","2147,3067");
		map.put("public.motivo_indeferimento","2666,2134");
		map.put("public.vistoria_local_prova_item","3715,1603");
		map.put("public.inscricao_historico_localidade","2727,2256");
		map.put("public.inscricao_tratamento_diferenciado","4955,1103");
		map.put("public.tratamento_diferenciado","4936,871");
		map.put("public.questao_correlata","1798,1740");
		map.put("public.gabarito_correlato","1752,1570");
		map.put("public.gabarito_chave","1767,1363");
		map.put("public.nota_habilitacao","3937,89" );
		map.put("public.nota_questao","3470,62" );
		map.put("public.nota_titulo","3473,700");
		map.put("public.resultado_prova_manual","3930,479");
		map.put("public.inscricao","3167,2284");
		map.put("public.ordenacao_disciplina_gabarito","2710,1419");
		map.put("public.gabarito_prova","2580,1187");
		map.put("public.questao_gabarito","2256,1455");
		map.put("public.parecer","770,1448");
		map.put("public.registro_importacao_cartao","349,2174");
		map.put("public.questao_cartao_processado","408,1734");
		map.put("public.cartao_importacao_processado","32,1839" );
		map.put("public.erro_importacao_cartao","5,2253"  );
		map.put("public.diverg_fec_concurso_inscricao","4687,110");
		map.put("public.diverg_fec_localidade_inscricao","5793,18" );
		map.put("public.arquivo_anexo","6,248"   );
		map.put("public.erro_arquivo_pagamento","2387,2650");
		map.put("public.arquivo_pagamento","2788,2864");
		map.put("public.anexo_local_prova","3053,2188");
		map.put("public.arquivo_mds_inscricao","4757,3061");
		map.put("public.arquivo_mds","4919,2843");
		map.put("public.visao_candidato","4218,1008");
		map.put("public.localidade_prova_alocacao","2469,3019");
		map.put("public.historico_status_alocacao","2455,3270");
		map.put("public.alocacao_inscricao","3265,3429");
		map.put("public.banca_examinadora","427,290" );
		map.put("public.uf_estrutura_cidade","4224,2489");
		map.put("public.alternativa_questao_correlata","1784,1879");
		map.put("public.monitoramento_candidato","2272,2799");
		map.put("public.classificacao_inscricao","1636,355");
		map.put("public.resultado_vaga","1979,443");
		map.put("public.resultado_fase","2015,222");
		map.put("public.pontuacao_prova_questoes","1298,38" );
		map.put("public.pontuacao_prova_objetiva","860,466" );
		map.put("public.pontuacao_disciplina","1047,760");
		map.put("public.pontuacao_subprova","679,757" );
		map.put("public.pontuacao_prova_habilitacao","890,318" );
		map.put("public.pontuacao_prova_titulos","996,158" );
		map.put("public.erro_arquivo_mds","5093,3120");
		map.put("public.reserva_sala_aplicacao","3996,3094");
		map.put("public.presenca_inscricao","5352,5"  );
		map.put("public.lista_presenca","5180,267");
		map.put("public.auditoria.registro_revisao_auditoria","1741,2077");
		map.put("public.orientacao_recurso","4564,1158");
		map.put("public.permissao_usuario_concurso","3795,2358");
		map.put("public.recurso","1175,1188");
		map.put("public.area","362,840" );
		map.put("public.assunto","616,685" );
		map.put("public.area_banca_examinadora","53,698"  );
		map.put("public.local_execucao","4520,3067");
		map.put("public.parecer_historico_tramite","1260,1599");
		map.put("public.fase","4639,1320");
		map.put("public.etapa","4343,1372");
		map.put("public.anexo_vistoria","3357,1563");
		map.put("public.idioma_concurso","4322,1819");
		map.put("public.criterio_desempate_maior_nota_disc","4837,1334");
		map.put("public.criterio_desempate","5056,1582");
		map.put("public.vinculo_fase","5280,1829");
		map.put("public.criterio_desempate_maior_nota_provas","5080,1235");
		map.put("public.sala_local_prova","2270,1794");
		map.put("public.andar_local_prova","2638,1839");
		map.put("public.bloco_local_prova","3116,1890");
		map.put("public.diverg_fec_localidade","5521,195");
		map.put("public.fechamento_aplicacao_localidade","5659,446");
		map.put("public.divergencia_resultado_repetido","4931,6"  );
		map.put("public.divergencia_cartao_repetido","4428,1"  );
		map.put("public.diverg_fec_concurso","4779,334");
		map.put("public.fechamento_aplicacao_concurso","4976,644");
		map.put("public.cartao_resposta","4518,569");
		map.put("public.prova","3636,867");
		map.put("public.disciplina","2214,795");
		map.put("public.aplicacao_prova","4092,1206");
		map.put("public.inscricoes_arquivo_pagamento","2819,2637");
		map.put("public.prorrogacao_prazos_concurso","4658,1675");
		map.put("public.historico_motivo_bloqueio","375,131" );
		map.put("public.cartao_incluido","4233,539");
		map.put("public.arquivo_banca","337,1348");
		map.put("public.questao_banca","699,1237");
		map.put("public.vinculo_banca_disciplina","598,910" );
		map.put("public.imagem_folha","5311,443");
		map.put("public.vinculo_fase_prova","5862,1817");
		map.put("public.nivel_escolaridade","2639,2494");
		map.put("public.area_formacao","2638,2372");
		map.put("public.isencao","4570,1504");
		map.put("public.questao_prova_subjetiva","2738,76" );
		map.put("public.disciplina_subprova","2514,827");
		map.put("public.subprova_prova_objetiva","2956,992");
		map.put("public.subprova","2000,1045");
		map.put("public.conteudo_prova","2831,672");
		map.put("public.gabarito_prova_inscricao","2893,3192");
		map.put("public.banca_questoes","430,1111");
		map.put("public.criterio_desempate_maior_nota_subprovas","5271,1434");
		map.put("public.reserva_sala","3698,3254");
		map.put("public.reserva_lugares_sala","4356,3260");
		map.put("public.reserva_local_prova","3712,2881");
		map.put("public.idiomas_gabarito_prova","3118,1226");
		map.put("public.qtd_min_provas_corrigidas","5350,2166");
		map.put("public.imagem_parecer","419,1501");
		map.put("public.idioma","4476,2340");
		map.put("public.idioma_oferta_cargo_concurso","4493,2087");
		map.put("public.historico_questao_banca","952,1041");
		map.put("public.historico_presenca_inscricao","5882,236");
		map.put("public.titulo_prova_titulos","3318,376");
		map.put("public.ofertas_cargos_prorrogacao_concurso","4664,1853");
		map.put("public.inscricao_historico_status","3552,2679");
		map.put("public.campo_formulario_inscricao","3020,1560");
		map.put("public.formulario_inscricao","3010,1668");
		map.put("public.candidato","3305,2980");
		map.put("public.ocorrencia","4386,1638");
	}

	public Database parse(File file) {
		this.file = file;

		// get a factory
		final SAXParserFactory spf = SAXParserFactory.newInstance();
		try {

			// get a new instance of parser
			final SAXParser sp = spf.newSAXParser();

			// parse the file and also register this class for call backs
			sp.parse(file, new Parser());

		} catch (final SAXException se) {
			se.printStackTrace();
		} catch (final ParserConfigurationException pce) {
			pce.printStackTrace();
		} catch (final IOException ie) {
			ie.printStackTrace();
		}

		return database;
	}

	private class Parser extends DefaultHandler {

		private Restriction restriction;
		private Index index;
		private Association association;
		private int tableOrder;

		@Override
		public void fatalError(SAXParseException e) throws SAXException {
		    System.out.println(e.getMessage());
		    System.out.println(e.getLineNumber() + "," + e.getColumnNumber());
		}

		@Override
		public void startElement(String uri, String localName, String qName,
				Attributes attributes) throws SAXException {

			if (qName.equals("database")) {
				parseDatabaseElement(attributes);

			} else if (qName.equals("table")) {
				parseTableElement(attributes);

			} else if (qName.equals("column")) {
				parseColumnElement(attributes);

			} else if (qName.equals("association")) {
				parseAssociationElement(attributes);

			} else if (qName.equals("index")) {
				parseIndexElement(attributes);

			} else if (qName.equals("restriction")) {
				parseRestrictionElement(attributes);
			}
		}

		private void parseRestrictionElement(Attributes attributes) {
			restriction = new Restriction();
			Table tableOwner = table;

			for (int i = 0; i < attributes.getLength(); i++) {
				final String attributeName = attributes.getQName(i);
				final String attributeValue = attributes.getValue(i);

				if ("type".equals(attributeName)) {
					restriction.setType(attributeValue);

				} else if ("columns".equals(attributeName)) {
					restriction.setColumns(attributeValue);

				} else if ("name".equals(attributeName)) {
					restriction.setName(attributeValue);

				} else if ("table".equals(attributeName)) {
					tableOwner = database.findTable(attributeValue);

				}
			}
			tableOwner.getRestrictions().add(restriction);
			restriction.setTable(tableOwner);

		}

		private void parseIndexElement(Attributes attributes) {
			index = new Index();
			Table tableOwner = table;

			for (int i = 0; i < attributes.getLength(); i++) {
				final String attributeName = attributes.getQName(i);
				final String attributeValue = attributes.getValue(i);

				if ("name".equals(attributeName)) {
					index.setName(attributeValue);

				} else if ("columns".equals(attributeName)) {
					index.setColumns(attributeValue);

				} else if ("table".equals(attributeName)) {
					tableOwner = database.findTable(attributeValue);
				}
			}

			tableOwner.getIndexes().add(index);
			index.setTable(tableOwner);
		}

		private void parseAssociationElement(Attributes attributes) {
			association = new Association();
			Table tableOwner = table;

			for (int i = 0; i < attributes.getLength(); i++) {
				final String attributeName = attributes.getQName(i);
				final String attributeValue = attributes.getValue(i);

				if ("other-table".equals(attributeName)) {
					association.setOtherTable(database.findTable(attributeValue));

				} else if ("table".equals(attributeName)) {
					tableOwner = database.findTable(attributeValue);

				} else if ("columns-here".equals(attributeName)) {
					association.setColumnsHere(attributeValue);

				} else if ("columns-there".equals(attributeName)) {
					association.setColumnsThere(attributeValue);
				}
			}

			tableOwner.getAssociations().add(association);
			association.setTable(tableOwner);
		}

		private void parseColumnElement(Attributes attributes) {
			column = new Column();
			table.getColumns().add(column);

			for (int i = 0; i < attributes.getLength(); i++) {
				final String attributeName = attributes.getQName(i);
				final String attributeValue = attributes.getValue(i);

				if ("name".equals(attributeName)) {
					column.setName(attributeValue);

				} else if ("default".equals(attributeName)) {
					column.setDefaultValue(attributeValue);

				} else if ("nullable".equals(attributeName)) {
					column.setNullable(parseBoolean(attributeValue, true));

				} else if ("pk".equals(attributeName)) {
					column.setPk(parseBoolean(attributeValue, false));

				} else if ("type".equals(attributeName)) {
					column.setType(attributeValue);

				} else if ("precision".equals(attributeName)) {
					column.setPrecision(parseInt(attributeValue, null));

				} else if ("scale".equals(attributeName)) {
					column.setScale(parseInt(attributeValue, null));

				} else if ("unique-restriction".equals(attributeName)) {
					final Restriction r = new Restriction();
					r.setType("unique");
					r.setName(attributeValue);
					column.setUniqueRestriction(r);
				}

			}

		}

		private boolean parseBoolean(String attributeValue, boolean errorValue) {
			try {
				return Boolean.parseBoolean(attributeValue);
			} catch (final NumberFormatException e) {
				return errorValue;
			}
		}

		private void parseTableElement(Attributes attributes) {
			table = new Table();

			for (int i = 0; i < attributes.getLength(); i++) {
				final String attributeName = attributes.getQName(i);
				final String attributeValue = attributes.getValue(i);

				if ("name".equals(attributeName)) {
					table.setName(attributeValue);

				} else if ("schema".equals(attributeName)) {
					table.setSchema(attributeValue);

				} else if ("tags".equals(attributeName)) {
					table.setTags(attributeValue);

				} else if ("order".equals(attributeName)) {
					table.setOrder(parseInt(attributeValue, 0));

				} else if ("x".equals(attributeName)) {
					table.setX(parseInt(attributeValue, 0));

				} else if ("y".equals(attributeName)) {
					table.setY(parseInt(attributeValue, 0));

				} else if ("width".equals(attributeName)) {
					table.setWidth(parseInt(attributeValue, 0));

				}

			}
			if (table.getOrder() == 0) {
				table.setOrder(++tableOrder);
			}
			if (table.getX() == 0) {
				final String string = map.get(table.getFullName());
				if (string != null) {
					final String[] split = string.split(",");
					table.setX((int)(0.4 * parseInt(split[0], 0)));
					table.setY((int)(0.5 * parseInt(split[1], 0)));
				}
			}
			database.addTable(table);

		}

		private int parseInt(String value, Integer errorValue) {
			try {
				return Integer.parseInt(value);
			} catch (final NumberFormatException e) {
				return errorValue;
			}
		}

		private void parseDatabaseElement(Attributes attributes) {
			database = new Database(file);

			for (int i = 0; i < attributes.getLength(); i++) {
				final String attributeName = attributes.getQName(i);
				final String attributeValue = attributes.getValue(i);

				if ("end-script".equals(attributeName)) {
					database.setEndScript(attributeValue);
				}
			}

		}

	}



}
