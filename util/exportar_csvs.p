DEFINE VARIABLE lMoedas        AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Moedas".
DEFINE VARIABLE lFavorecidos   AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Favorecidos".
DEFINE VARIABLE lCotacoes      AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Cota‡äes".
DEFINE VARIABLE lContas        AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Contas".
DEFINE VARIABLE lCategorias    AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Categorias".
DEFINE VARIABLE lSubcategorias AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Subcategorias".
DEFINE VARIABLE lMovimentos    AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Movimentos".
DEFINE VARIABLE lFeriados      AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Feriados".
DEFINE VARIABLE lLembretes     AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Lembretes".
DEFINE VARIABLE lMovtoLemb     AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Movimentos do Lembrete".
DEFINE VARIABLE lEconomias     AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Economias".
DEFINE VARIABLE lPlanEcon      AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Planejamento Anual de Economias".
DEFINE VARIABLE lOrcamentos    AS LOGICAL VIEW-AS TOGGLE-BOX LABEL "Or‡amentos".

UPDATE lFavorecidos
       lFeriados
       "-------------------------------"
       lMoedas
       lCotacoes
       "-------------------------------"
       lCategorias
       lSubcategorias
       "-------------------------------"
       lContas
       lMovimentos
       "-------------------------------"
       lLembretes
       lMovtoLemb
       "-------------------------------"
       lEconomias
       lPlanEcon
       "-------------------------------"
       lOrcamentos
    WITH 1 COLUMN.

DEFINE VARIABLE iConta LIKE conta.cd-conta COLUMN-LABEL "Conta" NO-UNDO.
DEFINE VARIABLE iMoeda LIKE moeda.cd-moeda COLUMN-LABEL "Moeda" NO-UNDO.
DEFINE VARIABLE dtIni AS DATE COLUMN-LABEL "Data In¡cio" FORMAT "99/99/9999" NO-UNDO.
DEFINE VARIABLE dtFim AS DATE COLUMN-LABEL "Data Fim" FORMAT "99/99/9999" NO-UNDO.
DEFINE VARIABLE cValor AS CHARACTER   NO-UNDO.
DEFINE VARIABLE dtAux AS DATE    NO-UNDO.
DEFINE VARIABLE iMes AS INTEGER     NO-UNDO.
DEFINE VARIABLE lTodos AS LOGICAL COLUMN-LABEL "Todos os lembretes?" FORMAT "Sim/NÆo" NO-UNDO.

DEFINE BUFFER bf-conta FOR conta.
DEFINE BUFFER bf-mov-conta FOR mov-conta.
DEFINE BUFFER bf-movto FOR mov-conta.

DEFINE STREAM str-mov.

/* CSV de Moedas */
IF lMoedas THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\moedas.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "nome;sigla" SKIP.
    FOR EACH moeda:
        PUT UNFORMATTED moeda.ds-moeda ";" 
                        moeda.sigla SKIP.
    END.
    OUTPUT CLOSE.
END.

