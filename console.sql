USE SARESP;

-- CRIANDO TABELA STAGING
CREATE TABLE PROVAO_STAGING (
    ID INT AUTO_INCREMENT PRIMARY KEY
) AS SELECT * FROM `Microdados de Alunos - Ensino Medio PROVAO - 2025`;

-- LIMPANDO COLUNAS DESNECESSÁRIAS
ALTER TABLE PROVAO_STAGING DROP COLUMN DEPADM;
ALTER TABLE PROVAO_STAGING DROP COLUMN NOMEDEP;
ALTER TABLE PROVAO_STAGING DROP COLUMN DepBoL;
ALTER TABLE PROVAO_STAGING DROP COLUMN CodRMet;
ALTER TABLE PROVAO_STAGING DROP COLUMN CDREDE;
ALTER TABLE PROVAO_STAGING DROP COLUMN CODMUN;
ALTER TABLE PROVAO_STAGING DROP COLUMN CODESC;
ALTER TABLE PROVAO_STAGING DROP COLUMN seqDE;
ALTER TABLE PROVAO_STAGING DROP COLUMN CODPER;
ALTER TABLE PROVAO_STAGING DROP COLUMN status_nota;

-- RENOMEANDO COLUNAS

ALTER TABLE PROVAO_STAGING CHANGE NomeDepBol DEPARTAMENTO text;
ALTER TABLE PROVAO_STAGING CHANGE NOMESC ESCOLA text;
ALTER TABLE PROVAO_STAGING CHANGE SERIE_ANO SERIE text;
ALTER TABLE PROVAO_STAGING CHANGE RegiaoMetropolitana REGIAO text;
ALTER TABLE PROVAO_STAGING CHANGE CD_ALUNO_ANONIMIZADO ALUNO text;
ALTER TABLE PROVAO_STAGING CHANGE Tem_Nec NEC_ESPECIAL text;
ALTER TABLE PROVAO_STAGING CHANGE particip PRESENCA text;
ALTER TABLE PROVAO_STAGING CHANGE cad_prova_lg_cn CADERNO_LGCN text;
ALTER TABLE PROVAO_STAGING CHANGE cad_prova_mat_ch CADERNO_MATCH text;
ALTER TABLE PROVAO_STAGING CHANGE particip_lg_cn PRESENCA_LGCN text;
ALTER TABLE PROVAO_STAGING CHANGE particip_mat_ch PRESENCA_MATCH text;
ALTER TABLE PROVAO_STAGING CHANGE Tip_PROVA TIPO_PROVA text;
ALTER TABLE PROVAO_STAGING CHANGE DE DIRETORIA text;
ALTER TABLE PROVAO_STAGING CHANGE MUN MUNICIPIO text;


-- ATUALIZANDO CODIGO DE DEFICIENCIA DO INEP
UPDATE PROVAO_STAGING inner join DEFICIENCIA_ANTIGA on DEF1 = DEF_OLD SET DEF1 = DEF_NEW WHERE DEF1>200;
UPDATE PROVAO_STAGING inner join DEFICIENCIA_ANTIGA on DEF2 = DEF_OLD SET DEF2 = DEF_NEW WHERE DEF2>200;
UPDATE PROVAO_STAGING inner join DEFICIENCIA_ANTIGA on DEF3 = DEF_OLD SET DEF3 = DEF_NEW WHERE DEF3>200;
UPDATE PROVAO_STAGING inner join DEFICIENCIA_ANTIGA on DEF4 = DEF_OLD SET DEF4 = DEF_NEW WHERE DEF4>200;
UPDATE PROVAO_STAGING inner join DEFICIENCIA_ANTIGA on DEF5 = DEF_OLD SET DEF5 = DEF_NEW WHERE DEF5>200;

