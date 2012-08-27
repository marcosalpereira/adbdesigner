CREATE TABLE public.concurso (
       concurso_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(100) NOT NULL CONSTRAINT UQ_concurso_nome UNIQUE
     , numero_projeto CHARACTER VARYING(15) NOT NULL CONSTRAINT UQ_concurso_numero UNIQUE
     , numero_edital INT4 NOT NULL
     , ano_edital INT4 NOT NULL
     , sigla_edital CHARACTER VARYING(15) NOT NULL
     , data_inicio_inscricao TIMESTAMP WITH TIME ZONE NOT NULL
     , data_final_inscricao TIMESTAMP WITH TIME ZONE NOT NULL
     , data_final_pagamento TIMESTAMP WITH TIME ZONE
     , data_final_isencao TIMESTAMP WITH TIME ZONE
     , data_cadastramento TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp NOT NULL
     , abrangencia CHARACTER VARYING(15) NOT NULL
     , data_publicacao TIMESTAMP WITH TIME ZONE
     , motivo_reativacao TEXT
     , status CHARACTER VARYING(15) NOT NULL
     , status_anterior_suspensao CHARACTER VARYING(15)
     , formulario_inscricao_id INT8
     , sequencial_exportacao BIGINT DEFAULT 0
     , version INT4 NOT NULL
     , PRIMARY KEY (concurso_id)
);
CREATE INDEX IX_concurso_data_inicio_inscricao ON public.concurso (data_inicio_inscricao);
CREATE INDEX IX_concurso_data_final_inscricao ON public.concurso (data_final_inscricao);

CREATE TABLE public.uf (
       uf_id SERIAL8 NOT NULL
     , sigla CHARACTER VARYING(2) NOT NULL
     , nome CHARACTER VARYING(25) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (uf_id)
);

CREATE TABLE public.orgao_contratante (
       orgao_contratante_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(100) NOT NULL
     , sigla CHARACTER VARYING(10) NOT NULL
     , texto_estrutura CHARACTER VARYING(50)
     , tipo_estrutura CHARACTER VARYING(15) NOT NULL
     , habilitado BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (orgao_contratante_id)
);

CREATE TABLE public.disciplina (
       disciplina_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(100) NOT NULL CONSTRAINT UQ_disciplina_1 UNIQUE
     , idioma BOOL NOT NULL
     , desativada BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (disciplina_id)
);

CREATE TABLE public.conteudo_prova (
       conteudo_prova_id SERIAL8 NOT NULL
     , prova_id BIGINT
     , tipo_prova CHARACTER VARYING(20) NOT NULL
     , titulos_nota_minima NUMERIC(19,2)
     , titulos_nota_maxima NUMERIC(19,2)
     , questoes_nota_minima NUMERIC(19,2)
     , questoes_nota_maxima NUMERIC(19,2)
     , objetiva_quantidade_gabaritos INTEGER
     , objetiva_pontuacao_correcao CHARACTER VARYING(20)
     , objetiva_nota_minima NUMERIC(19,2)
     , objetiva_numero_aplicacao_prova CHARACTER VARYING(15)
     , peso NUMERIC(2,1)
     , version INT4 NOT NULL
     , PRIMARY KEY (conteudo_prova_id)
);
CREATE INDEX IX_conteudo_prova_prova_id ON public.conteudo_prova (prova_id);

CREATE TABLE public.area_formacao (
       area_formacao_id SERIAL8 NOT NULL
     , descricao CHARACTER VARYING(30) NOT NULL CONSTRAINT UQ_area_formacao UNIQUE
     , desativado BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (area_formacao_id)
);

CREATE TABLE public.nivel_escolaridade (
       nivel_escolaridade_id SERIAL8 NOT NULL
     , descricao CHARACTER VARYING(70) NOT NULL CONSTRAINT uq_nivel_escolaridade UNIQUE
     , desativado BOOLEAN
     , version INT4 NOT NULL
     , PRIMARY KEY (nivel_escolaridade_id)
);

CREATE TABLE public.tratamento_diferenciado (
       tratamento_diferenciado_id SERIAL8 NOT NULL
     , descricao CHARACTER VARYING(50) NOT NULL
     , texto_da_carta CHARACTER VARYING(150) NOT NULL
     , desativado BOOL DEFAULT FALSE NOT NULL
     , tipo_tratamento CHARACTER VARYING(20) NOT NULL
     , permite_alteracao_gabarito BOOL NOT NULL
     , exige_acessibilidade BOOL
     , version INT4 NOT NULL
     , PRIMARY KEY (tratamento_diferenciado_id)
);

CREATE TABLE public.monitoramento_candidato (
       monitoramento_candidato_id SERIAL8 NOT NULL
     , cpf VARCHAR(11) NOT NULL CONSTRAINT UQ_monitoramento_candidato_1 UNIQUE
     , nome VARCHAR(40) NOT NULL
     , texto_candidato VARCHAR(250)
     , motivo VARCHAR(15) NOT NULL
     , fato_ocorrido VARCHAR(250)
     , desativado BOOL
     , version INT4 NOT NULL
     , PRIMARY KEY (monitoramento_candidato_id)
);

CREATE TABLE public.motivo_indeferimento (
       motivo_indeferimento_id SERIAL8 NOT NULL
     , codigo INTEGER NOT NULL CONSTRAINT UQ_motivo_indeferimento_codigo UNIQUE
     , descricao CHARACTER VARYING(50) NOT NULL CONSTRAINT UQ_motivo_indeferimento_descricao UNIQUE
     , version INT4 NOT NULL
     , PRIMARY KEY (motivo_indeferimento_id)
);

CREATE TABLE public.idioma (
       idioma_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(20) NOT NULL CONSTRAINT uq_idioma_nome UNIQUE
     , desativado BOOL DEFAULT false NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (idioma_id)
);

CREATE TABLE public.assunto (
       assunto_id SERIAL8 NOT NULL
     , nome VARCHAR(100) NOT NULL CONSTRAINT UQ_assunto_nome UNIQUE
     , desabilitado BOOLEAN NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (assunto_id)
);

CREATE TABLE public.arquivo_anexo (
       arquivo_anexo_id SERIAL8 NOT NULL
     , nome_arquivo VARCHAR(100) NOT NULL
     , tipo_mime_arquivo VARCHAR(30)
     , identificacao_arquivo VARCHAR(36) NOT NULL CONSTRAINT UQ_arquivo_anexo_identificacao_arquivo UNIQUE
     , data_gravacao TIMESTAMP WITH TIME ZONE NOT NULL
     , conteudo_arquivo_fake BYTEA
     , version INT4 NOT NULL
     , PRIMARY KEY (arquivo_anexo_id)
);
CREATE UNIQUE INDEX IX_arquivo_anexo_identificacao_arquivo ON public.arquivo_anexo (identificacao_arquivo);

CREATE TABLE auditoria.registro_revisao_auditoria (
       registro_revisao_auditoria_id SERIAL8 NOT NULL
     , timestamp TIMESTAMP WITH TIME ZONE NOT NULL
     , cpf_responsavel CHARACTER VARYING(11) NOT NULL
     , nome_responsavel CHARACTER VARYING(100) NOT NULL
     , funcionalidade CHARACTER VARYING(50) NOT NULL
     , operacao CHARACTER VARYING(50)
     , PRIMARY KEY (registro_revisao_auditoria_id)
);

CREATE TABLE public.cargo (
       cargo_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(100) NOT NULL CONSTRAINT uq_cargo_nome UNIQUE
     , desabilitado BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (cargo_id)
);

CREATE TABLE public.campo_atuacao (
       campo_atuacao_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(70) NOT NULL
     , cargo_id INT8 NOT NULL
     , desabilitado BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (campo_atuacao_id)
     , CONSTRAINT uq_campo_nome_cargo UNIQUE (cargo_id, nome)
);
CREATE INDEX IX_campo_atuacao_cargo_id ON public.campo_atuacao (cargo_id);

CREATE TABLE public.campo_orgao (
       campo_orgao_id SERIAL8 NOT NULL
     , orgao_contratante_id INT8 NOT NULL
     , campo_atuacao_id INT8
     , habilitado BOOL NOT NULL
     , cargo_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (campo_orgao_id)
     , CONSTRAINT UQ_campo_orgao UNIQUE (orgao_contratante_id, campo_atuacao_id, cargo_id)
);

CREATE TABLE public.cidade (
       cidade_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(100) NOT NULL
     , uf_id INT8 NOT NULL
     , desabilitada BOOL NOT NULL
     , capital BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (cidade_id)
     , CONSTRAINT UQ_cidade_1 UNIQUE (uf_id, nome)
);
CREATE INDEX uf_idx ON public.cidade (uf_id);

CREATE TABLE public.estrutura (
       estrutura_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(50) NOT NULL
     , orgao_contratante_id INT8 NOT NULL
     , desabilitada BOOL DEFAULT false
     , version INT4 NOT NULL
     , PRIMARY KEY (estrutura_id)
);
CREATE INDEX IX_estrutura_org_contratante_id ON public.estrutura (orgao_contratante_id);

CREATE TABLE public.local_prova (
       local_prova_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(70) NOT NULL
     , logradouro CHARACTER VARYING(100) NOT NULL
     , numero CHARACTER VARYING(10) NOT NULL
     , complemento CHARACTER VARYING(100)
     , cidade_id INT8 NOT NULL
     , uf_id INT8 NOT NULL
     , bairro VARCHAR(60) NOT NULL
     , cep CHARACTER VARYING(8) NOT NULL
     , telefone CHARACTER VARYING(10) NOT NULL
     , acessibilidade BOOL DEFAULT false NOT NULL
     , desabilitado BOOL DEFAULT false NOT NULL
     , escola_publica BOOL DEFAULT false NOT NULL
     , motivo TEXT
     , numero_sequencial INT4 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (local_prova_id)
     , CONSTRAINT UQ_local_prova_nome_cidade UNIQUE (nome, cidade_id)
);
CREATE INDEX cidade_idx ON public.local_prova (cidade_id);

CREATE TABLE public.uf_estrutura (
       uf_estrutura_id SERIAL8 NOT NULL
     , uf_id INT8 NOT NULL
     , estrutura_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (uf_estrutura_id)
);
CREATE INDEX IX_uf_estrutura_estrutura_id ON public.uf_estrutura (estrutura_id);

CREATE TABLE public.usuario (
       usuario_id SERIAL8 NOT NULL
     , cpf CHARACTER VARYING(11) NOT NULL CONSTRAINT UQ_usuario_cpf UNIQUE
     , nome CHARACTER VARYING(100) NOT NULL
     , perfil CHARACTER VARYING(30) NOT NULL
     , data_expiracao TIMESTAMP WITH TIME ZONE
     , email CHARACTER VARYING(100)
     , fone_res CHARACTER VARYING(20)
     , fone_com CHARACTER VARYING(20)
     , fone_cel CHARACTER VARYING(20)
     , fax CHARACTER VARYING(20)
     , bloqueado BOOL NOT NULL
     , uf_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (usuario_id)
);

CREATE TABLE public.vaga (
       vaga_id SERIAL8 NOT NULL
     , cadastro_reserva BOOL
     , vagas_portador_deficiencia INT4
     , vagas_ampla_concorrencia INT4
     , uf_id INT8
     , estrutura_id INT8
     , oferta_cargo_concurso_id INT8 NOT NULL
     , cidade_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (vaga_id)
);
CREATE INDEX IX_vaga_oferta_cargo_conc_id ON public.vaga (oferta_cargo_concurso_id);

CREATE TABLE public.etapa (
       etapa_id SERIAL8 NOT NULL
     , nome VARCHAR(50) NOT NULL
     , concurso_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (etapa_id)
     , CONSTRAINT UQ_etapa_nome UNIQUE (nome, concurso_id)
);
CREATE INDEX IX_etapa_concurso_id ON public.etapa (concurso_id);

CREATE TABLE public.oferta_cargo_concurso (
       oferta_cargo_concurso_id SERIAL8 NOT NULL
     , valor_inscricao NUMERIC
     , concurso_id INT8 NOT NULL
     , campo_orgao_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (oferta_cargo_concurso_id)
     , CONSTRAINT uq_oferta_cargo_concurso UNIQUE (concurso_id, campo_orgao_id)
);
CREATE INDEX IX_oferta_cargo_concurso_concurso_id ON public.oferta_cargo_concurso (concurso_id);
CREATE INDEX IX_oferta_cargo_concurso_campo_orgao_id ON public.oferta_cargo_concurso (campo_orgao_id);

CREATE TABLE public.vistoria_local_prova (
       vistoria_local_prova_id SERIAL8 NOT NULL
     , local_prova_id INT8 NOT NULL
     , etapa_id INT8 NOT NULL
     , responsavel CHARACTER VARYING(50) NOT NULL
     , status CHARACTER VARYING(12) NOT NULL
     , data_geracao TIMESTAMP WITH TIME ZONE NOT NULL
     , data_visita TIMESTAMP WITH TIME ZONE
     , nome_contato CHARACTER VARYING(50)
     , telefone_contato VARCHAR(10)
     , outras_informacoes CHARACTER VARYING(200)
     , confere_vistoria BOOL DEFAULT false NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (vistoria_local_prova_id)
);
CREATE INDEX IX_vistoria_local_prova_local_etapa_id ON public.vistoria_local_prova (local_prova_id, etapa_id);

CREATE TABLE public.aplicacao_prova (
       aplicacao_prova_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(50) NOT NULL
     , data_aplicacao_prova DATE NOT NULL
     , hora_fechamento_portao TIME NOT NULL
     , duracao_prova TIME NOT NULL
     , concurso_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (aplicacao_prova_id)
     , CONSTRAINT UQ_aplicacao_prova_1 UNIQUE (concurso_id, nome)
);
CREATE INDEX IX_aplicacao_prova_concurso_id ON public.aplicacao_prova (concurso_id);
CREATE INDEX IX_aplicacao_prova_nome_concurso_id ON public.aplicacao_prova (nome, concurso_id);

CREATE TABLE public.subprova (
       subprova_id SERIAL8 NOT NULL
     , nome CHARACTER VARYING(60) NOT NULL
     , status CHARACTER VARYING(15)
     , classificatoria BOOL
     , eliminatoria BOOL
     , nota_minima NUMERIC(19,2)
     , concurso_id INT8 NOT NULL
     , correcao CHARACTER VARYING(20)
     , peso NUMERIC(2,1) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (subprova_id)
     , CONSTRAINT UQ_subprova_nome_concurso UNIQUE (nome, concurso_id)
);
CREATE INDEX IX_subprova_concurso_id ON public.subprova (concurso_id);

CREATE TABLE public.questao_prova_subjetiva (
       questao_prova_subjetiva_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , numero INTEGER NOT NULL
     , pontuacao_minima NUMERIC(19,2)
     , pontuacao_maxima NUMERIC(19,2)
     , peso NUMERIC(19,2)
     , conteudo BOOL
     , idioma BOOL
     , pontuacao_maxima_conteudo NUMERIC(19,2)
     , pontuacao_maxima_idioma NUMERIC(19,2)
     , version INT4 NOT NULL
     , PRIMARY KEY (questao_prova_subjetiva_id)
);
CREATE INDEX IX_questao_prova_subjetiva_cont_prova_id ON public.questao_prova_subjetiva (conteudo_prova_id);