/* CSV de Favorecidos */
FUNCTION fnDeParaFavorecido RETURNS CHARACTER
  ( cFav AS CHAR ) :

    CASE cFav:
        WHEN "CartÆo de Cr‚dito VISA" THEN RETURN "Pagamento CartÆo de Cr‚dito VISA".
        WHEN "CartÆo de Cr‚dito MASTER" THEN RETURN "Pagamento CartÆo de Cr‚dito MASTER".
        WHEN "CartÆo BIG" THEN RETURN "Pagamento CartÆo BIG".
        WHEN "CD Videokˆ" THEN RETURN "Ambulante".
        WHEN "Encerramento Poupan‡a BESC" THEN RETURN "Encerramento de Conta".
        WHEN "Festa Inaugura‡Æo Apˆ" THEN RETURN "Festa".
        WHEN "Festa Apˆ" THEN RETURN "Festa".
        WHEN "Nintendo 64" THEN RETURN "Camel“".
        WHEN "Festa Sandriane" THEN RETURN "Festa".
        WHEN "Floricultura Cidade das Flores" THEN RETURN "Floricultura".
        WHEN "Presente Larissa" THEN RETURN "Presente".
        WHEN "Escort XR3" THEN RETURN "Revenda de Autom¢veis".
        WHEN "Empregada" THEN RETURN "Diarista".
        WHEN "Dia dos Namorados" THEN RETURN "Presente".
        WHEN "P ra-Brisas" THEN RETURN "Mecƒnica".
        WHEN "Livro Saco de Ossos" THEN RETURN "Livraria".
        WHEN "BalcÆo Cozinha" THEN RETURN "Loja".
        WHEN "Outros Cr‚ditos" THEN RETURN "Presente".
        WHEN "Encerramento de Investimento" THEN RETURN "Encerramento de Conta".
        WHEN "Chap‚u Bruxa Larissa" THEN RETURN "Loja".
        WHEN "CPF" THEN RETURN "Governo do Brasil".
        WHEN "Seguro Desemprego" THEN RETURN "Governo do Brasil".
        WHEN "Jackson" THEN RETURN "Jackson Cesar Hattenhauer".
        WHEN "Cervejada NEWSOFT" THEN RETURN "Festa".
        WHEN "Bolsas" THEN RETURN "Loja".
        WHEN "Instala‡Æo CD-Player" THEN RETURN "Som Automotivo".
        WHEN "Formatura Amigos" THEN RETURN "Formatura".
        WHEN "Posto Geral" THEN RETURN "Posto de Combust¡vel".
        WHEN "FORD" THEN RETURN "Concecion ria Ford".
        WHEN "Elias" THEN RETURN "Acidente".
        WHEN "Karaokˆ Barra do Sul" THEN RETURN "Caraoquˆ".
        WHEN "Pai" THEN RETURN "Jos‚ Eladio Hubner".
        WHEN "Mariana (Namorada Gibran)" THEN RETURN "Mariana Busanello".
        WHEN "Chaveiro Americanas" THEN RETURN "Chaveiro".
        WHEN "Padrinho" THEN RETURN "Gerson Turek".
        WHEN "Lanchonete Geral" THEN RETURN "Lanchonete".
        WHEN "Mercado Geral" THEN RETURN "Mercado".
        WHEN "Pastelaria Geral" THEN RETURN "Pastelaria".
        WHEN "Farm cia Geral" THEN RETURN "Farm cia".
        WHEN "Feira Geral" THEN RETURN "Feira".
        WHEN "Livraria Geral" THEN RETURN "Livraria".
        WHEN "Supermercado Geral" THEN RETURN "Supermercado".
        WHEN "Floricultura Geral" THEN RETURN "Floricultura".
        WHEN "Estacionamento Geral" THEN RETURN "Estacionamento".
        WHEN "Cleiton Chaves" THEN RETURN "Cleiton de Chaves".
        WHEN "Cantina Geral" THEN RETURN "Cantina".
        WHEN "Restaurante da Tigre" THEN RETURN "Restaurante".
        WHEN "Ana - sabonetes" THEN RETURN "Ana Sabonetes".
        WHEN "Mecƒnica Sorriso (Guaratuba)" THEN RETURN "Mecƒnica".
        WHEN "Cervejaria Munique (SP)" THEN RETURN "Cervejaria".
        WHEN "P¢rtico I (Ctba)" THEN RETURN "Posto de Combust¡vel".
        WHEN "Posto de Colores (Guaratuba)" THEN RETURN "Posto de Combust¡vel".
        WHEN "Intimamente (Baln. Cambori£)" THEN RETURN "Intimamente".
        WHEN "Lojas Ca‡ula (Baln. Cambori£)" THEN RETURN "Lojas Ca‡ula".
        WHEN "Pub SÆo Rock (Baln. Cambori£)" THEN RETURN "Pub SÆo Rock".
        WHEN "Special Touch (Antiga VIP Roupas)" THEN RETURN "Special Touch".
        WHEN "Festa da Ta¡nha (Barra do Sul)" THEN RETURN "Festival".
        WHEN "Innocence Lingerie (Rio de Janeiro)" THEN RETURN "Innocence Lingerie".
        WHEN "Restaurante e Piz. Tia Geni (Guaratuba)" THEN RETURN "Restaurante e Piz. Tia Geni".
        WHEN "Verdureira Bom Retiro" THEN RETURN "Verdureira".
        WHEN "QuestÆo de Gosto (B. Cambori£)" THEN RETURN "QuestÆo de Gosto".
        WHEN "Tatsu Confec‡äes (B. Cambori£)" THEN RETURN "Tatsu Confec‡äes".
        WHEN "Confeitaria Gl¢ria (Baln. Cambori£)" THEN RETURN "Confeitaria Gl¢ria".
        WHEN "Restaurante Novo panorƒmico (Guaratuba)" THEN RETURN "Restaurante".
        WHEN "Ichiban Sushi Bar (Baln. Cambori£)" THEN RETURN "Ichiban Sushi Bar".
        WHEN "Transportes Catarinense" THEN RETURN "Catarinense".
        WHEN "Rodovi ria Bal. Cambori£" THEN RETURN "Rodovi ria".
        WHEN "Elisangela L." THEN RETURN "Empr‚stimo".
        WHEN "Conserto de Panelas" THEN RETURN "Autorizada".
        WHEN "Cal‡ados Brasil (Baln. Cambori£)" THEN RETURN "Cal‡ados Brasil".
        WHEN "Happy Days (Baln. Cambori£)" THEN RETURN "Happy Days".
        WHEN "Ivani" THEN RETURN "Empr‚stimo".
        WHEN "L¡via" THEN RETURN "L¡via Beahr".
        WHEN "Basquete" THEN RETURN "Ingressos".
        WHEN "Trof‚u F1P6" THEN RETURN "Campeonato".
        WHEN "Beef Grill (Muller)" THEN RETURN "Beef Grill".
        WHEN "Vani Nani" THEN RETURN "Loja".
        WHEN "A‡ougue Geral" THEN RETURN "A‡ougue".
        WHEN "Mateus (M£sico Casamento Igreja)" THEN RETURN "M£sico".
        WHEN "Ana Doces e Salgados (Costa e Silva)" THEN RETURN "Ana Doces e Salgados".
        WHEN "Loja Geral" THEN RETURN "Loja".
        WHEN "Fl via (Dentista)" THEN RETURN "Dra. Fl via".
        WHEN "Presente Maickel" THEN RETURN "Presente".
        WHEN "Gastos Gerais" THEN RETURN "Trem".
        WHEN "MineirÆo" THEN RETURN "Ingressos".
        WHEN "Hotel Geral" THEN RETURN "Hotel".
        WHEN "Pagamento Arm rio" THEN RETURN "Loja".
        WHEN "Karen - datasul - acessorios" THEN RETURN "Ambulante".
        WHEN "Pagamento Cama" THEN RETURN "Loja".
        WHEN "Presente D‚bora" THEN RETURN "Presente".
        WHEN "M£sicos Instrumentos Musicais" THEN RETURN "Loja".
        WHEN "V¡deo-Locadora Geral" THEN RETURN "V¡deo Locadora".
        WHEN "Afonso Bioqu¡mico" THEN RETURN "Ambulante".
        WHEN "Sandra - SGP" THEN RETURN "Ambulante".
        WHEN "Trabalhos Mestrado" THEN RETURN "C¢pias".
        WHEN "Reunidas -  “nibus" THEN RETURN "Reunidas".
        WHEN "Buffet - Mineiro - Cidade das Flores" THEN RETURN "Buffet Mineiro".
        WHEN "Montador M¢veis Atlanta" THEN RETURN "Montador de M¢veis".
        WHEN "Lava‡Æo de Carro GERAL" THEN RETURN "Lava‡Æo de Carro".
        WHEN "Sergio Souza - NEWSOFT" THEN RETURN "Sergio Souza".
        WHEN "Renault" THEN RETURN "Concecion ria Renault".
        WHEN "Sorveteria Geral" THEN RETURN "Sorveteria".
        WHEN "ânibus Geral" THEN RETURN "ânibus".
        WHEN "Doceria" THEN RETURN "Confeitaria".
        WHEN "Danceteria Geral" THEN RETURN "Danceteria".
        WHEN "Verdureira Geral" THEN RETURN "Verdureira".
        WHEN "Dudy" THEN RETURN "Churrasqueiro".
        WHEN "Confec‡äes Yoo (Japonesa)" THEN RETURN "Confec‡äes Yoo".
        WHEN "Jogos de Apostas" THEN RETURN "Cacheta".
        WHEN "Motel GERAL" THEN RETURN "Motel".
        WHEN "SOS UNIMED" THEN RETURN "UNIMED".
        WHEN "Aluizio" THEN RETURN "Amigos".
        WHEN "Choperia Geral" THEN RETURN "Choperia".
        WHEN "Confeitaria GERAL" THEN RETURN "Confeitaria".
        WHEN "Passeios & Afins" THEN RETURN "Ingressos".
        WHEN "Pol¡cia Federal (DPF)" THEN RETURN "Pol¡cia Federal".
        WHEN "Ponto Tur¡stico" THEN RETURN "Ingressos".
        WHEN "Transferˆncia Pontos SMILES\TAM" THEN RETURN "TAM".
        WHEN "Jardineiro (Valter)" THEN RETURN "Jardineiro".
        WHEN "Restaurante Emmendorfer (L¡rica)" THEN RETURN "Restaurante Emmendorfer L¡rica".
        WHEN "Quem disse berenice" THEN RETURN "Quem Disse Berenice".
        WHEN "Verdureira Costa e Silva" THEN RETURN "Esta‡Æo das Frutas".
        WHEN "Vanessa Vieira Leite - Dentista" THEN RETURN "Dra. Vanessa Vieira Leite".
        WHEN "Lavanderia Geral" THEN RETURN "Lavanderia".
        WHEN "Evento" THEN RETURN "Festival".
        WHEN "Marlene (Sid)" THEN RETURN "Marlene Caroline".
        WHEN "Romeu / Camila (Cida)" THEN RETURN "Romeo Caicedo".
        WHEN "Cantinho das Delicias - Havan" THEN RETURN "Cantinho das Delicias Havan".
        WHEN "Compra Moeda Estrangeira" THEN RETURN "Casa de Cƒmbio".
        WHEN "Fenashop" THEN RETURN "Festival".
        WHEN "BIG" THEN RETURN "Hipermercados BIG".
        WHEN "Almo‡o" THEN RETURN "Restaurante".
        WHEN "IPTU" THEN RETURN "Prefeitura de Joinville".
        WHEN "Prefeitura Municipal de Garuva" THEN RETURN "Prefeitura de Garuva".
        WHEN "Pai e MÆe" THEN RETURN "Jos‚ Eladio Hubner".
        WHEN "IOF" THEN RETURN "Governo do Brasil".
        WHEN "F‚rias" THEN RETURN "Ingressos".
        WHEN "Garagem Pr‚dio" THEN RETURN "Aluguel de Garagem".
        WHEN "GNC" THEN RETURN "GNC Cinemas".
        WHEN "Lanchonete Faculdade" THEN RETURN "Lanchonete".
        WHEN "Bar Centreventos" THEN RETURN "Bar".
        WHEN "Prote‡Æo Ouro" THEN RETURN "Banco do Brasil".
        WHEN "Posto MAXINORTE" THEN RETURN "Posto Maxinorte".
        WHEN "Posto Colon TEXACO" THEN RETURN "Posto Colon".
        WHEN "MAXINORTE" THEN RETURN "Posto Maxinorte".
        WHEN "Posto Pequeno Pr¡ncipe" THEN RETURN "Posto Pr¡ncipe".
        WHEN "Posto Dist. Industrial" THEN RETURN "Posto Distrito Industrial".
        WHEN "Trento" THEN RETURN "Cantina Trento".
        WHEN "Estacionamento Shoping" THEN RETURN "Estacionamento".
        WHEN "1.99" THEN RETURN "Loja 1.99".
        WHEN "SÆo Jos‚" THEN RETURN "Confeitaria SÆo Jos‚".
        WHEN "Futebol" THEN RETURN "JEC".
        WHEN "Estacionamento Centreventos" THEN RETURN "Estacionamento".
        WHEN "M¡stica" THEN RETURN "Loja M¡stica".
        WHEN "Pastelaria do Muller" THEN RETURN "10 Past‚is".
        WHEN "Posto Baln. Cambori£" THEN RETURN "Posto de Combust¡vel".
        WHEN "Restaurante da ETT (Tupy)" THEN RETURN "Restaurante".
        WHEN "Troco Ticket Alimenta‡Æo" THEN RETURN "Troco".
        WHEN "Bar do Gin stico" THEN RETURN "Bar".
        WHEN "Sindicato das Empresas de PD de Jville" THEN RETURN "SINDPD".
        WHEN "Restaurante do SENAI" THEN RETURN "Restaurante".
        WHEN "Troco de Cheque" THEN RETURN "Troco".
        WHEN "Pagamento Carro" THEN RETURN "Jos‚ Eladio Hubner".
        WHEN "Transferˆncia entre carteiras" THEN RETURN "Transferˆncia entre Carteiras".
        WHEN "Salgadinhos Datasul" THEN RETURN "Salgadinhos".
        WHEN "Lorival" THEN RETURN "Jos‚ Lorival Solak".
        WHEN "Bavaria (Padaria)" THEN RETURN "Padaria Bav ria".
        WHEN "Doa‡äes" THEN RETURN "Doa‡Æo".
        WHEN "Caf‚ do Muller" THEN RETURN "Cafeteria".
        WHEN "Cuca Empresa" THEN RETURN "Cuca".
        WHEN "Vaquinhas Empresa" THEN RETURN "Vaquinha".
        WHEN "Transferˆncia Poupan‡a" THEN RETURN "Transferˆncia para Poupan‡a".
        WHEN "Acerto em Dinheiro" THEN RETURN "Acertos".
        WHEN "Quiosque Beira-Mar" THEN RETURN "Quiosque".
        WHEN "E Catarina Panificadora" THEN RETURN "ECatarina".
        WHEN "Martins" THEN RETURN "Martins Frutos do Mar".
        WHEN "Supermercado Farias" THEN RETURN "Mercado Farias".
        WHEN "Festa da Solidariedade" THEN RETURN "Festival".
        WHEN "Onibus" THEN RETURN "ânibus".
        WHEN "Cerveja Empresa" THEN RETURN "Boteco".
        WHEN "Concession ria Ford Roesler" THEN RETURN "Concession ria Ford".
        WHEN "Prefeitura Municipal de Joinville" THEN RETURN "Prefeitura de Joinville".
        WHEN "Locadora" THEN RETURN "V¡deo Locadora".
        WHEN "OberlandFest" THEN RETURN "Festival".
        WHEN "Wal Mart" THEN RETURN "Walmart".
        WHEN "Compra de Cotas da Empresa" THEN RETURN "Compra de Quotas".
        WHEN "Choperia da Brahma no Mueller" THEN RETURN "Choperia Brahma".
        WHEN "Bijuterias" THEN RETURN "Ambulante".
        WHEN "Troco de CartÆo" THEN RETURN "Troco".
        WHEN "Seguro DPVAT Obrigat¢rio de Ve¡culos" THEN RETURN "Seguro DPVAT".
        WHEN "Parque Cataratas do Igua‡u" THEN RETURN "Ingressos".
        WHEN "Usina de Itaip£" THEN RETURN "Ingressos".
        WHEN "Concession ria Le Monde" THEN RETURN "Concession ria Citr”en".
        WHEN "Vin¡cula Bento Gon‡alves" THEN RETURN "Vin¡cula".
        WHEN "Estacionamento Datasul" THEN RETURN "Estacionamento".
        WHEN "IBERIA - Companhia A‚rea" THEN RETURN "IBERIA".
        WHEN "Wal-Mart" THEN RETURN "Walmart".
        WHEN "XPi Investimentos CCTVM S/A" THEN RETURN "XP Investimentos".
        WHEN "Caf‚ Empresa" THEN RETURN "M quina de Conveniˆncias".
        WHEN "Concession ria NISSAN" THEN RETURN "Concession ria Nissan".
        WHEN "Adilson Rutneia" THEN RETURN "Adilson Pinheiro".
        WHEN "Sa£de BRADESCO" THEN RETURN "Sa£de Bradesco".
        WHEN "Cirurgia" THEN RETURN "M‚dico".
        WHEN "Mr. Magu" THEN RETURN "Le Magu".
        WHEN "Lanche" THEN RETURN "Lanchonete".
        WHEN "Poquer" THEN RETURN "P“quer".
        WHEN "Ferry-Boat" THEN RETURN "Balsa".
        OTHERWISE RETURN cFav.
    END CASE.