-- TRATANDO FALSOS NULOS
UPDATE PROVAO_STAGING SET
     -- ACERTOS
    acertos_lp  = CASE WHEN LOWER(TRIM(acertos_lp))  = 'null' THEN NULL ELSE acertos_lp END,
    acertos_li  = CASE WHEN LOWER(TRIM(acertos_li))  = 'null' THEN NULL ELSE acertos_li END,
    acertos_bio = CASE WHEN LOWER(TRIM(acertos_bio)) = 'null' THEN NULL ELSE acertos_bio END,
    acertos_fis = CASE WHEN LOWER(TRIM(acertos_fis)) = 'null' THEN NULL ELSE acertos_fis END,
    acertos_qui = CASE WHEN LOWER(TRIM(acertos_qui)) = 'null' THEN NULL ELSE acertos_qui END,
    acertos_mat = CASE WHEN LOWER(TRIM(acertos_mat)) = 'null' THEN NULL ELSE acertos_mat END,
    acertos_geo = CASE WHEN LOWER(TRIM(acertos_geo)) = 'null' THEN NULL ELSE acertos_geo END,
    acertos_his = CASE WHEN LOWER(TRIM(acertos_his)) = 'null' THEN NULL ELSE acertos_his END,
    acertos_fil = CASE WHEN LOWER(TRIM(acertos_fil)) = 'null' THEN NULL ELSE acertos_fil END,
    acertos_soc = CASE WHEN LOWER(TRIM(acertos_soc)) = 'null' THEN NULL ELSE acertos_soc END,

    -- PORCENTAGEM
    porc_lp  = CASE WHEN LOWER(TRIM(porc_lp))  = 'null' THEN NULL ELSE porc_lp END,
    porc_li  = CASE WHEN LOWER(TRIM(porc_li))  = 'null' THEN NULL ELSE porc_li END,
    porc_bio = CASE WHEN LOWER(TRIM(porc_bio)) = 'null' THEN NULL ELSE porc_bio END,
    porc_fis = CASE WHEN LOWER(TRIM(porc_fis)) = 'null' THEN NULL ELSE porc_fis END,
    porc_qui = CASE WHEN LOWER(TRIM(porc_qui)) = 'null' THEN NULL ELSE porc_qui END,
    porc_mat = CASE WHEN LOWER(TRIM(porc_mat)) = 'null' THEN NULL ELSE porc_mat END,
    porc_geo = CASE WHEN LOWER(TRIM(porc_geo)) = 'null' THEN NULL ELSE porc_geo END,
    porc_his = CASE WHEN LOWER(TRIM(porc_his)) = 'null' THEN NULL ELSE porc_his END,
    porc_fil = CASE WHEN LOWER(TRIM(porc_fil)) = 'null' THEN NULL ELSE porc_fil END,
    porc_soc = CASE WHEN LOWER(TRIM(porc_soc)) = 'null' THEN NULL ELSE porc_soc END,

    -- NOTAS
    nota_lp_original  = CASE WHEN LOWER(TRIM(nota_lp_original))  = 'null' THEN NULL ELSE nota_lp_original END,
    nota_lp           = CASE WHEN LOWER(TRIM(nota_lp))           = 'null' THEN NULL ELSE nota_lp END,
    nota_li           = CASE WHEN LOWER(TRIM(nota_li))           = 'null' THEN NULL ELSE nota_li END,
    nota_bio          = CASE WHEN LOWER(TRIM(nota_bio))          = 'null' THEN NULL ELSE nota_bio END,
    nota_fis          = CASE WHEN LOWER(TRIM(nota_fis))          = 'null' THEN NULL ELSE nota_fis END,
    nota_qui          = CASE WHEN LOWER(TRIM(nota_qui))          = 'null' THEN NULL ELSE nota_qui END,
    nota_mat_original = CASE WHEN LOWER(TRIM(nota_mat_original)) = 'null' THEN NULL ELSE nota_mat_original END,
    nota_mat          = CASE WHEN LOWER(TRIM(nota_mat))          = 'null' THEN NULL ELSE nota_mat END,
    nota_geo          = CASE WHEN LOWER(TRIM(nota_geo))          = 'null' THEN NULL ELSE nota_geo END,
    nota_his          = CASE WHEN LOWER(TRIM(nota_his))          = 'null' THEN NULL ELSE nota_his END,
    nota_fil          = CASE WHEN LOWER(TRIM(nota_fil))          = 'null' THEN NULL ELSE nota_fil END,
    nota_soc          = CASE WHEN LOWER(TRIM(nota_soc))          = 'null' THEN NULL ELSE nota_soc END,
    redacao           = CASE WHEN LOWER(TRIM(redacao))           = 'null' THEN NULL ELSE redacao END,

    DEF1           = CASE WHEN LOWER(TRIM(DEF1))           = 'null' THEN NULL ELSE DEF1 END,
    DEF2           = CASE WHEN LOWER(TRIM(DEF2))           = 'null' THEN NULL ELSE DEF2 END,
    DEF3           = CASE WHEN LOWER(TRIM(DEF3))           = 'null' THEN NULL ELSE DEF3 END,
    DEF4           = CASE WHEN LOWER(TRIM(DEF4))           = 'null' THEN NULL ELSE DEF4 END,
    DEF5           = CASE WHEN LOWER(TRIM(DEF5))           = 'null' THEN NULL ELSE DEF5 END;


