{gerapend.i}
{campos\situacao.i}
DEFINE VARIABLE cCorpoEmail AS LONGCHAR   NO-UNDO.
DEFINE VARIABLE deApont AS DECIMAL     NO-UNDO.
DEFINE VARIABLE cCor AS CHARACTER   NO-UNDO.

DEFINE BUFFER bf-fav FOR favorecido.
DEFINE BUFFER bf-ped FOR pedido.
DEFINE BUFFER bf-usu FOR usuario.
DEFINE BUFFER bf-fav-mail FOR favorecido.

FOR EACH usuario NO-LOCK
    /*WHERE usuario.nome = "Maickel"*/:
    FIND FIRST bf-fav-mail OF usuario NO-LOCK NO-ERROR.
    IF NOT AVAIL bf-fav-mail OR NOT bf-fav-mail.ativo THEN NEXT.

    output to value(session:temp-directory + "dtsemail.txt") convert target "iso8859-1".

    RUN gerapend.p (INPUT usuario.nome,
                    INPUT DATE(MONTH(TODAY), 1, YEAR(TODAY)),
                    INPUT TODAY,
                    OUTPUT TABLE tt-pend).

    PUT UNFORMATTED '<html><head><title>Relat¢rio de Pendˆncias e Projetos</title></head><body>' +
                    '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr><td width="11%"><img src="http://www.otimasis.com/marca_otima.png" width="178" height="84" alt="logo_tetra_web.jpg (3494 bytes)"></td><td width="89%"><p align="center"><big><big><big><strong><font face="Trebuchet MS">Relat¢rio de Pendˆncias e Projetos - ' + usuario.nome + '</font></strong></big></big></big></td></tr></table>' +
                    '<p><font face="Trebuchet MS" color="#F9C528"><strong>&nbsp;</strong></font></p><p><font face="Trebuchet MS" color="#F9C528"><strong>PENDÒNCIAS ATRASADAS:</strong></font></p>' +
                    '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr>' +
                    '<td width="9%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">DATA</font></small></td>' +
                    '<td width="10%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">TIPO</font></small></td>' +
                    '<td width="81%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">PENDÒNCIA</font></small></td></tr>'.

    FOR EACH tt-pend
        WHERE tt-pend.dt-pend < TODAY:
        PUT UNFORMATTED '<tr><td width="9%"><small><font face="Trebuchet MS" color="#4B4B4D">' + STRING(tt-pend.dt-pend, "99/99/9999") + '</font></small></td>' +
                        '<td width="10%"><small><font face="Trebuchet MS" color="#4B4B4D">' + tt-pend.tipo + '</font></small></td>' +
                        '<td width="81%"><small><font face="Trebuchet MS" color="#4B4B4D">' + tt-pend.ds-pend + '</font></small></td></tr>'.
    END.            
      
    PUT UNFORMATTED '</table><p><font face="Trebuchet MS" color="#F9C528"><strong>&nbsp;</strong></font></p><p><font face="Trebuchet MS" color="#F9C528"><strong>PENDÒNCIAS DE HOJE:</strong></font></p>' +
                    '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr>' +
                    '<td width="9%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">DATA</font></small></td>' +
                    '<td width="10%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">TIPO</font></small></td>' +
                    '<td width="81%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">PENDÒNCIA</font></small></td></tr>'.


    FOR EACH tt-pend
        WHERE tt-pend.dt-pend = TODAY:
        PUT UNFORMATTED '<tr><td width="9%"><small><font face="Trebuchet MS" color="#4B4B4D">' + STRING(tt-pend.dt-pend, "99/99/9999") + '</font></small></td>' +
                        '<td width="10%"><small><font face="Trebuchet MS" color="#4B4B4D">' + tt-pend.tipo + '</font></small></td>' +
                        '<td width="81%"><small><font face="Trebuchet MS" color="#4B4B4D">' + tt-pend.ds-pend + '</font></small></td></tr>'.
    END.            

    PUT UNFORMATTED '</table><p>&nbsp;</p><p><font face="Trebuchet MS" color="#F9C528"><strong>MEUS PROJETOS:</strong></font></p>'.

    FOR EACH pedido NO-LOCK
        WHERE pedido.situacao < 3
        AND   pedido.dt-pedido < TODAY
        AND   pedido.responsavel = usuario.nome
        AND  (pedido.dt-previsao-fat <> ?
        OR   CAN-FIND(FIRST bf-ped
                      WHERE bf-ped.nr-pedido-ant = pedido.nr-pedido) /* NÆo Fechado */):

        FIND FIRST bf-fav OF pedido NO-LOCK NO-ERROR.
        FIND FIRST ordem-serv OF pedido NO-LOCK
            WHERE  ordem-serv.situacao < 8 NO-ERROR.
        IF NOT AVAIL ordem-serv THEN NEXT.

        IF NOT CAN-FIND(FIRST tarefa OF ordem-serv NO-LOCK
                        WHERE tarefa.data-prev-ini <= TODAY
                        OR    tarefa.dt-real-ini <= TODAY) THEN NEXT.

        PUT UNFORMATTED '<p><font face="Trebuchet MS" color="#000000"><strong>' + STRING(pedido.nr-pedido) + ' - ' + bf-fav.ds-favorecido + ' - ' + pedido.nom-projeto + '</strong></font></p>' +
                        '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr>' +
                        '<td width="29%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">TAREFA</font></small></td>' +
                        '<td width="5%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">RESPONSµVEL</font></small></td>' +
                        '<td width="7%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">SITUA€ÇO</font></small></td>' +
                        '<td width="4%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">HORAS</font></small></td>' +
                        '<td width="4%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">APONT</font></small></td>' +
                        '<td width="4%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">% CONC</font></small></td>' +
                        '<td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA PREV INI</font></small></td>' +
                        '<td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA PREV FIM</font></small></td>' +
                        '<td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA REAL INI</font></small></td>' +
                        '<td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA REAL FIM</font></small></td></tr>'.

        FOR EACH tarefa OF ordem-serv NO-LOCK
            /*WHERE tarefa.dt-plan-ini <= TODAY
            OR    tarefa.dt-real-ini <= TODAY*/:

            ASSIGN deApont = 0.
            FOR EACH apontamento NO-LOCK
                WHERE apontamento.nome-tarefa = tarefa.nome
                AND   apontamento.seq-tarefa = tarefa.sequencia:
                ASSIGN deApont = deApont + apontamento.qt-apont.
            END.

            ASSIGN cCor = ' color="#4B4B4D"'.
            IF tarefa.situacao < 8 THEN DO:
                IF (tarefa.dt-plan-fim <= TODAY
                OR tarefa.data-prev-fim <= TODAY) THEN
                    ASSIGN cCor = ' color="#FF0000"'.
                IF (tarefa.dt-plan-ini <= TODAY OR tarefa.data-prev-ini <= TODAY) AND tarefa.situacao = 1 THEN
                    ASSIGN cCor = ' color="#FF0000"'.
            END.

            PUT UNFORMATTED '<tr>
                                <td width="29%"><small><font face="Trebuchet MS"' + cCor + '>' + tarefa.ds-tarefa + '</font></small></td>
                                <td width="5%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + tarefa.responsavel + '</font></small></td>
                                <td width="7%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + fnSituacaoTarefa(tarefa.situacao) + '</font></small></td>
                                <td width="4%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + STRING(tarefa.qtd-lib, ">>9.99") + '</font></small></td>
                                <td width="4%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + STRING(deApont, ">>9.99") + '</font></small></td>
                                <td width="4%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + STRING(tarefa.perc-con, ">>9.99") + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-plan-ini <> ? THEN STRING(tarefa.dt-plan-ini, "99/99/9999") ELSE STRING(tarefa.data-prev-ini, "99/99/9999")) + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-plan-fim <> ? THEN STRING(tarefa.dt-plan-fim, "99/99/9999") ELSE STRING(tarefa.data-prev-fim, "99/99/9999")) + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-real-ini <> ? THEN STRING(tarefa.dt-real-ini, "99/99/9999") ELSE "") + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-real-fim <> ? THEN STRING(tarefa.dt-real-fim, "99/99/9999") ELSE "") + '</font></small></td>
                              </tr>'.

        END.

        PUT UNFORMATTED '</table>'.

    END.

    PUT UNFORMATTED '<p>&nbsp;</p><p><font face="Trebuchet MS" color="#F9C528"><strong>MINHA EQUIPE:</strong></font></p>'.

    FOR EACH ordem-serv NO-LOCK
        WHERE ordem-serv.nome = usuario.nome
        AND   ordem-serv.dt-os <= TODAY
        AND   ordem-serv.situacao < 8:

        FIND FIRST bf-fav OF ordem-serv NO-LOCK NO-ERROR.

        PUT UNFORMATTED '<p><font face="Trebuchet MS" color="#000000"><strong>' + STRING(ordem-serv.num-os) + ' - ' + bf-fav.ds-favorecido + ' - ' + ordem-serv.ds-os + '</strong></font></p>
                            <table border="0" width="100%" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="29%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">TAREFA</font></small></td>
                                <td width="5%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">RESPONSµVEL</font></small></td>
                                <td width="7%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">SITUA€ÇO</font></small></td>
                                <td width="4%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">HORAS</font></small></td>
                                <td width="4%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">APONT</font></small></td>
                                <td width="4%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">% CONC</font></small></td>
                                <td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA PREV INI</font></small></td>
                                <td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA PREV FIM</font></small></td>
                                <td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA REAL INI</font></small></td>
                                <td width="6%" bgcolor="#F9C528" align="center"><small><font face="Trebuchet MS" color="#000000">DATA REAL FIM</font></small></td>
                              </tr>'.            

        FOR EACH tarefa OF ordem-serv NO-LOCK
            WHERE (tarefa.dt-plan-ini <= TODAY
            OR    tarefa.data-prev-ini <= TODAY
            OR    tarefa.dt-real-ini <= TODAY)
            AND   tarefa.situacao < 9:

            IF tarefa.situacao = 8 AND tarefa.dt-real-fim < (TODAY - 3) THEN NEXT.

            ASSIGN deApont = 0.
            FOR EACH apontamento NO-LOCK
                WHERE apontamento.nome-tarefa = tarefa.nome
                AND   apontamento.seq-tarefa = tarefa.sequencia:
                ASSIGN deApont = deApont + apontamento.qt-apont.
            END.

            ASSIGN cCor = ' color="#4B4B4D"'.
            IF tarefa.situacao < 8 THEN DO:
                IF (tarefa.dt-plan-fim <= TODAY
                OR  tarefa.data-prev-fim <= TODAY) THEN
                    ASSIGN cCor = ' color="#FF0000"'.
                IF (tarefa.dt-plan-ini <= TODAY OR tarefa.data-prev-ini <= TODAY) AND tarefa.situacao = 1 THEN
                    ASSIGN cCor = ' color="#FF0000"'.
            END.

            PUT UNFORMATTED '<tr>
                                <td width="29%"><small><font face="Trebuchet MS"' + cCor + '>' + tarefa.ds-tarefa + '</font></small></td>
                                <td width="5%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + tarefa.responsavel + '</font></small></td>
                                <td width="7%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + fnSituacaoTarefa(tarefa.situacao) + '</font></small></td>
                                <td width="4%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + STRING(tarefa.qtd-lib, ">>9.99") + '</font></small></td>
                                <td width="4%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + STRING(deApont, ">>9.99") + '</font></small></td>
                                <td width="4%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + STRING(tarefa.perc-con, ">>9.99") + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-plan-ini <> ? THEN STRING(tarefa.dt-plan-ini, "99/99/9999") ELSE STRING(tarefa.data-prev-ini, "99/99/9999")) + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-plan-fim <> ? THEN STRING(tarefa.dt-plan-fim, "99/99/9999") ELSE STRING(tarefa.data-prev-fim, "99/99/9999")) + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-real-ini <> ? THEN STRING(tarefa.dt-real-ini, "99/99/9999") ELSE "") + '</font></small></td>
                                <td width="6%" align="center"><small><font face="Trebuchet MS"' + cCor + '>' + (IF tarefa.dt-real-fim <> ? THEN STRING(tarefa.dt-real-fim, "99/99/9999") ELSE "") + '</font></small></td>
                              </tr>'.

        END.

        PUT UNFORMATTED '</table>'.
            
    END.
    
    IF usuario.nome = "Maickel" THEN DO:

        FOR EACH bf-usu NO-LOCK
            WHERE bf-usu.nome <> usuario.nome,
            FIRST favorecido OF bf-usu
                WHERE favorecido.ativo:

            RUN gerapend.p (INPUT bf-usu.nome,
                            INPUT DATE(MONTH(TODAY), 1, YEAR(TODAY)),
                            INPUT TODAY,
                            OUTPUT TABLE tt-pend).


            PUT UNFORMATTED '</table><p><font face="Trebuchet MS" color="#F9C528"><strong>&nbsp;</strong></font></p><p><font face="Trebuchet MS" color="#F9C528"><strong>PENDÒNCIAS DE ' + bf-usu.nome + ':</strong></font></p>' +
                            '<table border="0" width="100%" cellspacing="0" cellpadding="0"><tr>' +
                            '<td width="9%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">DATA</font></small></td>' +
                            '<td width="10%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">TIPO</font></small></td>' +
                            '<td width="81%" bgcolor="#F9C528"><small><font face="Trebuchet MS" color="#000000">PENDÒNCIA</font></small></td></tr>'.

            FOR EACH tt-pend
                WHERE tt-pend.dt-pend < TODAY:
                PUT UNFORMATTED '<tr><td width="9%"><small><font face="Trebuchet MS" color="#4B4B4D">' + STRING(tt-pend.dt-pend, "99/99/9999") + '</font></small></td>' +
                                '<td width="10%"><small><font face="Trebuchet MS" color="#4B4B4D">' + tt-pend.tipo + '</font></small></td>' +
                                '<td width="81%"><small><font face="Trebuchet MS" color="#4B4B4D">' + tt-pend.ds-pend + '</font></small></td></tr>'.
            END.            

            PUT UNFORMATTED '</table>'.

        END.

    END.
    
    PUT UNFORMATTED '</body></html>'.

    output close.

    IF bf-fav-mail.e-mail <> "" THEN
        RUN pi-blat (INPUT bf-fav-mail.e-mail).