CREATE TABLE public.titulo_prova_titulos (
       titulo_prova_titulos_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , nome TEXT NOT NULL
     , obrigatorio BOOLEAN NOT NULL
     , valor_maximo NUMERIC(19,2) NOT NULL
     , valor_unitario NUMERIC(19,2) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (titulo_prova_titulos_id)
);
CREATE INDEX IX_titulo_prova_titulos_conteudo_prova_id ON public.titulo_prova_titulos (conteudo_prova_id);

CREATE TABLE public.prorrogacao_prazos_concurso (
       prorrogacao_prazos_concurso_id SERIAL8 NOT NULL
     , data_hora_reabertura_inscricao TIMESTAMP WITH TIME ZONE
     , data_final_inscricao_prorrogada TIMESTAMP WITH TIME ZONE NOT NULL
     , data_final_pagamento_prorrogada TIMESTAMP WITH TIME ZONE
     , data_final_isencao_prorrogada TIMESTAMP WITH TIME ZONE
     , concurso_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (prorrogacao_prazos_concurso_id)
);
CREATE INDEX IX_prorrogacao_prazos_concurso_conc_id ON public.prorrogacao_prazos_concurso (concurso_id);
CREATE INDEX IX_prorrogacao_prazos_concurso_data_inicio ON public.prorrogacao_prazos_concurso (data_hora_reabertura_inscricao);
CREATE INDEX IX_prorrogacao_prazos_concurso_data_final ON public.prorrogacao_prazos_concurso (data_final_inscricao_prorrogada);

CREATE TABLE public.candidato (
       candidato_id SERIAL8 NOT NULL
     , cpf CHARACTER VARYING(11) NOT NULL CONSTRAINT UQ_candidato_cpf UNIQUE
     , nome CHARACTER VARYING(100) NOT NULL
     , nome_mae CHARACTER VARYING(100) NOT NULL
     , data_nascimento TIMESTAMP NOT NULL
     , genero CHARACTER VARYING(9) NOT NULL
     , numero_identidade CHARACTER VARYING(20) NOT NULL
     , orgao_expedidor_identidade CHARACTER VARYING(6) NOT NULL
     , data_emissao_identidade TIMESTAMP NOT NULL
     , cep CHARACTER VARYING(8) NOT NULL
     , logradouro CHARACTER VARYING(100) NOT NULL
     , numero CHARACTER VARYING(5) NOT NULL
     , complemento CHARACTER VARYING(100)
     , bairro CHARACTER VARYING(60)
     , telefone_fixo CHARACTER VARYING(10)
     , telefone_celular CHARACTER VARYING(10)
     , email CHARACTER VARYING(60)
     , uf_identidade_id INT8 NOT NULL
     , cidade CHARACTER VARYING(60) NOT NULL
     , uf_endereco_id INT8 NOT NULL
     , senha CHARACTER VARYING(64) NOT NULL
     , email_privado VARCHAR(64) NOT NULL
     , senha_gerada BOOLEAN DEFAULT false NOT NULL
     , version INT4 NOT NULL
     , pergunta_secreta VARCHAR(100) NOT NULL
     , resposta_secreta VARCHAR(15) NOT NULL
     , PRIMARY KEY (candidato_id)
);
CREATE UNIQUE INDEX IX_candidato_cpf ON public.candidato (cpf);
CREATE INDEX IX_candidato_nome ON public.candidato (nome);

CREATE TABLE public.prova (
       prova_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , aplicacao_prova_id INT8
     , conteudo_prova_id INT8 NOT NULL
     , tipo_correcao_prova CHARACTER VARYING(20) NOT NULL
     , nome CHARACTER VARYING(50) NOT NULL
     , eliminatoria BOOL NOT NULL
     , classificatoria BOOL NOT NULL
     , status_prova CHARACTER VARYING(15) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (prova_id)
     , CONSTRAINT UQ_prova_nome_concurso UNIQUE (concurso_id, nome)
);
CREATE INDEX IX_prova_concurso_id ON public.prova (concurso_id);
CREATE INDEX IX_prova_aplicacao_prova_id ON public.prova (aplicacao_prova_id);
CREATE INDEX IX_prova_conteudo_prova_id ON public.prova (conteudo_prova_id);

CREATE TABLE public.formulario_inscricao (
       formulario_inscricao_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , cabecalho TEXT NOT NULL
     , rodape TEXT
     , texto_opcao_deficiencia TEXT
     , texto_envio_sedex_deficiencia TEXT
     , texto_identificacao_deficiencia TEXT
     , texto_opcao_tratamento_diferenciado TEXT
     , texto_tipo_tratamento_diferenciado TEXT
     , texto_termo_compromisso TEXT
     , texto_opcao_termo_compromisso TEXT
     , status CHARACTER VARYING(30) NOT NULL
     , texto_termo_isencao TEXT
     , texto_opcao_termo_isencao TEXT
     , version INT4 NOT NULL
     , PRIMARY KEY (formulario_inscricao_id)
);

CREATE TABLE public.fase (
       fase_id SERIAL8 NOT NULL
     , nome VARCHAR(50) NOT NULL
     , etapa_id INT8 NOT NULL
     , status VARCHAR(10) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (fase_id)
     , CONSTRAINT UQ_fase_nome UNIQUE (nome, etapa_id)
);
CREATE INDEX IX_fase_etapa_id ON public.fase (etapa_id);

CREATE TABLE public.inscricao (
       inscricao_id SERIAL8 NOT NULL
     , status CHARACTER VARYING(33) NOT NULL
     , numero_inscricao CHARACTER VARYING(7) NOT NULL
     , candidato_id INT8 NOT NULL
     , idioma_id INT8
     , area_formacao_id INT8
     , nivel_escolaridade_id INT8
     , descricao_deficiencia CHARACTER VARYING(70)
     , descricao_tratamento_diferenciado CHARACTER VARYING(70)
     , cidade_prova_id INT8 NOT NULL
     , numero_nis INT8
     , numero_identidade_nis CHARACTER VARYING(20)
     , orgao_expeditor_identidade_nis CHARACTER VARYING(6)
     , data_emissao_identidade_nis TIMESTAMP
     , uf_identidade_nis_id INT8
     , numero_sedex_laudo CHARACTER VARYING(20)
     , tipo_isencao_solicitada CHARACTER VARYING(10)
     , tipo_isencao_concedida CHARACTER VARYING(10)
     , cargo_ocupa CHARACTER VARYING(70)
     , cargo_comissionado CHARACTER VARYING(70)
     , email_chefia_imediata CHARACTER VARYING(100)
     , email_funcional CHARACTER VARYING(100)
     , matricula_siape CHARACTER VARYING(12)
     , orgao_exercicio CHARACTER VARYING(70)
     , orgao_lotacao CHARACTER VARYING(70)
     , telefone_funcional CHARACTER VARYING(20)
     , tempo_servico_ano INTEGER
     , tempo_servico_mes INTEGER
     , tempo_servico_dia INTEGER
     , tempo_servico_cargo_ano INTEGER
     , tempo_servico_cargo_mes INTEGER
     , tempo_servico_cargo_dia INTEGER
     , vaga_portador_deficiencia BOOL NOT NULL
     , tratamento_diferenciado BOOL NOT NULL
     , vaga_id INT8 NOT NULL
     , concurso_id INT8 NOT NULL
     , data_inscricao TIMESTAMP WITH TIME ZONE NOT NULL
     , data_confirmacao TIMESTAMP WITH TIME ZONE
     , data_cancelamento TIMESTAMP WITH TIME ZONE
     , motivo_cancelamento CHARACTER VARYING(400)
     , motivo_indeferimento_id INT8
     , motivo_alteracao_status VARCHAR(400)
     , motivo_alteracao_status_visivel BOOLEAN
     , motivo_reativacao VARCHAR(400)
     , justificativa_solicitacao_isencao VARCHAR(400)
     , justificativa_analise_isencao VARCHAR(400)
     , justificativa_alteracao_vaga VARCHAR(400)
     , version INT4 NOT NULL
     , justificativa_analise_isencao_visivel BOOLEAN
     , PRIMARY KEY (inscricao_id)
     , CONSTRAINT UQ_inscricao_numero_inscricao UNIQUE (concurso_id, numero_inscricao)
);
CREATE INDEX IX_inscricao_candidato_id ON public.inscricao (candidato_id);
CREATE UNIQUE INDEX IX_inscricao_numero_concurso_id ON public.inscricao (numero_inscricao, concurso_id);
CREATE INDEX IX_inscricao_concurso_id ON public.inscricao (concurso_id);
CREATE INDEX IX_inscricao_vaga_id ON public.inscricao (vaga_id);

CREATE TABLE public.vinculo_fase (
       vinculo_fase_id SERIAL8 NOT NULL
     , habilitar_proxima_fase VARCHAR(32)
     , tipo_correcao VARCHAR(20)
     , pontuacao_minima NUMERIC
     , min_prova_correcao BOOL
     , reverter_vaga_deficiente_ampla_concorrencia BOOL
     , permitir_reavaliacao BOOL
     , fase_predecessora_id INT8
     , fase_id INT8 NOT NULL
     , oferta_cargo_concurso_id INT8 NOT NULL
     , fator_numero_vagas_proxima_fase INT4
     , status VARCHAR(10) NOT NULL
     , opcao_criterio_desempate BOOL DEFAULT false NOT NULL
     , habilitar_empatados_ultimo BOOL DEFAULT true NOT NULL
     , peso NUMERIC(2,1) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (vinculo_fase_id)
     , CONSTRAINT UQ_fase_oferta UNIQUE (fase_id, oferta_cargo_concurso_id)
);
CREATE INDEX IX_vinculo_fase_fase_id ON public.vinculo_fase (fase_id);
CREATE INDEX IX_vinculo_fase_oferta_cargo_concurso_id ON public.vinculo_fase (oferta_cargo_concurso_id);

CREATE TABLE public.arquivo_pagamento (
       arquivo_pagamento_id BIGSERIAL NOT NULL
     , nome_arquivo CHARACTER VARYING(100) NOT NULL
     , data_processamento TIMESTAMP WITH TIME ZONE NOT NULL
     , quantidade_registros INTEGER NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (arquivo_pagamento_id)
);

CREATE TABLE public.bloco_local_prova (
       bloco_local_prova_id SERIAL8 NOT NULL
     , local_prova_id INT8 NOT NULL
     , nome CHARACTER VARYING(20) NOT NULL
     , formato_corredor CHARACTER VARYING(10) NOT NULL
     , acesso_facilitado BOOL DEFAULT false NOT NULL
     , tipo_acesso_facilitado CHARACTER VARYING(10)
     , desativado BOOL DEFAULT false NOT NULL
     , motivo_desativado CHARACTER VARYING(100)
     , numero_sequencial INT4 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (bloco_local_prova_id)
     , CONSTRAINT UQ_bloco_local_prova_nome UNIQUE (local_prova_id, nome)
);
CREATE INDEX IX_bloco_local_prova_local_prova_id ON public.bloco_local_prova (local_prova_id);

CREATE TABLE public.criterio_desempate (
       criterio_desempate_id SERIAL8 NOT NULL
     , ordem INT4 NOT NULL
     , idade INT4
     , vinculo_fase_id INT8 NOT NULL
     , tipo_criterio VARCHAR(30) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (criterio_desempate_id)
);
CREATE INDEX IX_criterio_desempate_vinculo_fase_id ON public.criterio_desempate (vinculo_fase_id);

CREATE TABLE public.andar_local_prova (
       andar_local_prova_id SERIAL8 NOT NULL
     , bloco_local_prova_id INT8 NOT NULL
     , nome CHARACTER VARYING(20) NOT NULL
     , nu_ban_masc_normal INT4 DEFAULT 0 NOT NULL
     , nu_ban_masc_adaptado INT4 DEFAULT 0 NOT NULL
     , nu_ban_fem_normal INT4 DEFAULT 0 NOT NULL
     , nu_ban_fem_adaptado INT4 DEFAULT 0 NOT NULL
     , nu_ban_misto_normal INT4 DEFAULT 0 NOT NULL
     , nu_ban_misto_adaptado INT4 DEFAULT 0 NOT NULL
     , ban_misto_normal_adaptado BOOL DEFAULT false NOT NULL
     , ban_masc_normal_adaptado BOOL DEFAULT false NOT NULL
     , ban_fem_normal_adaptado BOOL DEFAULT false NOT NULL
     , desativado BOOL DEFAULT false NOT NULL
     , motivo_desativado CHARACTER VARYING(100)
     , acesso_facilitado BOOL DEFAULT false NOT NULL
     , numero_sequencial INT4 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (andar_local_prova_id)
     , CONSTRAINT UQ_andar_local_prova_nome UNIQUE (bloco_local_prova_id, nome)
);
CREATE INDEX IX_andar_local_prova_bloco_id ON public.andar_local_prova (bloco_local_prova_id);

CREATE TABLE public.sala_local_prova (
       sala_local_prova_id SERIAL8 NOT NULL
     , andar_local_prova_id INT8 NOT NULL
     , numero CHARACTER VARYING(20) NOT NULL
     , acesso_facilitado BOOL DEFAULT false NOT NULL
     , desativada BOOL DEFAULT false NOT NULL
     , motivo_desativada CHARACTER VARYING(100)
     , capacidade_total INT NOT NULL
     , capacidade_alocacao INT NOT NULL
     , numero_sequencial INT4 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (sala_local_prova_id)
     , CONSTRAINT UQ_sala_local_prova_numero UNIQUE (andar_local_prova_id, numero)
);
CREATE INDEX IX_sala_local_prova_andar_id ON public.sala_local_prova (andar_local_prova_id);

CREATE TABLE public.reserva_local_prova (
       reserva_local_prova_id SERIAL8 NOT NULL
     , quantidades_execucoes INT4 NOT NULL
     , sequencial_local_prova INT4
     , local_prova_id INT8 NOT NULL
     , etapa_id INT8 NOT NULL
     , status CHARACTER VARYING(30) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (reserva_local_prova_id)
     , CONSTRAINT uq_local_prova_etapa UNIQUE (local_prova_id, etapa_id)
);
CREATE INDEX IX_reserva_local_prova_local_prova_id ON public.reserva_local_prova (local_prova_id);
CREATE INDEX IX_reserva_local_prova_etapa_id ON public.reserva_local_prova (etapa_id);

CREATE TABLE public.local_execucao (
       local_execucao_id SERIAL8 NOT NULL
     , numero_execucao INT4
     , numero_sala_inicial INT4
     , numero_sala_final INT4
     , reserva_local_prova_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (local_execucao_id)
     , CONSTRAINT uq_reserva_local_prova_num_execucao UNIQUE (reserva_local_prova_id, numero_execucao)
);
CREATE INDEX IX_local_execucao_reserva_local_prova_id ON public.local_execucao (reserva_local_prova_id);