END FUNCTION.
IF lFavorecidos THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\favorecidos.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "nome" SKIP.
    FOR EACH favorecido
        WHERE CAN-FIND(FIRST mov-conta OF favorecido):
        PUT UNFORMATTED fnDeParaFavorecido(favorecido.ds-favorecido) SKIP.
    END.
    OUTPUT CLOSE.
END.

/* CSV de Cota‡äes */
IF lCotacoes THEN DO:

    UPDATE iMoeda
        WITH FRAME f-moeda.
    FIND FIRST moeda
        WHERE moeda.cd-moeda = iMoeda NO-ERROR.
    IF AVAIL moeda OR iConta = 0 THEN DO:

        IF iMoeda <> 0 THEN
            DISP moeda.ds-moeda
                WITH FRAME f-moeda.
        ELSE
            DISP "Todas" @ moeda.ds-moeda
                WITH FRAME f-moeda.

        ASSIGN dtIni = TODAY - 30
               dtFim = TODAY + 30.

        UPDATE dtIni dtFim
            WITH FRAME f-moeda.

        OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\cotacoes.csv" CONVERT TARGET "UTF-8".
        PUT UNFORMATTED "moeda;data_inicio;data_fim;valor" SKIP.
        FOR EACH moeda
            WHERE (IF iMoeda = 0 THEN TRUE ELSE moeda.cd-moeda = iMoeda):
            FOR EACH cotacao OF moeda
                WHERE (cotacao.dt-ini >= (dtIni - 1) AND cotacao.dt-ini <= (dtFim + 1))
                OR    (cotacao.dt-end >= (dtIni - 1) AND cotacao.dt-end <= (dtFim + 1)):
                IF YEAR(cotacao.dt-ini) > 1899 THEN
                    ASSIGN dtAux = cotacao.dt-ini.
                ELSE
                    ASSIGN dtAux = DATE(1, 1, 1900).
                PUT UNFORMATTED moeda.ds-moeda ";" 
                                STRING(dtAux, "99/99/9999") ";" 
                                STRING(cotacao.dt-end, "99/99/9999") ";"
                                TRIM(REPLACE(STRING(cotacao.valor, "->>>>>>>>9.999999"), ",", ".")) SKIP.
            END.
        END.
        OUTPUT CLOSE.

    END.
END.

/* CSV de Contas */
IF lContas THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\contas.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "descricao;moeda;tipo;saldo_ini;saldo;data_saldo;limite;encerrada;data_encerramento;dias_fatura;favorecido;perc_imposto;conta_pagamento" SKIP.
    FOR EACH conta,
        FIRST moeda OF conta:
        PUT UNFORMATTED conta.ds-conta ";"
                        moeda.ds-moeda ";".

        IF conta.ds-conta BEGINS "A‡äes"
        OR conta.ds-conta BEGINS "A‡Æo"
        OR conta.ds-conta BEGINS "Datasul"
        OR conta.ds-conta BEGINS "MH"
        OR conta.ds-conta BEGINS "Tetra"
        OR conta.ds-conta BEGINS "àtima" THEN DO:
            PUT UNFORMATTED "A‡Æo;".
        END.
        ELSE DO:
            CASE conta.id-tipo:
                WHEN 1 THEN PUT UNFORMATTED "Conta banc ria;".
                WHEN 2 THEN PUT UNFORMATTED "Investimento;".
                WHEN 3 THEN DO:
                    IF conta.dinheiro THEN
                        PUT UNFORMATTED "Dinheiro;".
                    ELSE
                        PUT UNFORMATTED "CartÆo de cr‚dito;".
                END.
            END CASE.
        END.

        PUT UNFORMATTED TRIM(REPLACE(STRING(conta.vl-saldo-ini, "->>>>>>>>9.99"), ",", ".")) ";"
                        TRIM(REPLACE(STRING(conta.vl-saldo, "->>>>>>>>9.99"), ",", ".")) ";"
                        STRING(conta.dt-saldo, "99/99/9999") ";"
                        TRIM(REPLACE(STRING(conta.vl-limite, "->>>>>>>>9.99"), ",", ".")) ";"
                        STRING(conta.id-encerrada, "Sim/NÆo") ";".

        IF conta.id-encerrada THEN DO:
            FIND LAST mov-conta OF conta NO-LOCK NO-ERROR.
            PUT UNFORMATTED STRING(mov-conta.dt-mov, "99/99/9999") ";".
        END.
        ELSE DO:
            PUT UNFORMATTED ";".
        END.
                        
        PUT UNFORMATTED STRING(conta.dia-fat * (-1)) ";".

        FIND FIRST favorecido 
            WHERE favorecido.cd-favorecido = conta.cd-fav-padrao NO-ERROR.
        IF AVAIL favorecido THEN
            PUT UNFORMATTED fnDeParaFavorecido(favorecido.ds-favorecido) ";".
        ELSE
            PUT UNFORMATTED ";".

        PUT UNFORMATTED TRIM(REPLACE(STRING(conta.perc-ir, ">>9.99"), ",", ".")) ";".

        FIND FIRST bf-conta WHERE bf-conta.id-tipo = 1.
        IF conta.id-tipo = 3 AND NOT conta.dinheiro THEN
            PUT UNFORMATTED bf-conta.ds-conta SKIP.
        ELSE
            PUT UNFORMATTED "" SKIP.

    END.
    OUTPUT CLOSE.
END.