END.

PROCEDURE pi-blat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT  PARAMETER cDest AS CHARACTER FORMAT "X(40)"  NO-UNDO.

    DEFINE VARIABLE v-cod-lin-comando AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE destinatario AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE remetente AS CHARACTER  NO-UNDO.

    ASSIGN destinatario = TRIM(cDest)
           remetente = "maickel@otimasis.com".

     assign destinatario = replace(destinatario,chr(10),",")       
            destinatario = replace(destinatario,";",",")
            remetente = replace(remetente,chr(10),",")       
            remetente = replace(remetente,";",",").

    assign v-cod-lin-comando = "blat.exe"
                               + " "
                               + "~"" + session:temp-directory + "dtsemail.txt" + "~""
                               + " -s" 
                               + ' "' 
                               + "Relat¢rio de Pendˆncias e Projetos - " + STRING(TODAY, "99/99/9999") 
                               + '"' 
                               + " -t " 
                               + destinatario 
                               + " -server " 
                               + "~"127.0.0.1:1099~""
                               /*+ " -port " 
                               + "587"*/
                               + " -f "
                               + remetente
                               + " -u " 
                               + "maickel@otimasis.com"
                               + " -pw " 
                               + "otima@123"
                               + " -mime"
                               + " -q"
                               + " -noh"
                               + " -noh2".

    assign v-cod-lin-comando = v-cod-lin-comando + " -html ".           
    /*file-info:file-name = SEARCH(cArquivo).
    assign v-cod-lin-comando = v-cod-lin-comando + " -attach ~"" + FILE-INFO:FULL-PATHNAME + "~"".*/

    output to value(session:temp-directory + "dtsemail.bat") convert target "IBM850".
    put unformatted "CD C:\Compartilhadas\Sistema\MHMoney" CHR(10) v-cod-lin-comando " -debug".
    OUTPUT CLOSE.
    dos SILENT value("~"" + session:temp-directory + "dtsemail.bat" + "~"").

    /*os-delete value(session:temp-directory + "dtsemail.txt").
    os-delete value(session:temp-directory + "dtsemail.bat").*/

    return "OK".

END PROCEDURE.