CREATE TABLE public.reserva_sala (
       reserva_sala_id SERIAL8 NOT NULL
     , sala_extra BOOL NOT NULL
     , oferta_sala_extra_id INT8
     , idioma_extra_id INT8
     , acesso_facilitado BOOL NOT NULL
     , oferta_acesso_id INT8
     , idioma_acesso_id INT8
     , alocacao_extra BOOL NOT NULL
     , sequencial_sala INT4
     , reserva_local_prova_id INT8 NOT NULL
     , sala_local_prova_id INT8 NOT NULL
     , local_execucao_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (reserva_sala_id)
     , CONSTRAINT UQ_sala_reserva_local_prova UNIQUE (reserva_local_prova_id, sala_local_prova_id)
);
CREATE INDEX reserva_local_prova_idx ON public.reserva_sala (reserva_local_prova_id);

CREATE TABLE public.localidade_prova_alocacao (
       localidade_prova_alocacao_id SERIAL8 NOT NULL
     , etapa_id INT8 NOT NULL
     , cidade_id INT8 NOT NULL
     , status_alocacao CHARACTER VARYING(30) NOT NULL
     , data_pre_validacao_locais_prova TIMESTAMP WITH TIME ZONE
     , version INT4 NOT NULL
     , PRIMARY KEY (localidade_prova_alocacao_id)
     , CONSTRAINT UQ_localidade_prova_alocacao_etapa_cidade UNIQUE (etapa_id, cidade_id)
);

CREATE TABLE public.reserva_sala_aplicacao (
       reserva_sala_aplic_id SERIAL8 NOT NULL
     , reserva_sala_id INT8
     , aplicacao_prova_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (reserva_sala_aplic_id)
);
CREATE INDEX reserva_sala_idx ON public.reserva_sala_aplicacao (reserva_sala_id);

CREATE TABLE public.arquivo_mds (
       arquivo_mds_id SERIAL8 NOT NULL
     , nome_arquivo CHARACTER VARYING(60) NOT NULL
     , data_importacao TIMESTAMP WITH TIME ZONE NOT NULL
     , total_registros_sucesso INTEGER NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , concurso_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (arquivo_mds_id)
);
CREATE INDEX IX_arquivo_mds_concurso_id ON public.arquivo_mds (concurso_id);

CREATE TABLE public.resultado_prova_manual (
       resultado_prova_manual_id SERIAL8 NOT NULL
     , versao VARCHAR(20)
     , status VARCHAR(20)
     , prova_id INT8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , cidade_id INT8
     , candidato_faltoso BOOLEAN
     , invalido BOOLEAN DEFAULT false NOT NULL
     , tipo_resultado VARCHAR(30)
     , titulos_nota_total NUMERIC(19,2)
     , version INT4 NOT NULL
     , PRIMARY KEY (resultado_prova_manual_id)
);
CREATE INDEX IX_resultado_prova_manual_prova_id ON public.resultado_prova_manual (prova_id);
CREATE INDEX IX_resultado_prova_manual_inscricao_id ON public.resultado_prova_manual (inscricao_id);
CREATE INDEX IX_resultado_prova_manual_prova_inscricao ON public.resultado_prova_manual (prova_id, inscricao_id);

CREATE TABLE public.cartao_resposta (
       cartao_resposta_id SERIAL8 NOT NULL
     , gabarito VARCHAR(2) NOT NULL
     , numero_caixa INT
     , posicao_caixa INT
     , status VARCHAR(10) NOT NULL
     , invalido BOOL NOT NULL
     , invalidado_fecha_localidade BOOL DEFAULT false NOT NULL
     , inscricao_id INT8 NOT NULL
     , localidade_id INT8 NOT NULL
     , prova_id INT8 NOT NULL
     , arquivo_anexo_id INT8
     , idioma_id INT8
     , sequencial_cartao_concurso INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (cartao_resposta_id)
);
CREATE INDEX IX_cartao_resposta_inscricao_id ON public.cartao_resposta (inscricao_id);
CREATE INDEX IX_cartao_resposta_prova_id ON public.cartao_resposta (prova_id);
CREATE INDEX IX_cartao_resposta_inscricao_prova ON public.cartao_resposta (inscricao_id, prova_id);

CREATE TABLE public.fechamento_aplicacao_concurso (
       fec_aplicacao_concurso_id SERIAL8 NOT NULL
     , data_geracao TIMESTAMP WITH TIME ZONE NOT NULL
     , aplicacao_prova_id INT8 NOT NULL
     , status VARCHAR(10) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (fec_aplicacao_concurso_id)
);
CREATE INDEX IX_fechamento_aplicacao_concurso_aplic_prova_id ON public.fechamento_aplicacao_concurso (aplicacao_prova_id);

CREATE TABLE public.alocacao_inscricao (
       alocacao_inscricao_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , reserva_sala_id INT8 NOT NULL
     , cartao_lista_exportados_impressao BOOL DEFAULT false NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (alocacao_inscricao_id)
     , CONSTRAINT UQ_alocacao_inscricao UNIQUE (inscricao_id, reserva_sala_id)
);
CREATE INDEX IX_alocacao_inscricao_inscricao_id ON public.alocacao_inscricao (inscricao_id);
CREATE INDEX IX_alocacao_inscricao_reserva_sala_id ON public.alocacao_inscricao (reserva_sala_id);

CREATE TABLE public.diverg_fec_concurso (
       diverg_fec_concurso_id SERIAL8 NOT NULL
     , fec_aplicacao_concurso_id INT8 NOT NULL
     , tipo_divergencia VARCHAR(15) NOT NULL
     , inscricao_id INT8 NOT NULL
     , tipo_gabarito_alocacao VARCHAR(2)
     , tipo_gabarito_cartao_resposta VARCHAR(2)
     , idioma_cartao_id INT8
     , idioma_inscricao_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (diverg_fec_concurso_id)
);
CREATE INDEX IX_diverg_fec_concurso_fec_aplic ON public.diverg_fec_concurso (fec_aplicacao_concurso_id);
CREATE INDEX IX_diverg_fec_concurso_insc ON public.diverg_fec_concurso (inscricao_id);

CREATE TABLE public.fechamento_aplicacao_localidade (
       fec_aplicacao_localidade_id SERIAL8 NOT NULL
     , data_geracao TIMESTAMP WITH TIME ZONE NOT NULL
     , status VARCHAR(10) NOT NULL
     , aplicacao_prova_id INT8 NOT NULL
     , localidade_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (fec_aplicacao_localidade_id)
);
CREATE INDEX IX_fechamento_apli_loc_apli_loc ON public.fechamento_aplicacao_localidade (aplicacao_prova_id, localidade_id);

CREATE TABLE public.diverg_fec_localidade (
       diverg_fec_localidade_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , prova_id INT8
     , tipo VARCHAR(90) NOT NULL
     , fec_aplicacao_localidade_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (diverg_fec_localidade_id)
);
CREATE INDEX IX_diverg_fec_localidade_ins ON public.diverg_fec_localidade (inscricao_id);
CREATE INDEX IX_diverg_fec_localidade_prova_id ON public.diverg_fec_localidade (prova_id);
CREATE INDEX IX_diverg_fec_localidade_fec_apl_loc ON public.diverg_fec_localidade (fec_aplicacao_localidade_id);
CREATE INDEX IX_diverg_fec_localidade_tipo ON public.diverg_fec_localidade (tipo);

CREATE TABLE public.lista_presenca (
       lista_presenca_id SERIAL8 NOT NULL
     , aplicacao_prova_id INT8 NOT NULL
     , localidade_id INT8 NOT NULL
     , reserva_sala_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (lista_presenca_id)
);
CREATE INDEX IX_lista_presenca_local_aplic ON public.lista_presenca (localidade_id, aplicacao_prova_id);
CREATE INDEX IX_lista_presenca_reserva_sala ON public.lista_presenca (reserva_sala_id);
CREATE UNIQUE INDEX IX_lista_presenca_aplicacao_localidade_reserva ON public.lista_presenca (aplicacao_prova_id, localidade_id, reserva_sala_id);

CREATE TABLE public.gabarito_prova (
       gabarito_prova_id BIGSERIAL NOT NULL
     , prova_id INT8 NOT NULL
     , tipo_gabarito CHARACTER VARYING(2) NOT NULL
     , versao_gabarito CHARACTER VARYING(15) NOT NULL
     , status_gabarito CHARACTER VARYING(15) NOT NULL
     , data_cadastro DATE NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (gabarito_prova_id)
     , CONSTRAINT UQ_prova_tipo_versao UNIQUE (prova_id, tipo_gabarito, versao_gabarito)
);
CREATE INDEX IX_gabarito_prova_prova_id ON public.gabarito_prova (prova_id);

CREATE TABLE public.resultado_fase (
       resultado_fase_id SERIAL8 NOT NULL
     , versao_resultado VARCHAR(20) NOT NULL
     , status_resultado VARCHAR(20) NOT NULL
     , data_geracao TIMESTAMP WITH TIME ZONE NOT NULL
     , fase_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (resultado_fase_id)
);
CREATE INDEX IX_fase_id ON public.resultado_fase (fase_id);

CREATE TABLE public.presenca_inscricao (
       presenca_inscricao_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , lista_presenca_id INT8 NOT NULL
     , situacao CHARACTER VARYING(8) NOT NULL
     , tipo_inclusao CHARACTER VARYING(10) NOT NULL
     , imagem_lista_presenca INTEGER
     , invalido BOOL NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (presenca_inscricao_id)
     , CONSTRAINT UQ_presenca_inscricao_insc_lista UNIQUE (inscricao_id, lista_presenca_id)
);
CREATE INDEX IX_presenca_inscricao_lista_pre ON public.presenca_inscricao (lista_presenca_id);
CREATE INDEX IX_presenca_inscricao_insc_id ON public.presenca_inscricao (inscricao_id);

CREATE TABLE public.resultado_vaga (
       resultado_vaga_id SERIAL8 NOT NULL
     , resultado_fase_id INT8 NOT NULL
     , vaga_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (resultado_vaga_id)
);
CREATE INDEX IX_resultado_fase_id ON public.resultado_vaga (resultado_fase_id);
CREATE INDEX IX_vaga_id ON public.resultado_vaga (vaga_id);

CREATE TABLE public.classificacao_inscricao (
       classificacao_inscricao_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , pontuacao NUMERIC(19,2) NOT NULL
     , pontuacao_acumulada NUMERIC(19,2) NOT NULL
     , classificacao INTEGER
     , habilitado BOOLEAN NOT NULL
     , eliminado BOOLEAN NOT NULL
     , resultado_vaga_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (classificacao_inscricao_id)
);
CREATE INDEX IX_resultado_vaga_id ON public.classificacao_inscricao (resultado_vaga_id);
CREATE INDEX IX_inscricao_id ON public.classificacao_inscricao (inscricao_id);
CREATE INDEX IX_classificacao_inscricao_incricao_id_resultado_vaga_id ON public.classificacao_inscricao (inscricao_id, resultado_vaga_id);

CREATE TABLE public.pontuacao_prova_objetiva (
       pontuacao_prova_objetiva_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , pontuacao NUMERIC(19,2) NOT NULL
     , eliminavel BOOLEAN NOT NULL
     , classificacao_inscricao_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (pontuacao_prova_objetiva_id)
);
CREATE INDEX IX_pontuacao_prova_objetiva_cont_prova_id ON public.pontuacao_prova_objetiva (conteudo_prova_id);
CREATE INDEX IX_pontuacao_prova_objetiva_class_ins_id ON public.pontuacao_prova_objetiva (classificacao_inscricao_id);

CREATE TABLE public.gabarito_chave (
       gabarito_chave_id SERIAL8 NOT NULL
     , tipo_gabarito CHARACTER VARYING(2) NOT NULL
     , prova_id INT8 NOT NULL CONSTRAINT uq_prova_id UNIQUE
     , manter_correlacao_idiomas BOOL DEFAULT false
     , version INT4 NOT NULL
     , PRIMARY KEY (gabarito_chave_id)
);

CREATE TABLE public.gabarito_correlato (
       gabarito_correlato_id SERIAL8 NOT NULL
     , tipo_gabarito CHARACTER VARYING(2) NOT NULL
     , gabarito_chave_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (gabarito_correlato_id)
     , CONSTRAINT uq_tipo_gabarito_correlato UNIQUE (tipo_gabarito, gabarito_chave_id)
);
CREATE INDEX IX_gabarito_correlato_gab_chave_id ON public.gabarito_correlato (gabarito_chave_id);

CREATE TABLE public.banca_examinadora (
       banca_examinadora_id SERIAL8 NOT NULL
     , cpf CHARACTER VARYING(11) NOT NULL CONSTRAINT UQ_banca_examinadora_cpf UNIQUE
     , nome CHARACTER VARYING(100) NOT NULL
     , descricao_titulacao CHARACTER VARYING(240) NOT NULL
     , data_expiracao TIMESTAMP WITH TIME ZONE
     , email_principal CHARACTER VARYING(50)
     , email_secundario CHARACTER VARYING(50)
     , cep CHARACTER VARYING(10) NOT NULL
     , logradouro CHARACTER VARYING(240) NOT NULL
     , numero CHARACTER VARYING(5) NOT NULL
     , complemento CHARACTER VARYING(240)
     , bairro CHARACTER VARYING(60)
     , telefone_residencial CHARACTER VARYING(20)
     , telefone_funcional CHARACTER VARYING(20)
     , telefone_celular CHARACTER VARYING(20)
     , motivoBloqueio CHARACTER VARYING(240)
     , fax CHARACTER VARYING(20)
     , status CHARACTER VARYING(12)
     , senha CHARACTER VARYING(64) NOT NULL
     , senha_gerada BOOLEAN DEFAULT FALSE NOT NULL
     , uf_endereco_id INT8 NOT NULL
     , cidade CHARACTER VARYING(100) NOT NULL
     , email_privado VARCHAR(64) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (banca_examinadora_id)
);
CREATE INDEX IX_banca_exam_uf_end_id ON public.banca_examinadora (uf_endereco_id);

CREATE TABLE public.vinculo_banca_disciplina (
       vinculo_banca_disciplina_id SERIAL8 NOT NULL
     , prazo_maximo_devolucao TIMESTAMP WITH TIME ZONE NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , disciplina_id INT8 NOT NULL
     , idioma_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (vinculo_banca_disciplina_id)
);
CREATE INDEX IX_vinc_banc_disc_cont_prova_id ON public.vinculo_banca_disciplina (conteudo_prova_id);
CREATE INDEX IX_disciplina_idioma_id ON public.vinculo_banca_disciplina (disciplina_id, idioma_id);

CREATE TABLE public.questao_correlata (
       questao_correlata_id SERIAL8 NOT NULL
     , numero_questao_chave INT NOT NULL
     , numero_questao_correlata INT NOT NULL
     , gabarito_correlato_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (questao_correlata_id)
     , CONSTRAINT UQ_questao_correlata UNIQUE (numero_questao_chave, numero_questao_correlata, gabarito_correlato_id)
);
CREATE INDEX IX_questao_correlata_gab_correlato_id ON public.questao_correlata (gabarito_correlato_id);