-- MUDANDO O CODIGO DE DEFICIENCIA PARA O NOME DA DEFICIENCIA
UPDATE PROVAO_STAGING INNER JOIN DEFICIENCIA ON DEF1 = DEF_ID SET DEF1 = DEF_NAME WHERE DEF1 IS NOT NULL;
UPDATE PROVAO_STAGING INNER JOIN DEFICIENCIA ON DEF2 = DEF_ID SET DEF2 = DEF_NAME WHERE DEF1 IS NOT NULL;
UPDATE PROVAO_STAGING INNER JOIN DEFICIENCIA ON DEF3 = DEF_ID SET DEF3 = DEF_NAME WHERE DEF1 IS NOT NULL;
UPDATE PROVAO_STAGING INNER JOIN DEFICIENCIA ON DEF4 = DEF_ID SET DEF4 = DEF_NAME WHERE DEF1 IS NOT NULL;
UPDATE PROVAO_STAGING INNER JOIN DEFICIENCIA ON DEF5 = DEF_ID SET DEF5 = DEF_NAME WHERE DEF1 IS NOT NULL;


-- SIMPLIFICANDO MODELO DE SERIE
UPDATE PROVAO_STAGING SET SERIE = 1 WHERE SERIE='EM-1ª série';
UPDATE PROVAO_STAGING SET SERIE = 2 WHERE SERIE='EM-2ª série';
UPDATE PROVAO_STAGING SET SERIE = 3 WHERE SERIE='EM-3ª série';




-- REMOVENDO DUPLICATAS(PRIORIZANDO MENOR QUANTIDADE DE NULOS)
WITH CTE_DUPLICATES AS (
    SELECT ID,
           ROW_NUMBER() OVER (
               PARTITION BY ALUNO
               ORDER BY (
                   (nota_lp IS NOT NULL) +
                   (nota_mat IS NOT NULL) +
                   (nota_li IS NOT NULL) +
                   (nota_bio IS NOT NULL) +
                   (nota_fis IS NOT NULL) +
                   (nota_qui IS NOT NULL) +
                   (nota_geo IS NOT NULL) +
                   (nota_his IS NOT NULL) +
                   (nota_fil IS NOT NULL) +
                   (nota_soc IS NOT NULL) +
                   (redacao IS NOT NULL) +

                   (acertos_lp IS NOT NULL) +
                   (acertos_mat IS NOT NULL) +
                   (acertos_li IS NOT NULL) +
                   (acertos_bio IS NOT NULL) +
                   (acertos_fis IS NOT NULL) +
                   (acertos_qui IS NOT NULL) +
                   (acertos_geo IS NOT NULL) +
                   (acertos_his IS NOT NULL) +
                   (acertos_fil IS NOT NULL) +
                   (acertos_soc IS NOT NULL) +


                   (porc_lp IS NOT NULL) +
                   (porc_mat IS NOT NULL) +
                   (porc_li IS NOT NULL) +
                   (porc_bio IS NOT NULL) +
                   (porc_fis IS NOT NULL) +
                   (porc_qui IS NOT NULL) +
                   (porc_geo IS NOT NULL) +
                   (porc_his IS NOT NULL) +
                   (porc_fil IS NOT NULL) +
                   (porc_soc IS NOT NULL)
               ) DESC,
               ID DESC
           ) as num_linha
    FROM PROVAO_STAGING
)
DELETE p
FROM PROVAO_STAGING p
INNER JOIN CTE_DUPLICATES c ON p.ID = c.ID
WHERE c.num_linha > 1;




-- PREENCHENDO DADOS FALTANTES

