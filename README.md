# Documentação do Processo de Limpeza: Provão Paulista 2025 (SARESP)

Este repositório contém o script SQL desenvolvido para tratar, padronizar e limpar os microdados do Provão Paulista de 2025. O objetivo principal do código é transformar a base bruta em uma tabela consolidada, pronta para análise ou importação em ferramentas de Business Intelligence.

## Como obter a base de dados original

O script depende do arquivo CSV oficial disponibilizado pelo governo do estado. Para baixá-lo:

1. Acesse o portal de Dados Abertos da Educação de São Paulo: [dados.educacao.sp.gov.br](https://dados.educacao.sp.gov.br/dataset/microdados-de-alunos-do-sistema-de-avalia%C3%A7%C3%A3o-de-rendimento-escolar-do-estado-de-s%C3%A3o-paulo).
2. Na página, vá até a lista de recursos disponíveis e procure pelo arquivo correspondente ao **Provão Paulista 2025 - Ensino Médio** (ou título equivalente aos microdados de 2025).
3. Clique em baixar para salvar o arquivo `.csv`.
4. Importe o arquivo para o seu banco MySQL com o nome de tabela `Microdados de Alunos - Ensino Medio PROVAO - 2025` antes de rodar o script de limpeza.

---

## O que o script faz (Etapas do Processo)

O script foi estruturado para resolver problemas comuns de bases públicas, como registros duplicados, códigos antigos e falsos valores nulos. O fluxo segue esta ordem:

* **Isolamento dos dados:** Cria uma tabela temporária chamada `PROVAO_STAGING` com uma chave primária própria (`ID`). Isso preserva o arquivo original caso seja necessário refazer o processo.
* **Filtro de colunas:** Remove colunas com códigos internos ou dados redundantes que não servem para análise estatística (como códigos de municípios e escolas que já possuem seus nomes equivalentes na base).
* **Padronização de nomes:** Traduz as siglas originais das colunas para nomes claros e em letras maiúsculas (ex: `CD_ALUNO_ANONIMIZADO` vira simplesmente `ALUNO`).
* **Correção e tradução de deficiências:** Atualiza os códigos do INEP antigos (valores acima de 200) para a tabela atual de deficiências e, em seguida, substitui os códigos numéricos pelos nomes reais das condições de saúde.
* **Limpeza de falsos nulos:** Em arquivos CSV, é muito comum que campos vazios venham preenchidos com o texto `'null'`. O script localiza essas strings e as transforma em valores nulos reais (`NULL`).
* **Simplificação das séries:** Transforma textos longos como "EM-1ª série" em apenas números (`1`, `2` ou `3`).
* **Remoção de duplicatas:** Se um mesmo aluno aparecer mais de uma vez na base, o script usa uma regra de negócio que prioriza a linha mais preenchida (com menos notas nulas). Se o preenchimento for igual, ele mantém o registro mais recente.
* **Cálculo de métricas faltantes:** Caso a porcentagem de acertos de alguma matéria esteja em branco, o script calcula o valor dividindo o número de acertos pelo total de questões daquela disciplina na prova de 2025.
* **Tratamento de faltas:** Para os alunos que estavam presentes na prova (`PRESENCA = '1'`), o script substitui eventuais nulos restantes em notas e acertos por `0`, evitando distorções em cálculos de médias futuras.

---

## Dicionário de Dados

Campos contidos na tabela final `PROVAO_STAGING`:

| Nome da Coluna | Descrição |
| :--- | :--- |
| **ID** | Código identificador gerado automaticamente para controle interno. |
| **DEPARTAMENTO**| Tipo de rede administrativa da escola (Estadual, Privada, etc). |
| **ESCOLA** | Nome completo da instituição de ensino. |
| **SERIE** | Ano do Ensino Médio (valores padronizados em 1, 2 ou 3). |
| **REGIAO** | Região Metropolitana da escola. |
| **ALUNO** | Código anônimo de identificação do estudante. |
| **NEC_ESPECIAL** | Indica se o aluno possui alguma necessidade especial. |
| **PRESENCA** | Status geral de presença no exame (1 para presente, 0 para ausente). |
| **CADERNO_LGCN** | Identificação do caderno de Linguagens e Ciências da Natureza. |
| **CADERNO_MATCH**| Identificação do caderno de Matemática e Ciências Humanas. |
| **PRESENCA_LGCN**| Status de presença no dia da prova de Linguagens e Natureza. |
| **PRESENCA_MATCH**| Status de presença no dia da prova de Matemática e Humanas. |
| **TIPO_PROVA** | Modelo ou versão da prova aplicada ao aluno. |
| **DIRETORIA** | Diretoria de Ensino responsável pela região daquela escola. |
| **MUNICIPIO** | Cidade onde a escola está localizada. |
| **DEF1 a DEF5** | Nome descritivo da deficiência do aluno (permite até 5 registros). |
| **acertos_...** | Quantidade de acertos por matéria (ex: acertos_lp para Português, acertos_mat para Matemática). |
| **porc_...** | Percentual de acertos calculados por matéria. |
| **nota_...** | Notas de proficiência padronizadas por matéria. |
| **nota_lp_original**| Nota bruta de Língua Portuguesa antes dos ajustes de escala. |
| **nota_mat_original**| Nota bruta de Matemática antes dos ajustes de escala. |
| **redacao** | Nota obtida na prova de redação. |

> **Nota sobre os tipos de dados:** Como a tabela de staging mantém a formatação original do arquivo (com uso de vírgulas para decimais e textos em campos numéricos), as colunas de notas e acertos ainda estão salvas como formato de texto (`TEXT`). Se você for realizar cálculos matemáticos pesados ou gerar gráficos, lembre-se de converter esses campos para formatos numéricos (`DECIMAL` ou `INT`) na sua consulta final ou na ferramenta de relatórios.