/* CSV de Categorias */
FUNCTION fnDeParaCategoria RETURNS CHARACTER
  ( cCat AS CHAR ) :

    CASE cCat:
        WHEN "Impostos & Tarifas P£blicas" THEN RETURN "Impostos e Taxas".
        WHEN "Artigos Pessoais" THEN RETURN "Gastos Pessoais".
        WHEN "Sal rios e Ordenado" THEN RETURN "Sal rio".
        WHEN "Higiene Pessoal" THEN RETURN "Higiene e Beleza".
        WHEN "Autom¢vel" THEN RETURN "Autom¢veis".
        WHEN "Artigos Dom‚sticos" THEN RETURN "Gastos Dom‚sticos".
        WHEN "Equipamentos Musicais" THEN RETURN "Instrumentos Musicais".
        WHEN "Despesas Dom‚sticas" THEN RETURN "Moradia".
        WHEN "Apostas" THEN RETURN "Jogos e Apostas".
        WHEN "Despesas de Trabalho" THEN RETURN "Trabalho".
        OTHERWISE RETURN cCat.
    END CASE.

END FUNCTION.
IF lCategorias THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\categorias.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "descricao;tipo" SKIP.
    FOR EACH categoria:
        PUT UNFORMATTED fnDeParaCategoria(categoria.ds-categoria) ";".
        CASE categoria.id-tipo:
            WHEN 1 THEN PUT UNFORMATTED "Receita" SKIP.
            WHEN 2 THEN PUT UNFORMATTED "Despesa" SKIP.
        END CASE.
    END.
    OUTPUT CLOSE.
END.