CREATE TABLE public.banca_questoes (
       banca_questoes_id SERIAL8 NOT NULL
     , banca_examinadora_id INT8 NOT NULL
     , vinculo_banca_disciplina_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (banca_questoes_id)
     , CONSTRAINT UQ_banca_vinculo UNIQUE (banca_examinadora_id, vinculo_banca_disciplina_id)
);
CREATE INDEX IX_banca_questoes_banca_exam_id ON public.banca_questoes (banca_examinadora_id);
CREATE INDEX IX_banca_questoes_vinc_banca_disc_id ON public.banca_questoes (vinculo_banca_disciplina_id);

CREATE TABLE public.questao_banca (
       questao_banca_id SERIAL8 NOT NULL
     , numero_questao INT NOT NULL
     , banca_questoes_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (questao_banca_id)
     , CONSTRAINT UQ_questao_banca_numero UNIQUE (numero_questao, banca_questoes_id)
);
CREATE INDEX IX_questao_banca_banca_disc_id ON public.questao_banca (banca_questoes_id);

CREATE TABLE public.area (
       area_id SERIAL8 NOT NULL
     , nome VARCHAR(100) NOT NULL
     , assunto_id INT8 NOT NULL
     , desabilitada BOOLEAN NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (area_id)
     , CONSTRAINT UQ_area_mesmo_nome_e_assunto UNIQUE (nome, assunto_id)
);
CREATE INDEX IX_area_assunto_id ON public.area (assunto_id);

CREATE TABLE public.registro_importacao_cartao (
       reg_importacao_cartao_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , data_importacao TIMESTAMP WITH TIME ZONE NOT NULL
     , total_cartoes_processados_ok INT NOT NULL
     , total_cartoes_processados_erro INT NOT NULL
     , cpf_responsavel VARCHAR(11) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (reg_importacao_cartao_id)
);

CREATE TABLE public.parecer (
       parecer_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , texto_parecer TEXT
     , julgamento VARCHAR(20)
     , status VARCHAR(10) NOT NULL
     , exportado BOOLEAN NOT NULL
     , questao_banca_id INT8 NOT NULL
     , texto_parecer_revisado TEXT
     , motivo_retorno TEXT
     , prazo_maximo_devolucao TIMESTAMP WITH TIME ZONE NOT NULL
     , data_ultima_modificacao TIMESTAMP WITH TIME ZONE NOT NULL
     , data_liberacao TIMESTAMP WITH TIME ZONE
     , data_envio TIMESTAMP WITH TIME ZONE
     , revisado BOOLEAN DEFAULT false NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (parecer_id)
);
CREATE INDEX IX_parecer_questao_banca_id ON public.parecer (questao_banca_id);
CREATE INDEX IX_parecer_conteudo_prova_id ON public.parecer (conteudo_prova_id);

CREATE TABLE public.cartao_importacao_processado (
       cartao_imp_processado_id SERIAL8 NOT NULL
     , inscricao_id INT8
     , cidade_id INT8
     , conteudo_prova_id INT8
     , gabarito VARCHAR(2)
     , numero_caixa INT
     , posicao_caixa INT
     , status VARCHAR(20) NOT NULL
     , em_branco BOOLEAN NOT NULL
     , arquivo_anexo_id INT8
     , idioma_id INT8
     , sequencial_cartao_concurso INT8
     , sequencial_cartao_incluido INT8
     , cartao_res_import_id INT8 NOT NULL
     , reg_importacao_cartao_id INT8 NOT NULL
     , data_exclusao TIMESTAMP WITH TIME ZONE
     , cpf_responsavel_exclusao VARCHAR(11)
     , nome_responsavel_exclusao VARCHAR(100)
     , version INT4 NOT NULL
     , PRIMARY KEY (cartao_imp_processado_id)
);

CREATE TABLE public.orgao_concurso (
       orgao_concurso_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , orgao_contratante_id INT8 NOT NULL
     , PRIMARY KEY (orgao_concurso_id)
);
CREATE INDEX IX_orgao_concurso_concurso_id ON public.orgao_concurso (concurso_id);

CREATE TABLE public.disciplina_prova_objetiva (
       disciplina_prova_objetiva_id SERIAL8 NOT NULL
     , disciplina_id INT8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , quantidade_questoes INTEGER NOT NULL
     , peso NUMERIC(19,2) NOT NULL
     , pontuacao_minima NUMERIC(19,2)
     , version INT4 NOT NULL
     , PRIMARY KEY (disciplina_prova_objetiva_id)
);
CREATE INDEX IX_disciplina_prova_objetiva_disc_id ON public.disciplina_prova_objetiva (disciplina_id);
CREATE INDEX IX_disciplina_prova_objetiva_cont_prova_id ON public.disciplina_prova_objetiva (conteudo_prova_id);

CREATE TABLE public.idioma_oferta_cargo_concurso (
       idioma_oferta_cargo_concurso_id SERIAL8 NOT NULL
     , oferta_cargo_concurso_id INT8 NOT NULL
     , idioma_id INT8 NOT NULL
     , PRIMARY KEY (idioma_oferta_cargo_concurso_id)
);

CREATE TABLE public.subprova_prova_objetiva (
       subprova_prova_objetiva_id SERIAL8 NOT NULL
     , subprova_id INT8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , PRIMARY KEY (subprova_prova_objetiva_id)
     , CONSTRAINT UQ_subprova_conteudo_prova_objetiva_1 UNIQUE (subprova_id, conteudo_prova_id)
);
CREATE INDEX IX_subprova_prova_objetiva_cont_prova_id ON public.subprova_prova_objetiva (conteudo_prova_id);

CREATE TABLE public.disciplina_subprova (
       disciplina_subprova_id SERIAL8 NOT NULL
     , subprova_id INT8 NOT NULL
     , disciplina_id INT8 NOT NULL
     , quantidade_questoes INTEGER
     , peso NUMERIC(19,2)
     , pontuacao_minima NUMERIC(19,2)
     , version INT4 NOT NULL
     , PRIMARY KEY (disciplina_subprova_id)
     , CONSTRAINT UQ_disciplina_subprova_1 UNIQUE (subprova_id, disciplina_id)
);
CREATE INDEX IX_disciplina_subprova_subprova_id ON public.disciplina_subprova (subprova_id);

CREATE TABLE public.ofertas_cargos_prorrogacao_concurso (
       ofertas_cargos_prorrogacao_concurso_id SERIAL8 NOT NULL
     , prorrogacao_prazos_concurso_id INT8 NOT NULL
     , oferta_cargo_concurso_id INT8 NOT NULL
     , PRIMARY KEY (ofertas_cargos_prorrogacao_concurso_id)
);
CREATE INDEX IX_ofertas_cargos_prorrogacao_concurso_pror_praz_id ON public.ofertas_cargos_prorrogacao_concurso (prorrogacao_prazos_concurso_id);

CREATE TABLE public.uf_estrutura_cidade (
       uf_estrutura_cidade_id SERIAL NOT NULL
     , uf_estrutura_id INT8 NOT NULL
     , cidade_id INT8 NOT NULL
     , PRIMARY KEY (uf_estrutura_cidade_id)
);
CREATE INDEX IX_uf_estrutura_cidade_uf_estr_id ON public.uf_estrutura_cidade (uf_estrutura_id);

CREATE TABLE public.campo_formulario_inscricao (
       campo_formulario_inscricao_id SERIAL8 NOT NULL
     , formulario_inscricao_id INT8 NOT NULL
     , nome VARCHAR(50) NOT NULL
     , PRIMARY KEY (campo_formulario_inscricao_id)
     , CONSTRAINT UQ_formulario_inscricao_nome UNIQUE (formulario_inscricao_id, nome)
);
CREATE INDEX IX_campo_formulario_inscricao_form_insc_id ON public.campo_formulario_inscricao (formulario_inscricao_id);

CREATE TABLE public.isencao (
       isencao_id SERIAL8 NOT NULL
     , tipo_isencao CHARACTER VARYING(10) NOT NULL
     , observacao CHARACTER VARYING(200)
     , percentual INTEGER
     , concurso_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (isencao_id)
);

CREATE TABLE public.inscricao_tratamento_diferenciado (
       insc_trat_dif_id SERIAL8 NOT NULL
     , tratamento_diferenciado_id INT8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , texto_da_carta VARCHAR(150)
     , etapa_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (insc_trat_dif_id)
     , CONSTRAINT UQ_insc_trat_diferenciado UNIQUE (tratamento_diferenciado_id, inscricao_id, etapa_id)
);
CREATE INDEX IX_inscricao_tratamento_diferenciado_insc_id ON public.inscricao_tratamento_diferenciado (inscricao_id);

CREATE TABLE public.inscricao_historico_localidade (
       insc_hist_local_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , cidade_id INT8 NOT NULL
     , data_alteracao TIMESTAMP NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (insc_hist_local_id)
);
CREATE INDEX IX_inscricao_historico_localidade_insc_id ON public.inscricao_historico_localidade (inscricao_id);

CREATE TABLE public.anexo_local_prova (
       anexo_local_prova_id SERIAL8 NOT NULL
     , tipo_arquivo VARCHAR(6) NOT NULL
     , local_prova_id INT8 NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (anexo_local_prova_id)
);
CREATE INDEX IX_anexo_local_prova_local_prova_id ON public.anexo_local_prova (local_prova_id);

CREATE TABLE public.criterio_desempate_maior_nota_disc (
       criterio_desempate_maior_nota_disc_id SERIAL8 NOT NULL
     , disciplina_id INT8 NOT NULL
     , criterio_desempate_id INT8 NOT NULL
     , PRIMARY KEY (criterio_desempate_maior_nota_disc_id)
);

CREATE TABLE public.criterio_desempate_maior_nota_provas (
       criterio_desempate_maior_nota_provas_id SERIAL8 NOT NULL
     , criterio_desempate_id INT8 NOT NULL
     , prova_id INT8 NOT NULL
     , PRIMARY KEY (criterio_desempate_maior_nota_provas_id)
);

CREATE TABLE public.vinculo_fase_prova (
       vinculo_fase_prova_id SERIAL8 NOT NULL
     , vinculo_fase_id INT8 NOT NULL
     , prova_id INT8 NOT NULL
     , PRIMARY KEY (vinculo_fase_prova_id)
);
CREATE INDEX IX_vinculo_fase_prova_vinculo_fase_id ON public.vinculo_fase_prova (vinculo_fase_id);
CREATE INDEX IX_vinculo_fase_prova_prova_id ON public.vinculo_fase_prova (prova_id);

CREATE TABLE public.erro_arquivo_pagamento (
       erro_arquivo_pagamento_id BIGSERIAL NOT NULL
     , numero_linha INTEGER NOT NULL
     , mensagem_erro TEXT NOT NULL
     , arquivo_pagamento_id BIGINT NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (erro_arquivo_pagamento_id)
);

CREATE TABLE public.reserva_lugares_sala (
       reserva_lugares_sala_id SERIAL8 NOT NULL
     , lugares_reservados INT4 NOT NULL
     , oferta_cargo_concurso_id INT8 NOT NULL
     , idioma_id INT8
     , reserva_sala_aplic_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (reserva_lugares_sala_id)
     , CONSTRAINT UQ_reserva_lugares_aplicacao UNIQUE (oferta_cargo_concurso_id, idioma_id, reserva_sala_aplic_id)
);
CREATE INDEX reserva_sala_aplicacao_idx ON public.reserva_lugares_sala (reserva_sala_aplic_id);

CREATE TABLE public.historico_status_alocacao (
       historico_status_alocacao_id SERIAL8 NOT NULL
     , status_alocacao CHARACTER VARYING(30) NOT NULL
     , data_mudanca_status TIMESTAMP WITH TIME ZONE NOT NULL
     , localidade_prova_alocacao_id INT8 NOT NULL
     , usuario_responsavel_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (historico_status_alocacao_id)
);
CREATE INDEX "IX_historico_status_alocacao_loc_prova)id" ON public.historico_status_alocacao (localidade_prova_alocacao_id);

CREATE TABLE public.vistoria_local_prova_item (
       vistoria_local_prova_item_id SERIAL8 NOT NULL
     , vistoria_local_prova_id INT8 NOT NULL
     , valor BOOL NOT NULL
     , observacao CHARACTER VARYING(100)
     , tipo_item CHARACTER VARYING(50) NOT NULL
     , qtd_salas_especiais INTEGER
     , version INT4 NOT NULL
     , PRIMARY KEY (vistoria_local_prova_item_id)
);
CREATE INDEX IX_vistoria_local_prova_item_vist_local_prova_id ON public.vistoria_local_prova_item (vistoria_local_prova_id);

CREATE TABLE public.criterio_desempate_maior_nota_subprovas (
       crit_des_maior_nota_sub_id SERIAL8 NOT NULL
     , criterio_desempate_id INT8 NOT NULL
     , subprova_id INT8 NOT NULL
     , PRIMARY KEY (crit_des_maior_nota_sub_id)
);

CREATE TABLE public.arquivo_mds_inscricao (
       arq_mds_inscricao_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , arquivo_mds_id INT8 NOT NULL
     , PRIMARY KEY (arq_mds_inscricao_id)
);
CREATE INDEX IX_arquivo_mds_inscricao_insc_id ON public.arquivo_mds_inscricao (inscricao_id);
CREATE INDEX IX_arquivo_mds_inscricao_arq_mds_id ON public.arquivo_mds_inscricao (arquivo_mds_id);

CREATE TABLE public.gabarito_prova_inscricao (
       gabarito_prova_inscricao_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , alocacao_inscricao_id INT8
     , prova_id INT8 NOT NULL
     , gabarito CHARACTER VARYING(5) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (gabarito_prova_inscricao_id)
     , CONSTRAINT UQ_gabarito_prova_inscricao_prova_id_inscricao_id UNIQUE (inscricao_id, prova_id)
);
CREATE INDEX IX_gabarito_prova_inscricao_inscricao_id ON public.gabarito_prova_inscricao (inscricao_id);
CREATE UNIQUE INDEX IX_gabarito_prova_inscricao_inscricao_id_prova_id ON public.gabarito_prova_inscricao (inscricao_id, prova_id);

CREATE TABLE public.inscricoes_arquivo_pagamento (
       inscricoes_arquivo_pagamento_id SERIAL8 NOT NULL
     , arquivo_pagamento_id BIGINT NOT NULL
     , inscricao_id INT8 NOT NULL
     , PRIMARY KEY (inscricoes_arquivo_pagamento_id)
);
CREATE INDEX IX_inscricoes_arquivo_pagamento_arq_pag_id ON public.inscricoes_arquivo_pagamento (arquivo_pagamento_id);
CREATE INDEX IX_inscricoes_arquivo_pagamento_insc_id ON public.inscricoes_arquivo_pagamento (inscricao_id);