UPDATE PROVAO_STAGING
SET
    -- 1. LÍNGUA PORTUGUESA (20 questões)
    porc_lp = CASE
        WHEN porc_lp IS NULL AND TRIM(acertos_lp) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_lp) AS UNSIGNED) / 20) * 100, 2), '.', ',')
        ELSE porc_lp END,

    -- 2. MATEMÁTICA (20 questões)
    porc_mat = CASE
        WHEN porc_mat IS NULL AND TRIM(acertos_mat) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_mat) AS UNSIGNED) / 20) * 100, 2), '.', ',')
        ELSE porc_mat END,

    -- 3. LÍNGUA INGLESA (4 questões)
    porc_li = CASE
        WHEN porc_li IS NULL AND TRIM(acertos_li) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_li) AS UNSIGNED) / 4) * 100, 2), '.', ',')
        ELSE porc_li END,

    -- 4. BIOLOGIA (8 questões)
    porc_bio = CASE
        WHEN porc_bio IS NULL AND TRIM(acertos_bio) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_bio) AS UNSIGNED) / 8) * 100, 2), '.', ',')
        ELSE porc_bio END,

    -- 5. FÍSICA (8 questões)
    porc_fis = CASE
        WHEN porc_fis IS NULL AND TRIM(acertos_fis) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_fis) AS UNSIGNED) / 8) * 100, 2), '.', ',')
        ELSE porc_fis END,

    -- 6. QUÍMICA (8 questões)
    porc_qui = CASE
        WHEN porc_qui IS NULL AND TRIM(acertos_qui) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_qui) AS UNSIGNED) / 8) * 100, 2), '.', ',')
        ELSE porc_qui END,

    -- 7. GEOGRAFIA (7 questões)
    porc_geo = CASE
        WHEN porc_geo IS NULL AND TRIM(acertos_geo) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_geo) AS UNSIGNED) / 7) * 100, 2), '.', ',')
        ELSE porc_geo END,

    -- 8. HISTÓRIA (7 questões)
    porc_his = CASE
        WHEN porc_his IS NULL AND TRIM(acertos_his) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_his) AS UNSIGNED) / 7) * 100, 2), '.', ',')
        ELSE porc_his END,

    -- 9. FILOSOFIA (4 questões)
    porc_fil = CASE
        WHEN porc_fil IS NULL AND TRIM(acertos_fil) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_fil) AS UNSIGNED) / 4) * 100, 2), '.', ',')
        ELSE porc_fil END,

    -- 10. SOCIOLOGIA (4 questões)
    porc_soc = CASE
        WHEN porc_soc IS NULL AND TRIM(acertos_soc) REGEXP '^[0-9]+$'
        THEN REPLACE(ROUND((CAST(TRIM(acertos_soc) AS UNSIGNED) / 4) * 100, 2), '.', ',')
        ELSE porc_soc END;

-- PREENCHENDO OS DADOS DOS CANDIDATOS PRESENTES DE NULL PARA 0
UPDATE PROVAO_STAGING SET
    -- Acertos
    acertos_lp  = COALESCE(acertos_lp, '0'),
    acertos_li  = COALESCE(acertos_li, '0'),
    acertos_bio = COALESCE(acertos_bio, '0'),
    acertos_fis = COALESCE(acertos_fis, '0'),
    acertos_qui = COALESCE(acertos_qui, '0'),
    acertos_mat = COALESCE(acertos_mat, '0'),
    acertos_geo = COALESCE(acertos_geo, '0'),
    acertos_his = COALESCE(acertos_his, '0'),
    acertos_fil = COALESCE(acertos_fil, '0'),
    acertos_soc = COALESCE(acertos_soc, '0'),
    -- Porcentagens
    porc_lp  = COALESCE(porc_lp, '0'),
    porc_li  = COALESCE(porc_li, '0'),
    porc_bio = COALESCE(porc_bio, '0'),
    porc_fis = COALESCE(porc_fis, '0'),
    porc_qui = COALESCE(porc_qui, '0'),
    porc_mat = COALESCE(porc_mat, '0'),
    porc_geo = COALESCE(porc_geo, '0'),
    porc_his = COALESCE(porc_his, '0'),
    porc_fil = COALESCE(porc_fil, '0'),
    porc_soc = COALESCE(porc_soc, '0'),
    -- Notas
    nota_lp_original  = COALESCE(nota_lp_original, '0'),
    nota_lp           = COALESCE(nota_lp, '0'),
    nota_li           = COALESCE(nota_li, '0'),
    nota_bio          = COALESCE(nota_bio, '0'),
    nota_fis          = COALESCE(nota_fis, '0'),
    nota_qui          = COALESCE(nota_qui, '0'),
    nota_mat_original = COALESCE(nota_mat_original, '0'),
    nota_mat          = COALESCE(nota_mat, '0'),
    nota_geo          = COALESCE(nota_geo, '0'),
    nota_his          = COALESCE(nota_his, '0'),
    nota_fil          = COALESCE(nota_fil, '0'),
    nota_soc          = COALESCE(nota_soc, '0')
WHERE PRESENCA = '1';

-- CASO ESPECIAL(REDAÇÃO) OBRIGATÓRIA APENAS NO TERCEIRO ANO
update PROVAO_STAGING set redacao = COALESCE(redacao, '0') where serie=3 and presenca=1;