/* CSV de SubCategorias */
FUNCTION fnDeParaSubCategoria RETURNS CHARACTER
  ( cCat AS CHAR, cSub AS CHAR ) :

    ASSIGN cCat = fnDeParaCategoria(cCat).

    CASE cSub:
        WHEN "Juros de Poupan‡a" THEN ASSIGN cSub = "Poupan‡a".
        WHEN "Dividendos & Juros s/ Capital" THEN ASSIGN cSub = "Dividendos".
        WHEN "Juros de Empr‚stimos" THEN ASSIGN cSub = "Empr‚stimos".
        WHEN "Juros Semestrais do Tesouro Direto" THEN ASSIGN cSub = "Tesouro Direto".
        WHEN "Aluguel de Im¢veis" THEN ASSIGN cSub = "Aluguel".
        WHEN "Utens¡lios" THEN ASSIGN cSub = "Outros Gastos".
        WHEN "Xampus e Perfumes" THEN ASSIGN cSub = "Higiene".
        WHEN "Outros impostos" THEN ASSIGN cSub = "Outros".
        WHEN "IPVA, Licenciamento & Transferˆncia" THEN ASSIGN cSub = "IPVA, Licenciamento e Transferˆncia".
        WHEN "Imposto de Renda (IRF)" THEN ASSIGN cSub = "Imposto de Renda".
        WHEN "Retirada\Renova‡Æo de Documentos" THEN ASSIGN cSub = "Retirar ou Renovar Documentos".
        WHEN "Taxa de Coleta de Lixo" THEN ASSIGN cSub = "Coleta de Lixo".
        WHEN "CD's & DVD's" THEN ASSIGN cSub = "M£sica".
        WHEN "Maquiagens & Afins" THEN DO:
            ASSIGN cCat = fnDeParaCategoria("Higiene Pessoal")
                   cSub = "Maquiagem e Cosm‚ticos".
        END.
        WHEN "Im¢veis Financiados" THEN ASSIGN cSub = "Im¢veis".
        WHEN "Livros, Revistas & Jornais" THEN ASSIGN cSub = "Livros e Leitura".
        WHEN "Artigos Esportivos" THEN ASSIGN cSub = "Esportes".
        WHEN "Bolsas & Malas" THEN ASSIGN cSub = "Bolsas, Malas e Mochilas".
        WHEN "J¢ias & Afins" THEN ASSIGN cSub = "J¢ias, Rel¢gios e Acess¢rios".
        WHEN "Brinquedos & Afins" THEN ASSIGN cSub = "Brinquedos".
        WHEN "àculos e afins" THEN ASSIGN cSub = "àculos".
        WHEN "Tatuagens & Piercings" THEN ASSIGN cSub = "Tatuagens e Piercings".
        WHEN "Bicicletas e Acess¢rios" THEN ASSIGN cSub = "Bicicletas".
        WHEN "Empresas" THEN ASSIGN cSub = "Novos Neg¢cios".
        WHEN "Adiantamento" THEN ASSIGN cSub = "Pagamento".
        WHEN "Abono de F‚rias + Venda de Dias" THEN ASSIGN cSub = "Abono de F‚rias ou Venda de Dias".
        WHEN "Retirada Fundo de Garantia" THEN ASSIGN cSub = "Fundo de Garantia".
        WHEN "Ticket Alimenta‡Æo" THEN ASSIGN cSub = "Vale Alimenta‡Æo".
        WHEN "Hora Extra 160%" THEN ASSIGN cSub = "Hora Extra".
        WHEN "Hora Extra 200%" THEN ASSIGN cSub = "Hora Extra".
        WHEN "Hora Extra Repouso Remunerado" THEN ASSIGN cSub = "Hora Extra".
        WHEN "Hora Extra 220%" THEN ASSIGN cSub = "Hora Extra".
        WHEN "Reembolso Alimenta‡Æo" THEN ASSIGN cSub = "Reembolso de Despesas".
        WHEN "Remunera‡Æo Vari vel Mensal" THEN ASSIGN cSub = "ComissÆo".
        WHEN "Adicionais" THEN ASSIGN cSub = "Pagamento".
        WHEN "Trabalho Extra" THEN ASSIGN cSub = "Trabalhos Aut“nomos".
        WHEN "Remunera‡Æo Vari vel Mensal Sem IR" THEN ASSIGN cSub = "ComissÆo".
        WHEN "Abono Compra Notebook" THEN ASSIGN cSub = "Gratifica‡äes".
        WHEN "Abono Compra Notebook" THEN ASSIGN cSub = "Gratifica‡äes".
        WHEN "Reembolso Plano de Sa£de" THEN ASSIGN cSub = "Plano de Sa£de".
        WHEN "Faturamento de Servi‡o Aut“nomo" THEN ASSIGN cSub = "Trabalhos Aut“nomos".
        WHEN "Retirar Moedas do Cofre" THEN ASSIGN cSub = "Despesas Gerais".
        WHEN "Eventos Esportivos" THEN ASSIGN cSub = "Jogos Esportivos".
        WHEN "DiversÆo, Festas & Viagens" THEN ASSIGN cSub = "Festas e Viagens".
        WHEN "Shows" THEN ASSIGN cSub = "Shows Musicais".
        WHEN "Museus, Parques & Eventos Culturais" THEN ASSIGN cSub = "Museus e Apresenta‡äes Culturais".
        WHEN "Bares & Bebidas" THEN ASSIGN cSub = "Bares e Bebidas".
        WHEN "Artigos Tabagistas" THEN ASSIGN cSub = "Cigarro e Tabagismo".
        WHEN "Brindes Recebidos" THEN ASSIGN cSub = "Presentes Recebidos".
        WHEN "DivisÆo de Combust¡vel de Viagem" THEN ASSIGN cSub = "DivisÆo de Despesas".
        WHEN "Erro de Troco" THEN ASSIGN cSub = "Troco Incorreto".
        WHEN "Vendas em Geral" THEN ASSIGN cSub = "Vendas".
        WHEN "Restitui‡Æo de IR" THEN ASSIGN cSub = "Restitui‡Æo do Imposto de Renda".
        WHEN "DivisÆo de Presentes" THEN ASSIGN cSub = "Reembolsos".
        WHEN "Acertos Dom‚sticos" THEN ASSIGN cSub = "Acertos".
        WHEN "Acertos Gerais" THEN ASSIGN cSub = "Acertos".
        WHEN "Apostas & Jogos" THEN ASSIGN cSub = "Premia‡äes".
        WHEN "Prˆmio do Seguro" THEN ASSIGN cSub = "Outras Devolu‡äes".
        WHEN "Vit¢ria A‡Æo Judicial" THEN ASSIGN cSub = "A‡äes Judiciais".
        WHEN "Venda de Software / Servi‡o" THEN ASSIGN cSub = "Vendas".
        WHEN "Split de A‡äes" THEN ASSIGN cSub = "Acertos".
        WHEN "Abertura de Empresa Pr¢pria" THEN ASSIGN cSub = "Acertos".
        WHEN "Artigos Femininos" THEN ASSIGN cSub = "Produtos Femininos".
        WHEN "Cremes & àleos" THEN ASSIGN cSub = "Cremes e àleos".
        WHEN "Artigos Masculinos" THEN ASSIGN cSub = "Produtos Masculinos".
        WHEN "Artigos para Bebˆ" THEN ASSIGN cSub = "Produtos para Bebˆ".
        WHEN "D‚bora" THEN ASSIGN cSub = "Esposa ou Marido".
        WHEN "Maickel" THEN ASSIGN cSub = "Esposa ou Marido".
        WHEN "Combust¡vel Custo" THEN ASSIGN cSub = "Combust¡vel".
        WHEN "Acidente" THEN ASSIGN cSub = "Acidentes".
        WHEN "Alarme" THEN ASSIGN cSub = "Artigos e Acess¢rios".
        WHEN "Acess¢rios" THEN ASSIGN cSub = "Artigos e Acess¢rios".
        WHEN "Combust¡vel Despesa" THEN ASSIGN cSub = "Combust¡vel".
        WHEN "Livros & Materiais" THEN ASSIGN cSub = "Material Escolar".
        WHEN "Mensalidade P¢s-Gradua‡Æo" THEN ASSIGN cSub = "P¢s-Gradua‡Æo".
        WHEN "Anuidade UNE" THEN ASSIGN cSub = "Associa‡äes Estudantis".
        WHEN "Mensalidade Inglˆs" THEN ASSIGN cSub = "Curso de Idioma".
        WHEN "Mensalidade M£sica" THEN ASSIGN cSub = "Aulas de M£sica".
        WHEN "Diploma" THEN ASSIGN cSub = "Formatura".
        WHEN "Trabalhos" THEN ASSIGN cSub = "Trabalhos Escolares".
        WHEN "Mensalidade Espanhol" THEN ASSIGN cSub = "Curso de Idioma".
        WHEN "Cursos & Concursos" THEN ASSIGN cSub = "Treinamentos e Concursos".
        WHEN "Fast Food" THEN ASSIGN cSub = "Lanchonete".
        WHEN "Congelados" THEN ASSIGN cSub = "Comida Congelada".
        WHEN "A‡ougue & Peixaria" THEN ASSIGN cSub = "A‡ougue e Peixaria".
        WHEN "Sorvetes & Picol‚s" THEN ASSIGN cSub = "Sorvetes e Picol‚s".
        WHEN "Bobageiras" THEN ASSIGN cSub = "Balas, Doces e Salgadinhos".
        WHEN "Frutas & Verduras" THEN ASSIGN cSub = "Frutas, Verduras e Legumes".
        WHEN "Bolos, Cucas & Afins" THEN ASSIGN cSub = "Confeitaria".
        WHEN "Queijos & Aperitivos" THEN ASSIGN cSub = "Queijos, Aperitivos e Conservas".
        WHEN "Churrascaria" THEN ASSIGN cSub = "Almo‡o Fim de Semana".
        WHEN "Salgadinhos & Afins" THEN ASSIGN cSub = "Lanchonete".
        WHEN "Frios & Iogurtes" THEN ASSIGN cSub = "Frios, Iogurtes e Latic¡nios".
        WHEN "Sucos & Afins" THEN ASSIGN cSub = "Sucos e Bebidas".
        WHEN "Foundue" THEN ASSIGN cSub = "Jantar".
        WHEN "Taxa Cheque sem Fundo" THEN ASSIGN cSub = "Taxas Banc rias".
        WHEN "Juros Financiamento Imobili rio" THEN ASSIGN cSub = "Juros".
        WHEN "Taxa Cheque Valor Baixo" THEN ASSIGN cSub = "Taxas Banc rias".
        WHEN "Taxa de Saque (Moeda Estrangeira)" THEN ASSIGN cSub = "Taxas Banc rias".
        WHEN "Segunda via de CartÆo" THEN ASSIGN cSub = "Solicita‡Æo de CartÆo".
        WHEN "Taxa Cheque Valor Alto" THEN ASSIGN cSub = "Taxas Banc rias".
        WHEN "Taxa de Cust¢dia de A‡äes" THEN ASSIGN cSub = "Cust¢dia de A‡äes".
        WHEN "Taxa EmissÆo Folha de Cheque" THEN ASSIGN cSub = "Taxas Banc rias".
        WHEN "Cama, Mesa & Banho" THEN ASSIGN cSub = "Cama, Mesa e Banho".
        WHEN "Itens de Decora‡Æo" THEN ASSIGN cSub = "Decora‡Æo".
        WHEN "Itens para Churrasco" THEN ASSIGN cSub = "Cozinha e Utilidades Dom‚sticas".
        WHEN "Itens de Limpeza" THEN ASSIGN cSub = "Limpeza".
        WHEN "Artigos Natalinos" THEN ASSIGN cSub = "Produtos Natalinos".
        WHEN "Copos & Ta‡as" THEN ASSIGN cSub = "Copos, Ta‡as e Lou‡a".
        WHEN "Itens de Horta e Jardim" THEN ASSIGN cSub = "Horta e Jardim".
        WHEN "Itens de Piscina" THEN ASSIGN cSub = "Piscina".
        WHEN "Itens de Conserva‡Æo" THEN ASSIGN cSub = "Conserva‡Æo".
        WHEN "Pastas, Livros & Afins" THEN ASSIGN cSub = "Outros Produtos".
        WHEN "Suportes & Afins" THEN ASSIGN cSub = "Suportes e Pedestais".
        WHEN "Rem‚dios Reembols veis" THEN ASSIGN cSub = "Rem‚dios".
        WHEN "Plano Odontol¢gico" THEN ASSIGN cSub = "Dentista".
        WHEN "Itens M‚dicos" THEN ASSIGN cSub = "Produtos M‚dicos".
        WHEN "Roupas de Esporte" THEN ASSIGN cSub = "Roupas Esportivas".
        WHEN "Biquinis & Moda Praia" THEN ASSIGN cSub = "Praia".
        WHEN "Roupas Meia-Esta‡Æo" THEN ASSIGN cSub = "Roupas".
        WHEN "Roupas Öntimas & Pijamas" THEN ASSIGN cSub = "Roupas Öntimas e Pijamas".
        WHEN "Aluguel de Trajes" THEN ASSIGN cSub = "Aluguel".
        WHEN "Roupas de Inverno" THEN ASSIGN cSub = "Roupas".
        WHEN "Roupas de VerÆo" THEN ASSIGN cSub = "Roupas".
        WHEN "Artigos & Utilit rios" THEN ASSIGN cSub = "Meias, Len‡os, Cintos e Acess¢rios".
        WHEN "Empregadas & Diaristas" THEN ASSIGN cSub = "Empregadas ou Diaristas".
        WHEN "Telefone / Internet M¢vel" THEN ASSIGN cSub = "Telefone e Internet M¢vel".
        WHEN "Reformas em Geral" THEN ASSIGN cSub = "Reforma".
        WHEN "Itens de Praia" THEN DO:
            ASSIGN cCat = fnDeParaCategoria("Higiene Pessoal")
                   cSub = "Cremes e àleos".
        END.
        WHEN "Sorveteria & Lanchonete" THEN ASSIGN cSub = "Sorveteria e Lanchonete".
        WHEN "Viagens & Pacotes Tur¡sticos" THEN ASSIGN cSub = "Viagem e Pacotes Tur¡sticos".
        WHEN "Sucos & Bebidas" THEN ASSIGN cSub = "Sucos e Bebidas".
        WHEN "City-Tours, By-Nights & Afins" THEN ASSIGN cSub = "Passeios".
        WHEN "Guias, Cursos de Idioma e Dicion rios" THEN ASSIGN cSub = "Guias e Dicion rios".
        WHEN "Contra Roubo - CartÆo de Cr‚dito" THEN ASSIGN cSub = "CartÆo de Cr‚dito".
        WHEN "Seguro Viagem" THEN ASSIGN cSub = "Viagem".
        WHEN "Seguro Financiamento Imobili rio" THEN ASSIGN cSub = "Financiamento Imobili rio".
        WHEN "Roupas & Cal‡ados" THEN ASSIGN cSub = "Roupas e Cal‡ados".
        WHEN "Artigos de Cozinha" THEN ASSIGN cSub = "Produtos de Cozinha".
        WHEN "Artigos Pessoais" THEN ASSIGN cSub = "Produtos Pessoais".
        WHEN "BolÆo de Apostas" THEN ASSIGN cSub = "BolÆo".
        WHEN "Devolu‡Æo de multa do FGTS" THEN ASSIGN cSub = "Devolu‡äes".
        WHEN "Devolu‡Æo de Adiantamento" THEN ASSIGN cSub = "Devolu‡äes".
        WHEN "Compra de Solu‡äes" THEN ASSIGN cSub = "Outras Despesas".
        WHEN "Gastos Reembols veis & Empr‚stimos" THEN ASSIGN cSub = "Empr‚stimos e Despesas Reembols veis".
        WHEN "Casamento" THEN ASSIGN cSub = "Comemora‡äes Especiais".
        WHEN "Gorjeta & Doa‡äes" THEN ASSIGN cSub = "Doa‡äes ou Gorjetas".
        WHEN "Vel¢rios & Enterros" THEN ASSIGN cSub = "Vel¢rios e Enterros".
        WHEN "Acerto de Valores" THEN ASSIGN cSub = "Acertos".
        WHEN "Acertos Gerais" THEN ASSIGN cSub = "Acertos".
        WHEN "Furtos" THEN ASSIGN cSub = "Furto ou Roubo".
        WHEN "Lan House" THEN ASSIGN cSub = "Impressäes, C¢pias e Internet".
        WHEN "C¢pias" THEN ASSIGN cSub = "Impressäes, C¢pias e Internet".
        WHEN "Correio & Entregas" THEN ASSIGN cSub = "Correio e Entregas".
        WHEN "Outras Despesas" THEN DO:
            CASE cCat:
                WHEN "Educa‡Æo" THEN ASSIGN cSub = "P¢s-Gradua‡Æo".
                OTHERWISE ASSIGN cSub = "Outras Despesas".
            END CASE.
        END.
        WHEN "Itens Gerais" THEN DO:
            CASE cCat:
                WHEN "Autom¢vel" THEN ASSIGN cSub = "Artigos e Acess¢rios".
                OTHERWISE ASSIGN cSub = "Outros Produtos".
            END CASE.
        END.
        WHEN "Devolu‡äes" THEN DO:
            CASE cCat:
                WHEN "Outros Rendimentos" THEN ASSIGN cSub = "Outras Devolu‡äes".
            END CASE.
        END.
        WHEN "Outros" THEN ASSIGN cSub = "Outras Ocasiäes".
    END CASE.

    RETURN cCat + ";" + cSub.