CREATE TABLE public.nota_titulo (
       nota_titulo_id SERIAL8 NOT NULL
     , apresentou_titulo BOOL NOT NULL
     , valor NUMERIC(19,2)
     , titulo_prova_titulos_id INT8 NOT NULL
     , resultado_prova_manual_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (nota_titulo_id)
);
CREATE INDEX IX_nota_titulo_titulo_prova_titulos_id ON public.nota_titulo (titulo_prova_titulos_id);
CREATE INDEX IX_resultado_prova_manual_id ON public.nota_titulo (resultado_prova_manual_id);

CREATE TABLE public.nota_questao (
       nota_questao_id SERIAL8 NOT NULL
     , conteudo NUMERIC(19,2)
     , idioma NUMERIC(19,2)
     , questao_prova_subjetiva_id INT8 NOT NULL
     , resultado_prova_manual_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (nota_questao_id)
);
CREATE INDEX IX_nota_questao_questao_prova_id ON public.nota_questao (questao_prova_subjetiva_id);
CREATE INDEX IX_nota_questao_resultado_prova_manual_id ON public.nota_questao (resultado_prova_manual_id);

CREATE TABLE public.nota_habilitacao (
       nota_habilitacao_id SERIAL8 NOT NULL
     , apto BOOL
     , motivacao TEXT
     , resultado_prova_manual_id INT8 NOT NULL CONSTRAINT UQ_RESULTADO_PROVA_HABILITACAO UNIQUE
     , PRIMARY KEY (nota_habilitacao_id)
);
CREATE INDEX IX_nota_habilitacao_res_pro_man ON public.nota_habilitacao (resultado_prova_manual_id);

CREATE TABLE public.divergencia_cartao_repetido (
       divergencia_cartao_repetido_id SERIAL8 NOT NULL
     , cartao_resposta_id INT8 NOT NULL
     , diverg_fec_concurso_id INT8 NOT NULL
     , PRIMARY KEY (divergencia_cartao_repetido_id)
);

CREATE TABLE public.divergencia_resultado_repetido (
       divergencia_resultado_repetido SERIAL8 NOT NULL
     , diverg_fec_concurso_id INT8 NOT NULL
     , resultado_prova_manual_id INT8 NOT NULL
     , PRIMARY KEY (divergencia_resultado_repetido)
);
CREATE INDEX IX_divergencia_res_rep_fec_conc ON public.divergencia_resultado_repetido (diverg_fec_concurso_id);
CREATE INDEX IX_divergencia_res_rep_res_pr_man ON public.divergencia_resultado_repetido (resultado_prova_manual_id);

CREATE TABLE public.questao_gabarito (
       questao_gabarito_id BIGSERIAL NOT NULL
     , gabarito_prova_id BIGINT NOT NULL
     , idioma_id INT8
     , numero_questao INT NOT NULL
     , resposta_questao CHARACTER VARYING(4)
     , anulada BOOLEAN NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (questao_gabarito_id)
);
CREATE INDEX IX_questao_gabarito_gab_prova_id ON public.questao_gabarito (gabarito_prova_id);

CREATE TABLE public.ordenacao_disciplina_gabarito (
       ordenacao_disciplina_gabarito_id BIGSERIAL NOT NULL
     , gabarito_prova_id BIGINT NOT NULL
     , disciplina_id INT8 NOT NULL
     , ordem_disciplina INT NOT NULL
     , PRIMARY KEY (ordenacao_disciplina_gabarito_id)
);
CREATE INDEX IX_ordenacao_disciplina_gabarito_gab_prova_id ON public.ordenacao_disciplina_gabarito (gabarito_prova_id);

CREATE TABLE public.ocorrencia (
       ocorrencia_id SERIAL8 NOT NULL
     , data TIMESTAMP NOT NULL
     , descricao VARCHAR(500) NOT NULL
     , concurso_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (ocorrencia_id)
);

CREATE TABLE public.historico_presenca_inscricao (
       historico_presenca_inscr_id SERIAL8 NOT NULL
     , presenca_inscricao_id INT8 NOT NULL
     , situacao_anterior CHARACTER VARYING(8) NOT NULL
     , data_alteracao TIMESTAMP WITH TIME ZONE NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (historico_presenca_inscr_id)
);
CREATE INDEX IX_historico_presenca_inscricao_pres_ins ON public.historico_presenca_inscricao (presenca_inscricao_id);

CREATE TABLE public.idioma_concurso (
       idioma_concurso_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , idioma_id INT8 NOT NULL
     , PRIMARY KEY (idioma_concurso_id)
);
CREATE INDEX IX_idioma_concurso_concurso_id ON public.idioma_concurso (concurso_id);

CREATE TABLE public.permissao_usuario_concurso (
       perm_usuario_conc_id SERIAL8
     , usuario_id INT8 NOT NULL
     , concurso_id INT8 NOT NULL
     , tipo_permissao CHARACTER VARYING(20) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (perm_usuario_conc_id)
     , CONSTRAINT UQ_permissao_usuario_concurso_1 UNIQUE (usuario_id, concurso_id, tipo_permissao)
);
CREATE INDEX idx_perm_usuario_conc_usuario_id ON public.permissao_usuario_concurso (usuario_id);

CREATE TABLE public.pontuacao_subprova (
       pontuacao_subprova_id SERIAL8 NOT NULL
     , pontuacao NUMERIC(19,2) NOT NULL
     , eliminavel BOOLEAN NOT NULL
     , subprova_id INT8 NOT NULL
     , pontuacao_prova_objetiva_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (pontuacao_subprova_id)
);
CREATE INDEX IX_pontuacao_subprova_subprova_id ON public.pontuacao_subprova (subprova_id);
CREATE INDEX IX_pontuacao_subprova_pont_prova_obj_id ON public.pontuacao_subprova (pontuacao_prova_objetiva_id);

CREATE TABLE public.pontuacao_disciplina (
       pontuacao_disciplina_id SERIAL8 NOT NULL
     , pontuacao NUMERIC(19,2)
     , eliminavel BOOLEAN NOT NULL
     , pontuacao_prova_objetiva_id INT8 NOT NULL
     , disciplina_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (pontuacao_disciplina_id)
);
CREATE INDEX IX_pontuacao_prova_objetiva_id ON public.pontuacao_disciplina (pontuacao_prova_objetiva_id);
CREATE INDEX IX_disciplina_id ON public.pontuacao_disciplina (disciplina_id);

CREATE TABLE public.pontuacao_prova_questoes (
       pontuacao_prova_questoes_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , pontuacao NUMERIC(19,2) NOT NULL
     , eliminavel BOOLEAN NOT NULL
     , classificacao_inscricao_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (pontuacao_prova_questoes_id)
);
CREATE INDEX IX_pontuacao_prova_conteudo_prova_id ON public.pontuacao_prova_questoes (conteudo_prova_id);
CREATE INDEX IX_pontuacao_prova_questoes_class_ins_id ON public.pontuacao_prova_questoes (classificacao_inscricao_id);

CREATE TABLE public.pontuacao_prova_titulos (
       pontuacao_prova_titulos_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , pontuacao NUMERIC(19,2)
     , eliminavel BOOLEAN NOT NULL
     , classificacao_inscricao_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (pontuacao_prova_titulos_id)
);
CREATE INDEX IX_pontuacao_prova_titulos_cont_prova_id ON public.pontuacao_prova_titulos (conteudo_prova_id);
CREATE INDEX IX_pontuacao_prova_titulos_class_ins_id ON public.pontuacao_prova_titulos (classificacao_inscricao_id);

CREATE TABLE public.pontuacao_prova_habilitacao (
       pontuacao_prova_habilitacao_id SERIAL8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , apto BOOLEAN NOT NULL
     , classificacao_inscricao_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (pontuacao_prova_habilitacao_id)
);
CREATE INDEX IX_pont_prova_hab_cont_prova_id ON public.pontuacao_prova_habilitacao (conteudo_prova_id);
CREATE INDEX IX_classificacao_inscricao_id ON public.pontuacao_prova_habilitacao (classificacao_inscricao_id);

CREATE TABLE public.idiomas_gabarito_prova (
       idiomas_gabarito_prova_id SERIAL8 NOT NULL
     , gabarito_prova_id BIGINT NOT NULL
     , idioma_id INT8 NOT NULL
     , PRIMARY KEY (idiomas_gabarito_prova_id)
);
CREATE INDEX IX_idiomas_gabarito_prova_gab_prova_id ON public.idiomas_gabarito_prova (gabarito_prova_id);

CREATE TABLE public.questao_cartao_resposta (
       questao_cartao_resposta_id SERIAL8 NOT NULL
     , numero_questao INT NOT NULL
     , resposta_questao CHARACTER VARYING(8) NOT NULL
     , cartao_resposta_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (questao_cartao_resposta_id)
);
CREATE INDEX IX_questao_cartao_resposta_cartao_resposta_id ON public.questao_cartao_resposta (cartao_resposta_id);

CREATE TABLE public.historico_motivo_bloqueio (
       historico_motivo_bloqueio_id SERIAL8 NOT NULL
     , motivo CHARACTER VARYING(240) NOT NULL
     , data_bloqueio TIMESTAMP WITH TIME ZONE NOT NULL
     , banca_examinadora_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (historico_motivo_bloqueio_id)
);
CREATE INDEX IX_historico_motivo_bloqueio_banca_exam_id ON public.historico_motivo_bloqueio (banca_examinadora_id);

CREATE TABLE public.arquivo_banca (
       arquivo_banca_id SERIAL8 NOT NULL
     , banca_questoes_id INT8 NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (arquivo_banca_id)
);
CREATE INDEX IX_arquivo_banca_banca_disc_id ON public.arquivo_banca (banca_questoes_id);

CREATE TABLE public.recurso (
       recurso_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , tipo_gabarito CHARACTER VARYING(2) NOT NULL
     , numero_questao INT NOT NULL
     , numero_questao_chave INT NOT NULL
     , numero_sequencial INT
     , fundamentacao TEXT NOT NULL
     , fonte_argumentacao TEXT NOT NULL
     , data_hora_envio TIMESTAMP
     , status CHARACTER VARYING(8) NOT NULL
     , bloqueado BOOL NOT NULL
     , disciplina_id INT8 NOT NULL
     , idioma_id INT8
     , version INT4 NOT NULL
     , PRIMARY KEY (recurso_id)
     , CONSTRAINT UQ_questao_prova_inscricao UNIQUE (inscricao_id, conteudo_prova_id, numero_questao_chave)
     , CONSTRAINT UQ_prova_questao_sequencial UNIQUE (conteudo_prova_id, numero_questao_chave, numero_sequencial)
);
CREATE INDEX IX_recurso_inscricao_id ON public.recurso (inscricao_id);
CREATE INDEX IX_recurso_conteudo_prova_id ON public.recurso (conteudo_prova_id);

CREATE TABLE public.area_banca_examinadora (
       area_banca_examinadora_id SERIAL8 NOT NULL
     , prioridade INTEGER NOT NULL
     , banca_examinadora_id INT8 NOT NULL
     , area_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (area_banca_examinadora_id)
);
CREATE INDEX IX_area_banca_examinadora_id ON public.area_banca_examinadora (banca_examinadora_id);
CREATE INDEX IX_area_banca_examinadora_area_id ON public.area_banca_examinadora (area_id);

CREATE TABLE public.orientacao_recurso (
       orientacao_recurso_id SERIAL8 NOT NULL
     , texto_orientacao CHARACTER VARYING(2000) NOT NULL
     , fase_id INT8 NOT NULL CONSTRAINT UQ_orientacao_recurso_fase_id UNIQUE
     , version INT4 NOT NULL
     , PRIMARY KEY (orientacao_recurso_id)
);

CREATE TABLE public.visao_candidato (
       visao_candidato_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , prova_id INT8
     , etapa_id INT8
     , data_inicial TIMESTAMP WITH TIME ZONE
     , data_final TIMESTAMP WITH TIME ZONE
     , tipo_funcionalidade VARCHAR(20) NOT NULL
     , ativa BOOL NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (visao_candidato_id)
);

CREATE TABLE public.localidade_prova_inscricao (
       localidade_prova_inscricao_id SERIAL8 NOT NULL
     , etapa_id INT8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , cidade_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (localidade_prova_inscricao_id)
     , CONSTRAINT UQ_localidade_prova_inscricao UNIQUE (etapa_id, inscricao_id)
);

CREATE TABLE public.historico_questao_banca (
       historico_questao_banca_id SERIAL8 NOT NULL
     , data_vinculacao TIMESTAMP WITH TIME ZONE NOT NULL
     , questao_banca_id INT8
     , banca_examinadora_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (historico_questao_banca_id)
);

CREATE TABLE public.qtd_min_provas_corrigidas (
       qtd_min_provas_corrigidas_id SERIAL8 NOT NULL
     , quantidade_minima_provas_corrigidas_ampla INT
     , quantidade_minima_provas_corrigidas_deficiencia INT
     , vinculo_fase_id INT8 NOT NULL
     , vaga_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (qtd_min_provas_corrigidas_id)
);
CREATE INDEX IX_qtd_min_provas_corrigidas_1 ON public.qtd_min_provas_corrigidas (vinculo_fase_id, vaga_id);

CREATE TABLE public.inscricao_historico_status (
       insc_hist_status_id SERIAL8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , status VARCHAR(33) NOT NULL
     , motivo_alteracao_status VARCHAR(400) NOT NULL
     , data_alteracao TIMESTAMP NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (insc_hist_status_id)
);

CREATE TABLE public.anexo_vistoria (
       anexo_vistoria_id SERIAL8 NOT NULL
     , vistoria_local_prova_id INT8 NOT NULL
     , tipo_arquivo CHARACTER VARYING(20) NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (anexo_vistoria_id)
);

CREATE TABLE public.parecer_historico_tramite (
       parecer_tramite_id SERIAL8 NOT NULL
     , parecer_id INT8 NOT NULL
     , data TIMESTAMP WITH TIME ZONE NOT NULL
     , operacao VARCHAR(30) NOT NULL
     , nome_responsavel VARCHAR(100) NOT NULL
     , cpf_responsavel VARCHAR(11) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (parecer_tramite_id)
);

CREATE TABLE public.alternativa_questao_correlata (
       alternativa_questao_corr_id SERIAL8 NOT NULL
     , questao_correlata_id INT8 NOT NULL
     , idioma_id INT8
     , item_a CHARACTER VARYING(1) NOT NULL
     , item_b CHARACTER VARYING(1) NOT NULL
     , item_c CHARACTER VARYING(1) NOT NULL
     , item_d CHARACTER VARYING(1) NOT NULL
     , item_e CHARACTER VARYING(1) NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (alternativa_questao_corr_id)
     , CONSTRAINT UQ_alternativa_questao_correlata_questao_idioma UNIQUE (questao_correlata_id, idioma_id)
);
CREATE INDEX IX_alternativa_questao_correlata_ques_id ON public.alternativa_questao_correlata (questao_correlata_id);
CREATE INDEX IX_alternativa_questao_correlata_idioma ON public.alternativa_questao_correlata (idioma_id);