END FUNCTION.
IF lSubcategorias THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\subcategorias.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "categoria;descricao;tipo" SKIP.
    FOR EACH sub-cat,
        FIRST categoria OF sub-cat:
        PUT UNFORMATTED fnDeParaSubCategoria(categoria.ds-categoria, sub-cat.ds-sub) ";".
        CASE categoria.id-tipo:
            WHEN 1 THEN DO:
                CASE ENTRY(2, fnDeParaSubCategoria(categoria.ds-categoria, sub-cat.ds-sub), ";"):
                    WHEN "Poupan‡a"
                    OR WHEN "Dividendos"
                    OR WHEN "Juros de Empr‚stimo"
                    OR WHEN "Tesouro Direto"
                    OR WHEN "Aluguel"
                    OR WHEN "Devolu‡Æo de Empr‚stimos"
                    OR WHEN "Presentes Recebidos"
                    OR WHEN "Troco Incorreto"
                    OR WHEN "Premia‡äes"
                    OR WHEN "Restitui‡Æo do Imposto de Renda"
                    OR WHEN "Reembolsos"
                    OR WHEN "A‡äes Judiciais"
                    OR WHEN "Sal rio Maternidade"
                    OR WHEN "Outras Devolu‡äes" THEN PUT UNFORMATTED "Renda passiva" SKIP.
                    OTHERWISE PUT UNFORMATTED "Renda ativa" SKIP.
                END CASE.
            END.
            WHEN 2 THEN DO:
                CASE sub-cat.id-tipo:
                    WHEN 1 THEN PUT UNFORMATTED "Despesa" SKIP.
                    WHEN 2 THEN PUT UNFORMATTED "Custo" SKIP.
                END CASE.
            END.
        END CASE.
    END.
    OUTPUT CLOSE.
END.

/* CSV de Movimentos */
FUNCTION fnDeParaTipoMovto RETURNS CHARACTER
  ( iTipo AS INT, deValor AS DEC, cConta AS CHAR, iTipoConta AS INT, lDinheiro AS LOG ) :

    DEFINE VARIABLE cReturn AS CHARACTER   NO-UNDO INITIAL ";".

    IF iTipo = 3 THEN
        ASSIGN cReturn = "Movimenta‡Æo entre contas;".
    ELSE
        IF iTipo = 0 THEN
            ASSIGN cReturn = "Rateio;".
        ELSE DO:
            IF cConta BEGINS "A‡äes"
            OR cConta BEGINS "A‡Æo" THEN DO:
                IF deValor > 0 THEN
                    ASSIGN cReturn = "Aquisi‡Æo;".
                ELSE
                    ASSIGN cReturn = "Venda;".
            END.
            ELSE DO:
                CASE iTipoConta:
                    WHEN 1 THEN DO:
                        CASE iTipo:
                            WHEN 1 THEN ASSIGN cReturn = "Dep¢sito;".
                            WHEN 4 THEN ASSIGN cReturn = "Cheque;".
                            WHEN 5 THEN ASSIGN cReturn = "Pagamento eletr“nico;".
                            WHEN 6 THEN ASSIGN cReturn = "Pagamento em dinheiro;".
                        END CASE.                                
                    END.
                    WHEN 2 THEN DO:
                        CASE iTipo:
                            WHEN 1 THEN ASSIGN cReturn = "Dep¢sito;".
                            WHEN 6 THEN ASSIGN cReturn = "Pagamento em dinheiro;".
                        END CASE.                                
                    END.
                    WHEN 3 THEN DO:
                        IF NOT lDinheiro THEN
                            CASE iTipo:
                                WHEN 2 THEN ASSIGN cReturn = "Ganho;".
                                WHEN 7 THEN ASSIGN cReturn = "Compra;".
                            END CASE.                                
                        ELSE
                            CASE iTipo:
                                WHEN 2 THEN ASSIGN cReturn = "Recebimento;".
                                WHEN 7 THEN ASSIGN cReturn = "Gasto;".
                            END CASE.                                
                    END.
                END CASE.
            END.
        END.

    RETURN cReturn.

END FUNCTION.

FUNCTION fnMovto RETURNS CHARACTER
  ( BUFFER bf-mov FOR mov-conta ) :

  IF NOT AVAIL bf-mov THEN
      RETURN "NOK".

  FIND FIRST conta OF bf-mov NO-ERROR.
  IF NOT AVAIL conta THEN RETURN "NOK".

  FIND FIRST favorecido OF bf-mov NO-ERROR.
  IF NOT AVAIL favorecido THEN RETURN "NOK".

  FIND FIRST categoria OF bf-mov NO-ERROR.
  FIND FIRST sub-cat OF bf-mov NO-ERROR.

  PUT STREAM str-mov UNFORMATTED conta.ds-conta ";"
                                 STRING(bf-mov.cd-conta) + "_" + STRING(bf-mov.cd-sequencia) ";"
                                 fnDeParaFavorecido(favorecido.ds-favorecido) ";"
                                 STRING(bf-mov.dt-mov, "99/99/9999") ";"
                                 TRIM(REPLACE(STRING(bf-mov.de-valor, "->>>>>>>>9.99"), ",", ".")) ";"
                                 fnDeParaTipoMovto(bf-mov.id-tipo, bf-mov.de-valor, conta.ds-conta, conta.id-tipo, conta.dinheiro).

  IF AVAIL sub-cat THEN
      PUT STREAM str-mov UNFORMATTED fnDeParaSubCategoria(categoria.ds-categoria, sub-cat.ds-sub) ";".
  ELSE
      PUT STREAM str-mov UNFORMATTED ";;".

  CASE bf-mov.id-situacao:
      WHEN 1 THEN PUT STREAM str-mov UNFORMATTED ";".
      WHEN 2 THEN PUT STREAM str-mov UNFORMATTED "C;".
      WHEN 3 THEN PUT STREAM str-mov UNFORMATTED "R;".
  END CASE.

  PUT STREAM str-mov UNFORMATTED bf-mov.nr-mov ";"
                                 bf-mov.usuar-resp ";".

  IF bf-mov.id-situacao > 1 THEN
      PUT STREAM str-mov UNFORMATTED STRING(bf-mov.dt-compensacao, "99/99/9999") ";".
  ELSE
      PUT STREAM str-mov UNFORMATTED ";".

  IF bf-mov.id-tipo = 3 THEN DO:

      FIND FIRST bf-conta
          WHERE bf-conta.cd-conta = bf-mov.conta-transf NO-ERROR.
      IF AVAIL bf-conta THEN DO:
          PUT STREAM str-mov UNFORMATTED bf-conta.ds-conta ";".
          IF bf-conta.cd-moeda <> bf-mov.cd-moeda THEN DO:
              FIND FIRST bf-mov-conta NO-LOCK
                  WHERE bf-mov-conta.cd-conta = bf-mov.conta-transf
                  AND   bf-mov-conta.cd-sequencia = bf-mov.seq-transf NO-ERROR.
              IF AVAIL bf-mov-conta THEN
                  PUT STREAM str-mov UNFORMATTED TRIM(REPLACE(STRING(bf-mov-conta.de-valor, "->>>>>>>>9.99"), ",", ".")) ";".
              ELSE
                  PUT STREAM str-mov UNFORMATTED ";".
          END.
          ELSE
              PUT STREAM str-mov UNFORMATTED ";".
      END.
      ELSE
          PUT STREAM str-mov UNFORMATTED ";;".

  END.
  ELSE
      PUT STREAM str-mov UNFORMATTED ";;".

  IF bf-mov.agrupado <> 0 THEN
      PUT STREAM str-mov UNFORMATTED STRING(bf-mov.cd-conta) + "_" + STRING(bf-mov.agrupado) ";".
  ELSE
      PUT STREAM str-mov UNFORMATTED ";".

  IF bf-mov.cd-agenda <> 0 THEN
      PUT STREAM str-mov UNFORMATTED TRIM(STRING(bf-mov.cd-agenda)) ";".
  ELSE
      PUT STREAM str-mov UNFORMATTED ";".

  PUT STREAM str-mov UNFORMATTED REPLACE(REPLACE(REPLACE(bf-mov.ds-observacao, CHR(10), "|||"), CHR(13), "|||"), ";", ",") SKIP.

  RETURN "OK".

END FUNCTION.
IF lMovimentos THEN DO:

    UPDATE iConta
        WITH FRAME f-conta.
    FIND FIRST conta
        WHERE conta.cd-conta = iConta NO-ERROR.
    IF AVAIL conta OR iConta = 0 THEN DO:

        IF iConta <> 0 THEN
            DISP conta.ds-conta
                WITH FRAME f-conta.
        ELSE
            DISP "Todas" @ conta.ds-conta
                WITH FRAME f-conta.

        ASSIGN dtIni = TODAY - 30
               dtFim = TODAY + 30.

        UPDATE dtIni dtFim
            WITH FRAME f-conta.

        OUTPUT STREAM str-mov TO VALUE("\\vmware-host\Shared Folders\hubner\Downloads\movimentos" + (IF iConta <> 0 THEN STRING(iConta) ELSE "") + ".csv") CONVERT TARGET "UTF-8".
        PUT STREAM str-mov UNFORMATTED "conta;identific;favorecido;data;valor;tipo;categoria;subcategoria;situacao;numero;responsavel;data_compensacao;conta_transf;valor_transf;agrupado;lembrete;observacao" SKIP.
        FOR EACH mov-conta
            WHERE mov-conta.dt-mov >= dtIni
            AND   mov-conta.dt-mov <= dtFim
            AND   (IF iConta = 0 THEN TRUE ELSE mov-conta.cd-conta = iConta)
            AND   mov-conta.agrupado = 0:

            fnMovto(BUFFER mov-conta).

            IF mov-conta.id-tipo = 0 THEN DO:
                FOR EACH bf-movto
                    WHERE bf-movto.cd-conta = mov-conta.cd-conta
                    AND   bf-movto.agrupado = mov-conta.cd-sequencia:
                    fnMovto(BUFFER bf-movto).
                END.
            END.

            IF iConta <> 0 AND mov-conta.id-tipo = 3 THEN DO:
                FIND FIRST bf-movto
                    WHERE bf-movto.cd-conta = mov-conta.conta-transf
                    AND   bf-movto.cd-sequencia = mov-conta.seq-transf.
                fnMovto(BUFFER bf-movto).
            END.

        END.
        OUTPUT STREAM str-mov CLOSE.

    END.

END.

/* CSV de Feriados */
IF lFeriados THEN DO:

    ASSIGN dtIni = DATE(1, 1, YEAR(TODAY))
           dtFim = DATE(12, 31, YEAR(TODAY)).

    UPDATE dtIni dtFim
        WITH FRAME f-feriado.

    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\feriados.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "data;nome" SKIP.
    FOR EACH feriado
        WHERE feriado.dt-feriado >= dtIni
        AND   feriado.dt-feriado <= dtFim:
        PUT UNFORMATTED STRING(feriado.dt-feriado, "99/99/9999") ";" 
                        feriado.ds-feriado SKIP.
    END.
    OUTPUT CLOSE.

END.

/* CSV de Lembretes */
IF lLembretes THEN DO:

    UPDATE lTodos
        WITH FRAME f-lembretes.

    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\lembretes.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "identific;favorecido;conta;tipo;responsavel;categoria;subcategoria;conta_transf;data_inicio;data_fim;data_ultimo_pagto;data_proximo_pagto;agrupado;valor_atualizado;dia_nao_util;adiciona_dias_uteis;meses;ocorre;quando;semanas;dia_semana;valores" SKIP.

    IF lMovtoLemb THEN DO:
        OUTPUT STREAM str-mov TO "\\vmware-host\Shared Folders\hubner\Downloads\mov-lembretes.csv" CONVERT TARGET "UTF-8".
        PUT STREAM str-mov UNFORMATTED "conta;identific;favorecido;data;valor;tipo;categoria;subcategoria;situacao;numero;responsavel;data_compensacao;conta_transf;valor_transf;agrupado;lembrete;observacao" SKIP.
    END.

    FOR EACH agenda,
        FIRST favorecido OF agenda,
        FIRST conta OF agenda:

        IF NOT lTodos THEN DO:
            IF agenda.prox-data-pag < TODAY THEN NEXT.
            IF agenda.prox-data-pag > agenda.dt-fim THEN NEXT.
        END.

        FIND FIRST categoria OF agenda NO-ERROR.
        FIND FIRST sub-cat OF agenda NO-ERROR.

        PUT UNFORMATTED STRING(agenda.cd-agenda) ";"
                        fnDeParaFavorecido(favorecido.ds-favorecido) ";"
                        conta.ds-conta ";"
                        fnDeParaTipoMovto(agenda.id-tipo, 0, conta.ds-conta, conta.id-tipo, conta.dinheiro)
                        agenda.usuar-resp ";".

        IF AVAIL sub-cat THEN
            PUT UNFORMATTED fnDeParaSubCategoria(categoria.ds-categoria, sub-cat.ds-sub) ";".
        ELSE
            PUT UNFORMATTED ";;".

        IF agenda.id-tipo = 3 THEN DO:
            FIND FIRST bf-conta
                WHERE bf-conta.cd-conta = agenda.conta-transf NO-ERROR.
            IF AVAIL bf-conta THEN
                PUT UNFORMATTED bf-conta.ds-conta ";".
            ELSE
                PUT UNFORMATTED ";".
        END.
        ELSE
            PUT UNFORMATTED ";".

        PUT UNFORMATTED STRING(agenda.dt-ini, "99/99/9999") ";"
                        STRING(agenda.dt-fim, "99/99/9999") ";"
                        STRING(agenda.dt-ultimo-pag, "99/99/9999") ";"
                        STRING(agenda.prox-data-pag, "99/99/9999") ";"
                        ";" /* Agrupado */.
        IF agenda.vl-atual <> 0 THEN 
            PUT UNFORMATTED TRIM(REPLACE(STRING(agenda.vl-atual, "->>>>>>>>9.99"), ",", ".")) ";".
        ELSE
            PUT UNFORMATTED ";".

        FIND FIRST prog-agenda OF agenda
            WHERE prog-agenda.id-tipo = 0 NO-ERROR.
        IF AVAIL prog-agenda THEN
            CASE prog-agenda.valor:
                WHEN 1 THEN PUT UNFORMATTED "Posterga;".
                WHEN 2 THEN PUT UNFORMATTED "Mant‚m;".
                WHEN 3 THEN PUT UNFORMATTED "Antecipa;".
            END CASE.
        ELSE
            PUT UNFORMATTED "Posterga;".

        FIND FIRST prog-agenda OF agenda
            WHERE prog-agenda.id-tipo = 5 NO-ERROR.
        IF AVAIL prog-agenda THEN
            PUT UNFORMATTED TRIM(STRING(prog-agenda.valor)) ";".
        ELSE
            PUT UNFORMATTED "0;".

        ASSIGN cValor = "".
        FOR EACH prog-agenda OF agenda
            WHERE prog-agenda.id-tipo = 1:
            IF prog-agenda.todos THEN DO:
                ASSIGN cValor = "Todos".
                LEAVE.
            END.
            IF prog-agenda.num-periodos > 0 THEN DO:
                ASSIGN cValor = TRIM(STRING(prog-agenda.num-periodos)).
                LEAVE.
            END.
            IF cValor = "" THEN
                ASSIGN cValor = "[".
            ELSE
                ASSIGN cValor = cValor + ",".
            ASSIGN cValor = cValor + TRIM(STRING(prog-agenda.valor)).
        END.
        IF cValor BEGINS "[" THEN
            ASSIGN cValor = cValor + "]".
        PUT UNFORMATTED cValor ";".

        IF CAN-FIND(FIRST prog-agenda OF agenda
                    WHERE prog-agenda.id-tipo = 2) THEN DO:

            PUT UNFORMATTED "Dia do Mˆs;".

            ASSIGN cValor = "".
            FOR EACH prog-agenda OF agenda
                WHERE prog-agenda.id-tipo = 2:
                IF prog-agenda.ultimo THEN DO:
                    ASSIGN cValor = "éltimo".
                    LEAVE.
                END.
                IF prog-agenda.num-periodos > 0 THEN DO:
                    ASSIGN cValor = TRIM(STRING(prog-agenda.num-periodos)).
                    LEAVE.
                END.
                IF cValor = "" THEN
                    ASSIGN cValor = "[".
                ELSE
                    ASSIGN cValor = cValor + ",".
                ASSIGN cValor = cValor + TRIM(STRING(prog-agenda.valor)).
            END.
            IF cValor BEGINS "[" THEN
                ASSIGN cValor = cValor + "]".
            PUT UNFORMATTED cValor ";;;".

        END.
        ELSE DO:

            PUT UNFORMATTED "Semanalmente;;".

            ASSIGN cValor = "".
            FOR EACH prog-agenda OF agenda
                WHERE prog-agenda.id-tipo = 3:
                IF prog-agenda.todos THEN DO:
                    ASSIGN cValor = "Todas".
                    LEAVE.
                END.
                IF prog-agenda.ultimo THEN DO:
                    ASSIGN cValor = "éltima".
                    LEAVE.
                END.
                IF cValor = "" THEN
                    ASSIGN cValor = "[".
                ELSE
                    ASSIGN cValor = cValor + ",".
                ASSIGN cValor = cValor + TRIM(STRING(prog-agenda.valor)).
            END.
            IF cValor BEGINS "[" THEN
                ASSIGN cValor = cValor + "]".
            PUT UNFORMATTED cValor ";".

            ASSIGN cValor = "".
            FOR EACH prog-agenda OF agenda
                WHERE prog-agenda.id-tipo = 4:
                IF prog-agenda.todos THEN DO:
                    ASSIGN cValor = "Todos".
                    LEAVE.
                END.
                IF cValor = "" THEN
                    ASSIGN cValor = "[".
                ELSE
                    ASSIGN cValor = cValor + ",".
                ASSIGN cValor = cValor + TRIM(STRING(prog-agenda.valor)).
            END.
            IF cValor BEGINS "[" THEN
                ASSIGN cValor = cValor + "]".
            PUT UNFORMATTED cValor ";".

        END.

        FOR EACH agenda-valor 
            WHERE agenda-valor.cd-agenda = agenda.cd-agenda:
            IF agenda-valor.dt-ini = DATE(1, 1, 0001) THEN
                PUT UNFORMATTED STRING(DATE(1, 1, 1900), "99/99/9999") ":".
            ELSE
                PUT UNFORMATTED STRING(agenda-valor.dt-ini, "99/99/9999") ":".
            PUT UNFORMATTED STRING(agenda-valor.dt-end, "99/99/9999") "#"
                            TRIM(REPLACE(STRING(agenda-valor.valor, "->>>>>>>>9.99"), ",", ".")) "|".
        END.

        PUT UNFORMATTED SKIP.

        IF lMovtoLemb THEN DO:
            FOR EACH mov-conta
                WHERE mov-conta.cd-agenda = agenda.cd-agenda:
                fnMovto(BUFFER mov-conta).
            END.
        END.

    END.

    IF lMovtoLemb THEN
        OUTPUT STREAM str-mov CLOSE.

    OUTPUT CLOSE.