CREATE TABLE public.diverg_fec_localidade_inscricao (
       diverg_fec_localidade_inscricao_id BIGSERIAL NOT NULL
     , diverg_fec_localidade_id INT8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , PRIMARY KEY (diverg_fec_localidade_inscricao_id)
     , CONSTRAINT UQ_diverg_fec_localidade_inscricao UNIQUE (diverg_fec_localidade_id, inscricao_id)
);
CREATE INDEX IX_diverg_fec_localidade_inscricao_insc_id ON public.diverg_fec_localidade_inscricao (inscricao_id);
CREATE INDEX IX_diverg_fec_localidade_inscricao_diver_id ON public.diverg_fec_localidade_inscricao (diverg_fec_localidade_id);

CREATE TABLE public.diverg_fec_concurso_inscricao (
       diverg_fec_concurso_ins_id BIGSERIAL NOT NULL
     , diverg_fec_concurso_id INT8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , PRIMARY KEY (diverg_fec_concurso_ins_id)
     , CONSTRAINT UQ_diverg_fec_concurso_inscricao_div UNIQUE (diverg_fec_concurso_id, inscricao_id)
);
CREATE INDEX IX_diverg_fec_concurso_inscricao_ins ON public.diverg_fec_concurso_inscricao (inscricao_id);
CREATE INDEX IX_diverg_fec_concurso_inscricao_div ON public.diverg_fec_concurso_inscricao (diverg_fec_concurso_id);

CREATE TABLE public.imagem_parecer (
       imagem_parecer_id SERIAL8 NOT NULL
     , parecer_id INT8 NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , PRIMARY KEY (imagem_parecer_id)
);

CREATE TABLE public.imagem_folha (
       imagem_folha_id SERIAL8 NOT NULL
     , arquivo_anexo_id INT8 NOT NULL
     , lista_presenca_id INT8 NOT NULL
     , PRIMARY KEY (imagem_folha_id)
);

CREATE TABLE public.cartao_incluido (
       cartao_incluido_id SERIAL8 NOT NULL
     , gabarito VARCHAR(2) NOT NULL
     , sequencial_cartao_incluido INT8 NOT NULL
     , inscricao_id INT8 NOT NULL
     , conteudo_prova_id INT8 NOT NULL
     , idioma_id INT8 NOT NULL
     , cidade_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (cartao_incluido_id)
);

CREATE TABLE public.erro_arquivo_mds (
       erro_arquivo_mds_id SERIAL8 NOT NULL
     , arquivo_mds_id INT8 NOT NULL
     , numero_linha INTEGER NOT NULL
     , mensagem_erro TEXT NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (erro_arquivo_mds_id)
);

CREATE TABLE public.erro_importacao_cartao (
       erro_importacao_cartao_id SERIAL8 NOT NULL
     , erro_ocorrido VARCHAR(60) NOT NULL
     , cartao_imp_processado_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (erro_importacao_cartao_id)
);

CREATE TABLE public.questao_cartao_processado (
       questao_cartao_processado_id SERIAL8 NOT NULL
     , numero_questao INT NOT NULL
     , resposta_questao CHARACTER VARYING(8) NOT NULL
     , cartao_imp_processado_id INT8 NOT NULL
     , version INT4 NOT NULL
     , PRIMARY KEY (questao_cartao_processado_id)
);

CREATE TABLE public.cidades_concurso (
       cidades_concurso_id SERIAL8 NOT NULL
     , concurso_id INT8 NOT NULL
     , cidade_id INT8 NOT NULL
     , PRIMARY KEY (cidades_concurso_id)
);
CREATE INDEX IX_cidades_concurso_concurso_id ON public.cidades_concurso (concurso_id);

ALTER TABLE public.campo_atuacao
  ADD CONSTRAINT FK_campo_atuacao_1
      FOREIGN KEY (cargo_id)
      REFERENCES public.cargo (cargo_id);

ALTER TABLE public.campo_orgao
  ADD CONSTRAINT FK_campo_orgao_2
      FOREIGN KEY (orgao_contratante_id)
      REFERENCES public.orgao_contratante (orgao_contratante_id);

ALTER TABLE public.campo_orgao
  ADD CONSTRAINT FK_campo_orgao_3
      FOREIGN KEY (campo_atuacao_id)
      REFERENCES public.campo_atuacao (campo_atuacao_id);

ALTER TABLE public.campo_orgao
  ADD CONSTRAINT FK_campo_orgao_4
      FOREIGN KEY (cargo_id)
      REFERENCES public.cargo (cargo_id);

ALTER TABLE public.cidade
  ADD CONSTRAINT FK_cidade_1
      FOREIGN KEY (uf_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.estrutura
  ADD CONSTRAINT FK_estrutura_1
      FOREIGN KEY (orgao_contratante_id)
      REFERENCES public.orgao_contratante (orgao_contratante_id);

ALTER TABLE public.local_prova
  ADD CONSTRAINT FK_local_prova_1
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.local_prova
  ADD CONSTRAINT FK_local_prova_2
      FOREIGN KEY (uf_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.uf_estrutura
  ADD CONSTRAINT FK_uf_estrutura_2
      FOREIGN KEY (uf_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.uf_estrutura
  ADD CONSTRAINT FK_uf_estrutura_3
      FOREIGN KEY (estrutura_id)
      REFERENCES public.estrutura (estrutura_id);

ALTER TABLE public.usuario
  ADD CONSTRAINT FK_usuario_1
      FOREIGN KEY (uf_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.vaga
  ADD CONSTRAINT FK_vaga_4
      FOREIGN KEY (uf_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.vaga
  ADD CONSTRAINT FK_vaga_5
      FOREIGN KEY (estrutura_id)
      REFERENCES public.estrutura (estrutura_id);

ALTER TABLE public.vaga
  ADD CONSTRAINT FK_vaga_6
      FOREIGN KEY (oferta_cargo_concurso_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.vaga
  ADD CONSTRAINT FK_vaga_7
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.etapa
  ADD CONSTRAINT FK_Etapa_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.oferta_cargo_concurso
  ADD CONSTRAINT FK_campo_concurso_3
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.oferta_cargo_concurso
  ADD CONSTRAINT FK_campo_concurso_2
      FOREIGN KEY (campo_orgao_id)
      REFERENCES public.campo_orgao (campo_orgao_id);

ALTER TABLE public.vistoria_local_prova
  ADD CONSTRAINT FK_cidades_concurso_locais_3
      FOREIGN KEY (local_prova_id)
      REFERENCES public.local_prova (local_prova_id);

ALTER TABLE public.vistoria_local_prova
  ADD CONSTRAINT FK_vistoria_local_prova_2
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.aplicacao_prova
  ADD CONSTRAINT FK_aplicacao_prova_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.subprova
  ADD CONSTRAINT FK_subprova_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.questao_prova_subjetiva
  ADD CONSTRAINT FK_questao_prova_1
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.titulo_prova_titulos
  ADD CONSTRAINT FK_titulo_prova_1
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.prorrogacao_prazos_concurso
  ADD CONSTRAINT FK_prorrogacao_prazos_concurso_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.candidato
  ADD CONSTRAINT FK_candidato_1
      FOREIGN KEY (uf_identidade_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.candidato
  ADD CONSTRAINT FK_candidato_3
      FOREIGN KEY (uf_identidade_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.candidato
  ADD CONSTRAINT FK_candidato_4
      FOREIGN KEY (uf_endereco_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.prova
  ADD CONSTRAINT FK_prova_1
      FOREIGN KEY (aplicacao_prova_id)
      REFERENCES public.aplicacao_prova (aplicacao_prova_id);

ALTER TABLE public.prova
  ADD CONSTRAINT FK_prova_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.prova
  ADD CONSTRAINT FK_prova_3
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.formulario_inscricao
  ADD CONSTRAINT FK_formulario_inscricao_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.fase
  ADD CONSTRAINT FK_Fase_1
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_1
      FOREIGN KEY (candidato_id)
      REFERENCES public.candidato (candidato_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_5
      FOREIGN KEY (area_formacao_id)
      REFERENCES public.area_formacao (area_formacao_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_6
      FOREIGN KEY (nivel_escolaridade_id)
      REFERENCES public.nivel_escolaridade (nivel_escolaridade_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_8
      FOREIGN KEY (cidade_prova_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_9
      FOREIGN KEY (vaga_id)
      REFERENCES public.vaga (vaga_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_7
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_4
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_10
      FOREIGN KEY (uf_identidade_nis_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.inscricao
  ADD CONSTRAINT FK_inscricao_11
      FOREIGN KEY (motivo_indeferimento_id)
      REFERENCES public.motivo_indeferimento (motivo_indeferimento_id);

ALTER TABLE public.vinculo_fase
  ADD CONSTRAINT FK_vinculo_prova_fase_1
      FOREIGN KEY (fase_predecessora_id)
      REFERENCES public.fase (fase_id);

ALTER TABLE public.vinculo_fase
  ADD CONSTRAINT FK_vinculo_prova_fase_2
      FOREIGN KEY (fase_id)
      REFERENCES public.fase (fase_id);

ALTER TABLE public.vinculo_fase
  ADD CONSTRAINT FK_vinculo_prova_fase_3
      FOREIGN KEY (oferta_cargo_concurso_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.arquivo_pagamento
  ADD CONSTRAINT FK_arquivo_pagamento_1
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.bloco_local_prova
  ADD CONSTRAINT FK_bloco_local_prova_1
      FOREIGN KEY (local_prova_id)
      REFERENCES public.local_prova (local_prova_id);

ALTER TABLE public.criterio_desempate
  ADD CONSTRAINT FK_criterio_desempate_4
      FOREIGN KEY (vinculo_fase_id)
      REFERENCES public.vinculo_fase (vinculo_fase_id);

ALTER TABLE public.andar_local_prova
  ADD CONSTRAINT FK_andar_local_prova_1
      FOREIGN KEY (bloco_local_prova_id)
      REFERENCES public.bloco_local_prova (bloco_local_prova_id);

ALTER TABLE public.sala_local_prova
  ADD CONSTRAINT FK_sala_local_prova_1
      FOREIGN KEY (andar_local_prova_id)
      REFERENCES public.andar_local_prova (andar_local_prova_id);

ALTER TABLE public.reserva_local_prova
  ADD CONSTRAINT FK_local_prova
      FOREIGN KEY (local_prova_id)
      REFERENCES public.local_prova (local_prova_id);

ALTER TABLE public.reserva_local_prova
  ADD CONSTRAINT FK_reserva_local_prova_2
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.local_execucao
  ADD CONSTRAINT FK_local_execucao_1
      FOREIGN KEY (reserva_local_prova_id)
      REFERENCES public.reserva_local_prova (reserva_local_prova_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT fk_reserva_local_prova
      FOREIGN KEY (reserva_local_prova_id)
      REFERENCES public.reserva_local_prova (reserva_local_prova_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT FK_sala_local_prova
      FOREIGN KEY (sala_local_prova_id)
      REFERENCES public.sala_local_prova (sala_local_prova_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT FK_reserva_sala_3
      FOREIGN KEY (local_execucao_id)
      REFERENCES public.local_execucao (local_execucao_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT FK_reserva_sala_7
      FOREIGN KEY (oferta_sala_extra_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT FK_reserva_sala_8
      FOREIGN KEY (oferta_sala_extra_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT FK_reserva_sala_6
      FOREIGN KEY (idioma_extra_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.reserva_sala
  ADD CONSTRAINT FK_reserva_sala_9
      FOREIGN KEY (idioma_acesso_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.localidade_prova_alocacao
  ADD CONSTRAINT FK_localidade_prova_alocacao_2
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.localidade_prova_alocacao
  ADD CONSTRAINT FK_localidade_prova_alocacao_3
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.reserva_sala_aplicacao
  ADD CONSTRAINT FK_reserva_sala_aplicacao_1_1
      FOREIGN KEY (reserva_sala_id)
      REFERENCES public.reserva_sala (reserva_sala_id);

ALTER TABLE public.arquivo_mds
  ADD CONSTRAINT FK_importacao_arquivo_mds_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.arquivo_mds
  ADD CONSTRAINT FK_arquivo_mds_2
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.resultado_prova_manual
  ADD CONSTRAINT FK_resultado_prova_manual_1
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.resultado_prova_manual
  ADD CONSTRAINT FK_resultado_prova_manual_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.resultado_prova_manual
  ADD CONSTRAINT FK_resultado_prova_manual_3
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.cartao_resposta
  ADD CONSTRAINT FK_cartao_resposta_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.cartao_resposta
  ADD CONSTRAINT FK_cartao_resposta_2
      FOREIGN KEY (localidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.cartao_resposta
  ADD CONSTRAINT FK_cartao_resposta_3
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.cartao_resposta
  ADD CONSTRAINT FK_cartao_resposta_arquivo_anexo
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.cartao_resposta
  ADD CONSTRAINT FK_cartao_resposta_5
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.fechamento_aplicacao_concurso
  ADD CONSTRAINT FK_fechamento_aplicacao_concurso_1
      FOREIGN KEY (aplicacao_prova_id)
      REFERENCES public.aplicacao_prova (aplicacao_prova_id);

ALTER TABLE public.alocacao_inscricao
  ADD CONSTRAINT FK_alocacao_inscricao_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.alocacao_inscricao
  ADD CONSTRAINT FK_alocacao_inscricao_2
      FOREIGN KEY (reserva_sala_id)
      REFERENCES public.reserva_sala (reserva_sala_id);

ALTER TABLE public.diverg_fec_concurso
  ADD CONSTRAINT FK_diverg_fec_concurso_1
      FOREIGN KEY (fec_aplicacao_concurso_id)
      REFERENCES public.fechamento_aplicacao_concurso (fec_aplicacao_concurso_id);

ALTER TABLE public.diverg_fec_concurso
  ADD CONSTRAINT FK_diverg_fec_concurso_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.diverg_fec_concurso
  ADD CONSTRAINT FK_diverg_fec_concurso_4
      FOREIGN KEY (idioma_cartao_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.diverg_fec_concurso
  ADD CONSTRAINT FK_diverg_fec_concurso_3
      FOREIGN KEY (idioma_inscricao_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.fechamento_aplicacao_localidade
  ADD CONSTRAINT FK_fechamento_aplicacao_localidade_2
      FOREIGN KEY (localidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.fechamento_aplicacao_localidade
  ADD CONSTRAINT FK_fechamento_aplicacao_localidade_1
      FOREIGN KEY (aplicacao_prova_id)
      REFERENCES public.aplicacao_prova (aplicacao_prova_id);

ALTER TABLE public.diverg_fec_localidade
  ADD CONSTRAINT FK_diverg_fec_localidade_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.diverg_fec_localidade
  ADD CONSTRAINT FK_diverg_fec_localidade_2
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.diverg_fec_localidade
  ADD CONSTRAINT FK_diverg_fec_localidade_3
      FOREIGN KEY (fec_aplicacao_localidade_id)
      REFERENCES public.fechamento_aplicacao_localidade (fec_aplicacao_localidade_id);

ALTER TABLE public.lista_presenca
  ADD CONSTRAINT FK_lista_presenca_1
      FOREIGN KEY (aplicacao_prova_id)
      REFERENCES public.aplicacao_prova (aplicacao_prova_id);

ALTER TABLE public.lista_presenca
  ADD CONSTRAINT FK_lista_presenca_2
      FOREIGN KEY (localidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.gabarito_prova
  ADD CONSTRAINT FK_gabarito_prova_prova
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.resultado_fase
  ADD CONSTRAINT FK_TABLE_92_1
      FOREIGN KEY (fase_id)
      REFERENCES public.fase (fase_id);

ALTER TABLE public.presenca_inscricao
  ADD CONSTRAINT FK_presenca_inscricao_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.presenca_inscricao
  ADD CONSTRAINT FK_presenca_inscricao_3
      FOREIGN KEY (lista_presenca_id)
      REFERENCES public.lista_presenca (lista_presenca_id);

ALTER TABLE public.presenca_inscricao
  ADD CONSTRAINT FK_presenca_inscricao_4
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.resultado_vaga
  ADD CONSTRAINT FK_resultado_vaga_1
      FOREIGN KEY (resultado_fase_id)
      REFERENCES public.resultado_fase (resultado_fase_id);

ALTER TABLE public.resultado_vaga
  ADD CONSTRAINT FK_resultado_vaga_2
      FOREIGN KEY (vaga_id)
      REFERENCES public.vaga (vaga_id);

ALTER TABLE public.classificacao_inscricao
  ADD CONSTRAINT FK_classificacao_inscricao_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.classificacao_inscricao
  ADD CONSTRAINT FK_classificacao_inscricao_2
      FOREIGN KEY (resultado_vaga_id)
      REFERENCES public.resultado_vaga (resultado_vaga_id);

ALTER TABLE public.pontuacao_prova_objetiva
  ADD CONSTRAINT FK_pontuacao_prova_objetiva_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.pontuacao_prova_objetiva
  ADD CONSTRAINT FK_pontuacao_prova_objetiva_3
      FOREIGN KEY (classificacao_inscricao_id)
      REFERENCES public.classificacao_inscricao (classificacao_inscricao_id);

ALTER TABLE public.gabarito_chave
  ADD CONSTRAINT FK_gabarito_chave_1
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.gabarito_correlato
  ADD CONSTRAINT FK_gabarito_correlato_1
      FOREIGN KEY (gabarito_chave_id)
      REFERENCES public.gabarito_chave (gabarito_chave_id);

ALTER TABLE public.banca_examinadora
  ADD CONSTRAINT FK_banca_examinadora_1
      FOREIGN KEY (uf_endereco_id)
      REFERENCES public.uf (uf_id);

ALTER TABLE public.vinculo_banca_disciplina
  ADD CONSTRAINT FK_vinculo_banca_examinadora_disciplina_2
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.vinculo_banca_disciplina
  ADD CONSTRAINT FK_vinculo_banca_examinadora_disciplina_3
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.vinculo_banca_disciplina
  ADD CONSTRAINT FK_vinculo_banca_disciplina_3
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.questao_correlata
  ADD CONSTRAINT FK_questao_correlata_1
      FOREIGN KEY (gabarito_correlato_id)
      REFERENCES public.gabarito_correlato (gabarito_correlato_id);

ALTER TABLE public.banca_questoes
  ADD CONSTRAINT FK_questoes_banca_1
      FOREIGN KEY (banca_examinadora_id)
      REFERENCES public.banca_examinadora (banca_examinadora_id);

ALTER TABLE public.banca_questoes
  ADD CONSTRAINT FK_questoes_banca_2
      FOREIGN KEY (vinculo_banca_disciplina_id)
      REFERENCES public.vinculo_banca_disciplina (vinculo_banca_disciplina_id);

ALTER TABLE public.questao_banca
  ADD CONSTRAINT FK_questao_vinculo_banca_1
      FOREIGN KEY (banca_questoes_id)
      REFERENCES public.banca_questoes (banca_questoes_id);

ALTER TABLE public.area
  ADD CONSTRAINT FK_area_1
      FOREIGN KEY (assunto_id)
      REFERENCES public.assunto (assunto_id);

ALTER TABLE public.registro_importacao_cartao
  ADD CONSTRAINT FK_registro_importacao_cartao_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.parecer
  ADD CONSTRAINT FK_parecer_1
      FOREIGN KEY (questao_banca_id)
      REFERENCES public.questao_banca (questao_banca_id);

ALTER TABLE public.parecer
  ADD CONSTRAINT FK_parecer_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.cartao_importacao_processado
  ADD CONSTRAINT FK_cartao_importacao_processado_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.cartao_importacao_processado
  ADD CONSTRAINT FK_cartao_importacao_processado_2
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.cartao_importacao_processado
  ADD CONSTRAINT FK_cartao_importacao_processado_3
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.cartao_importacao_processado
  ADD CONSTRAINT FK_cartao_importacao_processado_4
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.cartao_importacao_processado
  ADD CONSTRAINT FK_cartao_importacao_processado_5
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.cartao_importacao_processado
  ADD CONSTRAINT FK_cartao_importacao_processado_6
      FOREIGN KEY (reg_importacao_cartao_id)
      REFERENCES public.registro_importacao_cartao (reg_importacao_cartao_id);

ALTER TABLE public.orgao_concurso
  ADD CONSTRAINT FK_orgao_concurso_3
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.orgao_concurso
  ADD CONSTRAINT FK_orgao_concurso_2
      FOREIGN KEY (orgao_contratante_id)
      REFERENCES public.orgao_contratante (orgao_contratante_id);

ALTER TABLE public.disciplina_prova_objetiva
  ADD CONSTRAINT FK_prova_disciplina_2
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.disciplina_prova_objetiva
  ADD CONSTRAINT FK_disciplina_prova_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.idioma_oferta_cargo_concurso
  ADD CONSTRAINT FK_idioma_campo_concurso_1_2
      FOREIGN KEY (oferta_cargo_concurso_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.idioma_oferta_cargo_concurso
  ADD CONSTRAINT FK_idioma_campo_concurso_1_1
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.subprova_prova_objetiva
  ADD CONSTRAINT FK_subprova_conteudo_prova_1
      FOREIGN KEY (subprova_id)
      REFERENCES public.subprova (subprova_id);

ALTER TABLE public.subprova_prova_objetiva
  ADD CONSTRAINT FK_subprova_conteudo_prova_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.disciplina_subprova
  ADD CONSTRAINT FK_disciplina_subprova_1
      FOREIGN KEY (subprova_id)
      REFERENCES public.subprova (subprova_id);

ALTER TABLE public.disciplina_subprova
  ADD CONSTRAINT FK_disciplina_subprova_2
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.ofertas_cargos_prorrogacao_concurso
  ADD CONSTRAINT FK_TABLE_35_11
      FOREIGN KEY (prorrogacao_prazos_concurso_id)
      REFERENCES public.prorrogacao_prazos_concurso (prorrogacao_prazos_concurso_id);

ALTER TABLE public.ofertas_cargos_prorrogacao_concurso
  ADD CONSTRAINT FK_TABLE_35_21
      FOREIGN KEY (oferta_cargo_concurso_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.uf_estrutura_cidade
  ADD CONSTRAINT FK_TABLE_35_1
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.uf_estrutura_cidade
  ADD CONSTRAINT FK_TABLE_35_2
      FOREIGN KEY (uf_estrutura_id)
      REFERENCES public.uf_estrutura (uf_estrutura_id);

ALTER TABLE public.campo_formulario_inscricao
  ADD CONSTRAINT FK_campo_formulario_inscricao_1
      FOREIGN KEY (formulario_inscricao_id)
      REFERENCES public.formulario_inscricao (formulario_inscricao_id);

ALTER TABLE public.isencao
  ADD CONSTRAINT FK_isencao_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.inscricao_tratamento_diferenciado
  ADD CONSTRAINT FK_inscricao_tratamento_diferenciado_1
      FOREIGN KEY (tratamento_diferenciado_id)
      REFERENCES public.tratamento_diferenciado (tratamento_diferenciado_id);

ALTER TABLE public.inscricao_tratamento_diferenciado
  ADD CONSTRAINT FK_inscricao_tratamento_diferenciado_3
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.inscricao_tratamento_diferenciado
  ADD CONSTRAINT FK_inscricao_tratamento_diferenciado_4
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.inscricao_historico_localidade
  ADD CONSTRAINT FK_inscricao_historico_localidade_1_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.inscricao_historico_localidade
  ADD CONSTRAINT FK_inscricao_historico_localidade_1_2
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.anexo_local_prova
  ADD CONSTRAINT FK_anexo_local_prova_arquivo_anexo
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.anexo_local_prova
  ADD CONSTRAINT FK_anexo_local_prova_local_prova
      FOREIGN KEY (local_prova_id)
      REFERENCES public.local_prova (local_prova_id);

ALTER TABLE public.criterio_desempate_maior_nota_disc
  ADD CONSTRAINT FK_criterio_desempate_soma_nota_disc_2
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.criterio_desempate_maior_nota_disc
  ADD CONSTRAINT FK_criterio_desempate_soma_nota_disc_3
      FOREIGN KEY (criterio_desempate_id)
      REFERENCES public.criterio_desempate (criterio_desempate_id);

ALTER TABLE public.criterio_desempate_maior_nota_provas
  ADD CONSTRAINT FK_criterio_desempate_soma_nota_provas_1
      FOREIGN KEY (criterio_desempate_id)
      REFERENCES public.criterio_desempate (criterio_desempate_id);

ALTER TABLE public.criterio_desempate_maior_nota_provas
  ADD CONSTRAINT FK_criterio_desempate_soma_nota_provas_2
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.vinculo_fase_prova
  ADD CONSTRAINT FK_vinculo_fase_prova_1
      FOREIGN KEY (vinculo_fase_id)
      REFERENCES public.vinculo_fase (vinculo_fase_id);

ALTER TABLE public.vinculo_fase_prova
  ADD CONSTRAINT FK_vinculo_fase_prova_2
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.erro_arquivo_pagamento
  ADD CONSTRAINT FK_erro_arquivo_pagamento_1
      FOREIGN KEY (arquivo_pagamento_id)
      REFERENCES public.arquivo_pagamento (arquivo_pagamento_id);

ALTER TABLE public.reserva_lugares_sala
  ADD CONSTRAINT FK_reserva_lugares_sala_5
      FOREIGN KEY (reserva_sala_aplic_id)
      REFERENCES public.reserva_sala_aplicacao (reserva_sala_aplic_id);

ALTER TABLE public.reserva_lugares_sala
  ADD CONSTRAINT FK_reserva_lugares_sala_3
      FOREIGN KEY (oferta_cargo_concurso_id)
      REFERENCES public.oferta_cargo_concurso (oferta_cargo_concurso_id);

ALTER TABLE public.reserva_lugares_sala
  ADD CONSTRAINT FK_reserva_lugares_sala_4
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.historico_status_alocacao
  ADD CONSTRAINT FK_historico_status_alocacao_1
      FOREIGN KEY (localidade_prova_alocacao_id)
      REFERENCES public.localidade_prova_alocacao (localidade_prova_alocacao_id);

ALTER TABLE public.historico_status_alocacao
  ADD CONSTRAINT FK_historico_status_alocacao_2
      FOREIGN KEY (usuario_responsavel_id)
      REFERENCES public.usuario (usuario_id);

ALTER TABLE public.vistoria_local_prova_item
  ADD CONSTRAINT FK_item_vistoria_local_prova_1
      FOREIGN KEY (vistoria_local_prova_id)
      REFERENCES public.vistoria_local_prova (vistoria_local_prova_id);

ALTER TABLE public.criterio_desempate_maior_nota_subprovas
  ADD CONSTRAINT FK_criterio_desempate_maior_nota_subprovas_1
      FOREIGN KEY (criterio_desempate_id)
      REFERENCES public.criterio_desempate (criterio_desempate_id);

ALTER TABLE public.criterio_desempate_maior_nota_subprovas
  ADD CONSTRAINT FK_criterio_desempate_maior_nota_subprovas_2
      FOREIGN KEY (subprova_id)
      REFERENCES public.subprova (subprova_id);

ALTER TABLE public.arquivo_mds_inscricao
  ADD CONSTRAINT FK_importacao_arquivo_mds_registro_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.arquivo_mds_inscricao
  ADD CONSTRAINT FK_importacao_arquivo_mds_registro_3
      FOREIGN KEY (arquivo_mds_id)
      REFERENCES public.arquivo_mds (arquivo_mds_id);

ALTER TABLE public.gabarito_prova_inscricao
  ADD CONSTRAINT FK_gabarito_prova_inscricao_prova
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.gabarito_prova_inscricao
  ADD CONSTRAINT FK_gabarito_prova_inscricao_inscricao
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.gabarito_prova_inscricao
  ADD CONSTRAINT FK_gabarito_prova_inscricao_alocacao_inscricao
      FOREIGN KEY (alocacao_inscricao_id)
      REFERENCES public.alocacao_inscricao (alocacao_inscricao_id)
   ON DELETE CASCADE;

ALTER TABLE public.inscricoes_arquivo_pagamento
  ADD CONSTRAINT FK_inscricoes_arquivo_pagamento_1
      FOREIGN KEY (arquivo_pagamento_id)
      REFERENCES public.arquivo_pagamento (arquivo_pagamento_id);

ALTER TABLE public.inscricoes_arquivo_pagamento
  ADD CONSTRAINT FK_inscricoes_arquivo_pagamento_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.nota_titulo
  ADD CONSTRAINT FK_resultado_prova_titulos_3
      FOREIGN KEY (titulo_prova_titulos_id)
      REFERENCES public.titulo_prova_titulos (titulo_prova_titulos_id);

ALTER TABLE public.nota_titulo
  ADD CONSTRAINT FK_nota_titulos_3
      FOREIGN KEY (resultado_prova_manual_id)
      REFERENCES public.resultado_prova_manual (resultado_prova_manual_id);

ALTER TABLE public.nota_questao
  ADD CONSTRAINT FK_resultado_prova_questoes_3
      FOREIGN KEY (questao_prova_subjetiva_id)
      REFERENCES public.questao_prova_subjetiva (questao_prova_subjetiva_id);

ALTER TABLE public.nota_questao
  ADD CONSTRAINT FK_nota_questoes_2
      FOREIGN KEY (resultado_prova_manual_id)
      REFERENCES public.resultado_prova_manual (resultado_prova_manual_id);

ALTER TABLE public.nota_habilitacao
  ADD CONSTRAINT FK_resultado_prova_habilitacao_1
      FOREIGN KEY (resultado_prova_manual_id)
      REFERENCES public.resultado_prova_manual (resultado_prova_manual_id);

ALTER TABLE public.divergencia_cartao_repetido
  ADD CONSTRAINT FK_divergencia_cartao_repetido_1
      FOREIGN KEY (cartao_resposta_id)
      REFERENCES public.cartao_resposta (cartao_resposta_id);

ALTER TABLE public.divergencia_cartao_repetido
  ADD CONSTRAINT FK_divergencia_cartao_repetido_2
      FOREIGN KEY (diverg_fec_concurso_id)
      REFERENCES public.diverg_fec_concurso (diverg_fec_concurso_id);

ALTER TABLE public.divergencia_resultado_repetido
  ADD CONSTRAINT FK_divergencia_resultado_repetido_1
      FOREIGN KEY (diverg_fec_concurso_id)
      REFERENCES public.diverg_fec_concurso (diverg_fec_concurso_id);

ALTER TABLE public.divergencia_resultado_repetido
  ADD CONSTRAINT FK_divergencia_resultado_repetido_2
      FOREIGN KEY (resultado_prova_manual_id)
      REFERENCES public.resultado_prova_manual (resultado_prova_manual_id);

ALTER TABLE public.questao_gabarito
  ADD CONSTRAINT FK_questao_gabarito_gabarito
      FOREIGN KEY (gabarito_prova_id)
      REFERENCES public.gabarito_prova (gabarito_prova_id);

ALTER TABLE public.questao_gabarito
  ADD CONSTRAINT FK_questao_gabarito_2
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.ordenacao_disciplina_gabarito
  ADD CONSTRAINT FK_ordenacao_disciplina_gabarito_gabarito
      FOREIGN KEY (gabarito_prova_id)
      REFERENCES public.gabarito_prova (gabarito_prova_id);

ALTER TABLE public.ordenacao_disciplina_gabarito
  ADD CONSTRAINT FK_ordenacao_disciplina_gabarito_disciplina
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.ocorrencia
  ADD CONSTRAINT FK_ocorrencia_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.historico_presenca_inscricao
  ADD CONSTRAINT FK_historico_presenca_inscricao_1
      FOREIGN KEY (presenca_inscricao_id)
      REFERENCES public.presenca_inscricao (presenca_inscricao_id);

ALTER TABLE public.idioma_concurso
  ADD CONSTRAINT FK_idioma_concurso_1
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.idioma_concurso
  ADD CONSTRAINT FK_idioma_concurso_2
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.permissao_usuario_concurso
  ADD CONSTRAINT FK_permissao_usuario_concurso_1
      FOREIGN KEY (usuario_id)
      REFERENCES public.usuario (usuario_id);

ALTER TABLE public.permissao_usuario_concurso
  ADD CONSTRAINT FK_permissao_usuario_concurso_2
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.pontuacao_subprova
  ADD CONSTRAINT FK_pontuacao_subprova_1
      FOREIGN KEY (subprova_id)
      REFERENCES public.subprova (subprova_id);

ALTER TABLE public.pontuacao_subprova
  ADD CONSTRAINT FK_pontuacao_subprova_2
      FOREIGN KEY (pontuacao_prova_objetiva_id)
      REFERENCES public.pontuacao_prova_objetiva (pontuacao_prova_objetiva_id);

ALTER TABLE public.pontuacao_disciplina
  ADD CONSTRAINT FK_pontuacao_disciplina_1
      FOREIGN KEY (pontuacao_prova_objetiva_id)
      REFERENCES public.pontuacao_prova_objetiva (pontuacao_prova_objetiva_id);

ALTER TABLE public.pontuacao_disciplina
  ADD CONSTRAINT FK_pontuacao_disciplina_2
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.pontuacao_prova_questoes
  ADD CONSTRAINT FK_pontuacao_prova_questoes_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.pontuacao_prova_questoes
  ADD CONSTRAINT FK_pontuacao_prova_questoes_3
      FOREIGN KEY (classificacao_inscricao_id)
      REFERENCES public.classificacao_inscricao (classificacao_inscricao_id);

ALTER TABLE public.pontuacao_prova_titulos
  ADD CONSTRAINT FK_pontuacao_prova_titulos_1
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.pontuacao_prova_titulos
  ADD CONSTRAINT FK_pontuacao_prova_titulos_2
      FOREIGN KEY (classificacao_inscricao_id)
      REFERENCES public.classificacao_inscricao (classificacao_inscricao_id);

ALTER TABLE public.pontuacao_prova_habilitacao
  ADD CONSTRAINT FK_pontuacao_prova_habilitacao_1
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.pontuacao_prova_habilitacao
  ADD CONSTRAINT FK_pontuacao_prova_habilitacao_2
      FOREIGN KEY (classificacao_inscricao_id)
      REFERENCES public.classificacao_inscricao (classificacao_inscricao_id);

ALTER TABLE public.idiomas_gabarito_prova
  ADD CONSTRAINT FK_idiomas_gabarito_prova_1
      FOREIGN KEY (gabarito_prova_id)
      REFERENCES public.gabarito_prova (gabarito_prova_id);

ALTER TABLE public.idiomas_gabarito_prova
  ADD CONSTRAINT FK_idiomas_gabarito_prova_2
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.questao_cartao_resposta
  ADD CONSTRAINT FK_questao_cartao_resposta_cartao_resposta
      FOREIGN KEY (cartao_resposta_id)
      REFERENCES public.cartao_resposta (cartao_resposta_id);

ALTER TABLE public.historico_motivo_bloqueio
  ADD CONSTRAINT FK_historico_motivo_bloqueio_1
      FOREIGN KEY (banca_examinadora_id)
      REFERENCES public.banca_examinadora (banca_examinadora_id);

ALTER TABLE public.arquivo_banca
  ADD CONSTRAINT FK_arquivo_vinculo_banca_banca
      FOREIGN KEY (banca_questoes_id)
      REFERENCES public.banca_questoes (banca_questoes_id);

ALTER TABLE public.arquivo_banca
  ADD CONSTRAINT FK_arquivo_banca_arquivo_anexo
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.recurso
  ADD CONSTRAINT FK_recurso_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.recurso
  ADD CONSTRAINT FK_recurso_2
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.recurso
  ADD CONSTRAINT FK_recurso_3
      FOREIGN KEY (disciplina_id)
      REFERENCES public.disciplina (disciplina_id);

ALTER TABLE public.recurso
  ADD CONSTRAINT FK_recurso_4
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.area_banca_examinadora
  ADD CONSTRAINT FK_area_banca_examinadora_1
      FOREIGN KEY (banca_examinadora_id)
      REFERENCES public.banca_examinadora (banca_examinadora_id);

ALTER TABLE public.area_banca_examinadora
  ADD CONSTRAINT FK_area_banca_examinadora_2
      FOREIGN KEY (area_id)
      REFERENCES public.area (area_id);

ALTER TABLE public.orientacao_recurso
  ADD CONSTRAINT FK_orientacao_recurso_1
      FOREIGN KEY (fase_id)
      REFERENCES public.fase (fase_id);

ALTER TABLE public.visao_candidato
  ADD CONSTRAINT FK_TABLE_119_1
      FOREIGN KEY (prova_id)
      REFERENCES public.prova (prova_id);

ALTER TABLE public.visao_candidato
  ADD CONSTRAINT FK_TABLE_119_2
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.visao_candidato
  ADD CONSTRAINT FK_TABLE_119_3
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.localidade_prova_inscricao
  ADD CONSTRAINT FK_localidade_prova_inscricao_1
      FOREIGN KEY (etapa_id)
      REFERENCES public.etapa (etapa_id);

ALTER TABLE public.localidade_prova_inscricao
  ADD CONSTRAINT FK_localidade_prova_inscricao_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.localidade_prova_inscricao
  ADD CONSTRAINT FK_localidade_prova_inscricao_3
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.historico_questao_banca
  ADD CONSTRAINT FK_historico_questao_banca_1
      FOREIGN KEY (questao_banca_id)
      REFERENCES public.questao_banca (questao_banca_id);

ALTER TABLE public.historico_questao_banca
  ADD CONSTRAINT FK_historico_questao_banca_2
      FOREIGN KEY (banca_examinadora_id)
      REFERENCES public.banca_examinadora (banca_examinadora_id);

ALTER TABLE public.qtd_min_provas_corrigidas
  ADD CONSTRAINT FK_qtd_min_provas_corrigidas_1
      FOREIGN KEY (vinculo_fase_id)
      REFERENCES public.vinculo_fase (vinculo_fase_id);

ALTER TABLE public.qtd_min_provas_corrigidas
  ADD CONSTRAINT FK_qtd_min_provas_corrigidas_2
      FOREIGN KEY (vaga_id)
      REFERENCES public.vaga (vaga_id);

ALTER TABLE public.inscricao_historico_status
  ADD CONSTRAINT FK_inscricao_historico_status_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.anexo_vistoria
  ADD CONSTRAINT FK_anexo_vistoria_1
      FOREIGN KEY (vistoria_local_prova_id)
      REFERENCES public.vistoria_local_prova (vistoria_local_prova_id);

ALTER TABLE public.anexo_vistoria
  ADD CONSTRAINT FK_anexo_vistoria_2
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.parecer_historico_tramite
  ADD CONSTRAINT FK_TABLE_125_1
      FOREIGN KEY (parecer_id)
      REFERENCES public.parecer (parecer_id);

ALTER TABLE public.alternativa_questao_correlata
  ADD CONSTRAINT FK_alternativa_questao_correlata_1
      FOREIGN KEY (questao_correlata_id)
      REFERENCES public.questao_correlata (questao_correlata_id);

ALTER TABLE public.alternativa_questao_correlata
  ADD CONSTRAINT FK_alternativa_questao_correlata_2
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.diverg_fec_localidade_inscricao
  ADD CONSTRAINT FK_diverg_fec_localidade_inscricao_1
      FOREIGN KEY (diverg_fec_localidade_id)
      REFERENCES public.diverg_fec_localidade (diverg_fec_localidade_id);

ALTER TABLE public.diverg_fec_localidade_inscricao
  ADD CONSTRAINT FK_diverg_fec_localidade_inscricao_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.diverg_fec_concurso_inscricao
  ADD CONSTRAINT FK_TABLE_128_1
      FOREIGN KEY (diverg_fec_concurso_id)
      REFERENCES public.diverg_fec_concurso (diverg_fec_concurso_id);

ALTER TABLE public.diverg_fec_concurso_inscricao
  ADD CONSTRAINT FK_diverg_fec_concurso_inscricao_2
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.imagem_parecer
  ADD CONSTRAINT FK_imagens_parecer_1
      FOREIGN KEY (parecer_id)
      REFERENCES public.parecer (parecer_id);

ALTER TABLE public.imagem_parecer
  ADD CONSTRAINT FK_imagens_parecer_2
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.imagem_folha
  ADD CONSTRAINT FK_imagem_lista_presenca_1
      FOREIGN KEY (lista_presenca_id)
      REFERENCES public.lista_presenca (lista_presenca_id);

ALTER TABLE public.imagem_folha
  ADD CONSTRAINT FK_imagem_lista_presenca_2
      FOREIGN KEY (arquivo_anexo_id)
      REFERENCES public.arquivo_anexo (arquivo_anexo_id);

ALTER TABLE public.cartao_incluido
  ADD CONSTRAINT FK_cartao_incluido_1
      FOREIGN KEY (inscricao_id)
      REFERENCES public.inscricao (inscricao_id);

ALTER TABLE public.cartao_incluido
  ADD CONSTRAINT FK_cartao_incluido_3
      FOREIGN KEY (idioma_id)
      REFERENCES public.idioma (idioma_id);

ALTER TABLE public.cartao_incluido
  ADD CONSTRAINT FK_cartao_incluido_4
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE public.cartao_incluido
  ADD CONSTRAINT FK_cartao_incluido_5
      FOREIGN KEY (conteudo_prova_id)
      REFERENCES public.conteudo_prova (conteudo_prova_id);

ALTER TABLE public.erro_arquivo_mds
  ADD CONSTRAINT FK_erro_arquivo_mds_1
      FOREIGN KEY (arquivo_mds_id)
      REFERENCES public.arquivo_mds (arquivo_mds_id);

ALTER TABLE public.erro_importacao_cartao
  ADD CONSTRAINT FK_erro_importacao_cartao_1
      FOREIGN KEY (cartao_imp_processado_id)
      REFERENCES public.cartao_importacao_processado (cartao_imp_processado_id);

ALTER TABLE public.questao_cartao_processado
  ADD CONSTRAINT FK_questao_cartao_processado_1
      FOREIGN KEY (cartao_imp_processado_id)
      REFERENCES public.cartao_importacao_processado (cartao_imp_processado_id);

ALTER TABLE public.cidades_concurso
  ADD CONSTRAINT FK_cidades_concurso_2
      FOREIGN KEY (concurso_id)
      REFERENCES public.concurso (concurso_id);

ALTER TABLE public.cidades_concurso
  ADD CONSTRAINT FK_cidades_concurso_3
      FOREIGN KEY (cidade_id)
      REFERENCES public.cidade (cidade_id);

ALTER TABLE presenca_inscricao ALTER imagem_lista_presenca TYPE oid;
CREATE SEQUENCE impressao_lista_pres_remote_cmp_seq;


insert into uf (sigla, nome, version) values ('RS', 'RIO GRANDE DO SUL', 0);
insert into uf (sigla, nome, version) values ('DF', 'DISTRITO FEDERAL', 0);
insert into uf (sigla, nome, version) values ('GO', 'GOIAS', 0);
insert into uf (sigla, nome, version) values ('MT', 'MATO GROSSO', 0);
insert into uf (sigla, nome, version) values ('MS', 'MATO GROSSO DO SUL', 0);
insert into uf (sigla, nome, version) values ('TO', 'TOCANTINS', 0);
insert into uf (sigla, nome, version) values ('PA', 'PARA', 0);
insert into uf (sigla, nome, version) values ('AM', 'AMAZONAS', 0);
insert into uf (sigla, nome, version) values ('AC', 'ACRE', 0);
insert into uf (sigla, nome, version) values ('AP', 'AMAPA', 0);
insert into uf (sigla, nome, version) values ('RO', 'RONDONIA', 0);
insert into uf (sigla, nome, version) values ('RR', 'RORAIMA', 0);
insert into uf (sigla, nome, version) values ('CE', 'CEARA', 0);
insert into uf (sigla, nome, version) values ('MA', 'MARANHAO', 0);
insert into uf (sigla, nome, version) values ('PI', 'PIAUI', 0);
insert into uf (sigla, nome, version) values ('PE', 'PERNAMBUCO', 0);
insert into uf (sigla, nome, version) values ('RN', 'RIO GRANDE DO NORTE', 0);
insert into uf (sigla, nome, version) values ('PB', 'PARAIBA', 0);
insert into uf (sigla, nome, version) values ('AL', 'ALAGOAS', 0);
insert into uf (sigla, nome, version) values ('BA', 'BAHIA', 0);
insert into uf (sigla, nome, version) values ('SE', 'SERGIPE', 0);
insert into uf (sigla, nome, version) values ('MG', 'MINAS GERAIS', 0);
insert into uf (sigla, nome, version) values ('RJ', 'RIO DE JANEIRO', 0);
insert into uf (sigla, nome, version) values ('ES', 'ESPIRITO SANTO', 0);
insert into uf (sigla, nome, version) values ('SP', 'SAO PAULO', 0);
insert into uf (sigla, nome, version) values ('PR', 'PARANA', 0);
insert into uf (sigla, nome, version) values ('SC', 'SANTA CATARINA', 0);