END.

/* CSV de Poupan‡as */
IF lEconomias THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\economias.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "descricao;favorecido;contas" SKIP.
    FOR EACH poupanca,
        FIRST favorecido
            WHERE favorecido.cd-favorecido = poupanca.cd-fav-padrao:
        PUT UNFORMATTED poupanca.ds-poupanca ";" 
                        fnDeParaFavorecido(favorecido.ds-favorecido) ";".
        FOR EACH poup-conta
            WHERE poup-conta.cd-poupanca = poupanca.cd-poupanca,
            FIRST conta OF poup-conta:
            IF conta.cd-conta = poupanca.cd-conta THEN PUT UNFORMATTED "*".
            PUT UNFORMATTED conta.ds-conta + "|".
        END.
        PUT UNFORMATTED SKIP.
    END.
    OUTPUT CLOSE.
END.

/* CSV de Planejamento de Poupan‡as */
IF lPlanEcon THEN DO:
    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\plano_economias.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "economia;ano;valor;juros;extras" SKIP.
    FOR EACH item-poupanca,
        FIRST poupanca OF item-poupanca:
        PUT UNFORMATTED poupanca.ds-poupanca ";"
                        STRING(item-poupanca.ano, "9999") ";"
                        TRIM(REPLACE(STRING(item-poupanca.vl-deposito, "->>>>>>>>9.99"), ",", ".")) ";"
                        TRIM(REPLACE(STRING(item-poupanca.pc-juros, "->>9.99"), ",", ".")) ";".
        REPEAT iMes = 1 TO 12:
            IF item-poupanca.vl-espontaneo[iMes] <> 0 THEN DO:
                PUT UNFORMATTED STRING(iMes, "99") ":"
                                TRIM(REPLACE(STRING(item-poupanca.vl-espontaneo[iMes], "->>>>>>>>9.99"), ",", ".")) "|".
            END.
        END.
        PUT UNFORMATTED SKIP.
    END.
    OUTPUT CLOSE.
END.

DEFINE TEMP-TABLE tt-orc
    FIELD descricao AS CHAR
    FIELD ano AS INT
    FIELD local AS CHAR
    FIELD valor_mensal AS DEC
    FIELD valor_extra AS DEC EXTENT 12
    INDEX idx-pri AS PRIMARY UNIQUE descricao local.

DEFINE VARIABLE c-loc-aux AS CHARACTER   NO-UNDO.

/* CSV de Or‡amentos */
IF lOrcamentos THEN DO:
    FOR EACH item-orcamento,
        FIRST orcamento OF item-orcamento:
        ASSIGN c-loc-aux = "".
        FIND FIRST categoria OF item-orcamento NO-ERROR.
        IF AVAIL categoria THEN DO:
            FIND FIRST sub-cat OF categoria
                WHERE sub-cat.cd-sub = item-orcamento.cd-sub NO-ERROR.
            IF AVAIL sub-cat THEN
                ASSIGN c-loc-aux = fnDeParaSubCategoria(categoria.ds-categoria, sub-cat.ds-sub) + ";;".
            ELSE
                ASSIGN c-loc-aux = fnDeParaCategoria(categoria.ds-categoria) + ";GERAL;;".
        END.
        ELSE
            CASE item-orcamento.cod-categoria:
                WHEN 997 THEN DO:
                    FIND FIRST conta
                        WHERE conta.cd-conta = item-orcamento.cd-sub.
                    ASSIGN c-loc-aux = ";;" + conta.ds-conta + ";".
                END.
                WHEN 998 THEN ASSIGN c-loc-aux = "OUTRAS DESPESAS;;;".
                WHEN 999 THEN ASSIGN c-loc-aux = "OUTRAS RECEITAS;;;".
            END CASE.
        
        FIND FIRST tt-orc 
            WHERE tt-orc.descricao = orcamento.ds-orcamento
            AND   tt-orc.local = c-loc-aux NO-ERROR.
        IF NOT AVAIL tt-orc THEN DO:
            CREATE tt-orc.
            ASSIGN tt-orc.descricao = orcamento.ds-orcamento
                   tt-orc.ano = orcamento.ano
                   tt-orc.local = c-loc-aux.
        END.
        ASSIGN tt-orc.valor_mensal = tt-orc.valor_mensal + item-orcamento.vl-mes.
        REPEAT iMes = 1 TO 12:
            ASSIGN tt-orc.valor_extra[iMes] = tt-orc.valor_extra[iMes] + item-orcamento.vl-espontaneo[iMes].
        END.

    END.

    OUTPUT TO "\\vmware-host\Shared Folders\hubner\Downloads\orcamentos.csv" CONVERT TARGET "UTF-8".
    PUT UNFORMATTED "descricao;ano;categoria;subcategoria;conta;valor_mensal;extras" SKIP.
    FOR EACH tt-orc:
        PUT UNFORMATTED tt-orc.descricao ";"
                        STRING(tt-orc.ano, "9999") ";"
                        tt-orc.local
                        TRIM(REPLACE(STRING(tt-orc.valor_mensal, "->>>>>>>>9.99"), ",", ".")) ";".
        REPEAT iMes = 1 TO 12:
            IF tt-orc.valor_extra[iMes] <> 0 THEN DO:
                PUT UNFORMATTED STRING(iMes, "99") ":"
                                TRIM(REPLACE(STRING(tt-orc.valor_extra[iMes], "->>>>>>>>9.99"), ",", ".")) "|".
            END.
        END.
        PUT UNFORMATTED SKIP.
    END.
    OUTPUT CLOSE.

END.


