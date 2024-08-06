program PPI_Quiz;
uses crt, sysutils;
var

showpc, showiff                                 : boolean;

selnvl, selmat                                  : shortint;
arrscore                                        : array of integer;
nvlchk                                          : array of boolean;
mat                                             : array of string;
i, j, k, l, m                                   : integer;
opc                                             : char;
qtdnvl, qtdmat, qtdtotques, qtdalt              : integer;
qtdquesmat                                      : array of integer;
invnvl                                          : array of integer;
nmin                                            : array of integer;
configchk                                       : boolean;
configtxt, quiztxt, savetxt                     : textfile;
txtname, quizname, ver, ini, verify, savelink   : string;
numtxt                                          : integer;
score, selques                                  : integer;
ordques                                         : array of integer;
booques                                         : array of boolean;
questxt                                         : array of string;
alttxt                                          : array of string;
resptxt                                         : array of char;

procedure artiff;
begin
    if showiff=true then
    begin
        writeln('');
        textcolor(red); write('   @@@@@@ '); textcolor(green); writeln('  mmmmmmmm  mmmmmmmm');
        textcolor(red); write('  @@@@@@@@'); textcolor(green); writeln('  mmmmmmmm  mmmmmmmm');
        textcolor(red); write('  @@@@@@@@'); textcolor(green); writeln('  mmmmmmmm  mmmmmmmm');
        textcolor(red); write('  @@@@@@@@'); textcolor(green); writeln('  mmmmmmmm  mmmmmmmm');
        textcolor(red); write('   @@@@@@ '); textcolor(green); writeln('  mmmmmmmm  mmmmmmmm');
        writeln();
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln();
        writeln('  mmmmmmmm  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm  mmmmmmmm');
        writeln();
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('  mmmmmmmm  mmmmmmmm');
        writeln('');
        textcolor(white);
    end;
end;

procedure artpc;
begin
    if showpc=true then
    begin
        clrscr;
        writeln('           #############################################################################################');
        writeln('           ##                                                                                         ##');
        writeln('           ##      #############################################################################      ##');
        writeln('           ##      #############################################################################      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      ##                                                                         ##      ##');
        writeln('           ##      #############################################################################      ##');
        writeln('           ##      #############################################################################      ##');
        writeln('           ##                                                                                         ##');
        writeln('           ##                                                                               | |       ##');
        writeln('           ##                                                                                         ##');
        writeln('           #############################################################################################');
        gotoxy(94, 27); textcolor(red); writeln('O'); readkey();
        gotoxy(94, 27); textcolor(green); writeln('I'); delay(1000);
        window(24,6,93,22);
        textcolor(green); gotoxy(33,8); writeln('QuizOS'); gotoxy(19,9); writeln('---------------------------------'); gotoxy(32, 10); writeln('Booting...'); delay(2500); clrscr;
        textcolor(white);
    end;
end;

procedure loadconfig;
begin
    assign(configtxt, 'config.txt');
    reset(configtxt);
    while not eof(configtxt) do
    begin
        readln(configtxt, ver);
        readln(configtxt, txtname);
        readln(configtxt, savelink);
        readln(configtxt, opc); if opc='V' then showiff:=true else showiff:=false;
        readln(configtxt, opc); if opc='V' then showpc:=true else showpc:=false;
    end;
    if ver = '' then begin writeln('O config.txt esta vazio ou danificado. Va em config.txt e resete-o.'); readkey(); configchk:=false; end
    else if ver <> 'V1.0' then begin writeln('Carregado. Mas a versao do config.txt e diferente da do programa, se desejar resete-o para atualizar. Aperte qualquer tecla para continuar.'); readkey(); configchk:=true; end
    else if ver = 'V1.0' then configchk:=true else configchk:=false;
    close(configtxt);
end;

procedure loadquiz;
begin
    assign(quiztxt, txtname);
    reset(quiztxt);
        readln(quiztxt, quizname);
        readln(quiztxt, qtdnvl);
        if qtdnvl = 0 then qtdnvl:=1;
        readln(quiztxt, qtdmat);
        if qtdmat = 0 then qtdmat:=1;
        readln(quiztxt, qtdalt);
        setlength(arrscore, qtdnvl*qtdmat+2);
        setlength(nvlchk, qtdnvl);
        setlength(invnvl, qtdnvl);
        setlength(nmin, qtdnvl-1);
        setlength(mat, qtdmat);
        setlength(qtdquesmat, qtdmat*qtdnvl);
        setlength(alttxt, qtdnvl*qtdmat*qtdalt);
        if ((qtdnvl > 1) and (qtdmat > 1)) then
        begin
            for i:=0 to qtdmat-1 do readln(quiztxt, mat[i]);
            for i:=0 to qtdnvl*qtdmat-1 do readln(quiztxt, qtdquesmat[i]);
        end else if qtdnvl > 1 then for i:=0 to qtdnvl-1 do readln(quiztxt, qtdquesmat[i]) else if qtdmat > 1 then begin
                                                                                                                for i:=0 to qtdmat-1 do readln(quiztxt, mat[i]);
                                                                                                                for i:=0 to qtdmat-1 do readln(quiztxt, qtdquesmat[i]);
                                                                                                            end;
        readln(quiztxt, qtdtotques);
        if qtdnvl > 1 then for i:=0 to qtdnvl-2 do readln(quiztxt, nmin[i]);
        setlength(questxt, qtdtotques);
        setlength(alttxt, qtdalt*qtdtotques);
        setlength(resptxt, qtdtotques);
        setlength(ordques, qtdmat*qtdnvl);
        for i:=0 to qtdtotques-1 do
        begin
            readln(quiztxt, questxt[i]);
            for j:=0 to qtdalt-1 do readln(quiztxt, alttxt[((i+1)*qtdalt-qtdalt-1)+j+1]);
            readln(quiztxt, resptxt[i]);
        end;
        for i:=0 to (qtdmat*qtdnvl)-1 do ordques[i]:=i+1;
    close(quiztxt);
    for i:=0 to qtdnvl*qtdmat+1 do arrscore[i]:=0;
end;

procedure quizcreate;
begin
    repeat
        clrscr;
        writeln('Ferramenta de criacao de quiz:');
        writeln('Se desejar quiz simples, digite 0 ou 1 na quantidade de niveis e topicos.');
        writeln('Se desejar quiz com niveis mas sem topicos e vice versa, apenas insira os valores desejados normalmente.');
        writeln('Em caso de quiz grande, ou com texto copiado de outro lugar, recomendo pular as alternativas e bota-las no txt depois, desde que respeitada a formatacao do arquivo.');
        readkey();
        clrscr;
        write('Digite o nome do quiz:');
        readln(quizname);
        writeln('Digite o nome do arquivo do quiz: (nome.txt)');
        readln(txtname);
        write('Digite a quantidade de niveis:');
        readln(qtdnvl);
        write('Digite a quantidade de topicos:');
        readln(qtdmat);
        write('Digite a quantidade de alternativas por questao:');
        readln(qtdalt);
        writeln('Confirmar formato do quiz? (S/N)');
        readln(opc);
        if ((opc = 'S') or (opc = 's')) then
        begin
            clrscr;
            qtdtotques:=0;
            assign(quiztxt, txtname);
            rewrite(quiztxt);
                writeln(quiztxt, quizname);
                writeln(quiztxt, qtdnvl);
                writeln(quiztxt, qtdmat);
                writeln(quiztxt, qtdalt);
                if qtdmat > 1 then
                begin
                    setlength(mat, qtdmat);
                    setlength(qtdquesmat, qtdmat);
                    for i:=0 to qtdmat-1 do begin
                                                writeln('Digite o topico ',i+1,':');
                                                readln(mat[i]);
                                                writeln(quiztxt, mat[i]);
                                            end;
                    if qtdnvl > 1 then
                    begin
                        qtdtotques:=0;
                        for i:=0 to qtdnvl-1 do begin
                            clrscr;
                            for j:=0 to qtdmat-1 do begin
                                                        write('Digite a quantidade de questoes do topico ',mat[j],', Nivel ',i+1,': ');
                                                        readln(qtdquesmat[j]);
                                                        qtdtotques:=qtdtotques+qtdquesmat[j];
                                                        writeln(quiztxt, qtdquesmat[j]);
                                                    end;
                                                end;
                    end else
                    begin
                        clrscr;
                        qtdtotques:=0;
                        for j:=0 to qtdmat-1 do begin
                            write('Digite a quantidade de questoes do topico ',mat[j],': ');
                            readln(qtdquesmat[j]);
                            qtdtotques:=qtdtotques+qtdquesmat[j];
                            writeln(quiztxt, qtdquesmat[j]);
                                            end;
                    end;
                end else if qtdnvl > 1 then
                begin
                    qtdtotques:=0;
                    for i:=0 to qtdnvl-1 do begin
                                                write('Digite a quantidade de questoes do nivel ',i+1,': ');
                                                readln(qtdquesmat[i]);
                                                writeln(quiztxt, qtdquesmat[i]);
                                                qtdtotques:=qtdtotques+qtdquesmat[i];
                                            end;
                end else begin
                            writeln('Quantas questoes deseja ter no seu quiz?');
                            readln(qtdtotques);
                        end;
                setlength(questxt, qtdtotques);
                setlength(alttxt, qtdtotques*qtdalt);
                setlength(resptxt, qtdtotques);
                writeln(quiztxt, qtdtotques);
                if qtdnvl > 1 then
                begin
                    setlength(nmin, qtdnvl);
                    for i:=0 to qtdnvl-2 do begin
                                                write('Digite a quantidade minima de questoes acertadas do nivel ',i+1,' para avancar ao nivel ',i+2,': ');
                                                readln(nmin[i]);
                                        end;
                end;
                for i:=0 to qtdtotques-1 do
                begin
                    clrscr;
                    writeln('Cole a questao ',i+1,':');
                    readln(questxt[i]);
                    writeln(quiztxt, questxt[i]);
                    for j:=0 to qtdalt-1 do
                    begin
                        writeln('Cole a alternativa ',j+1,':');
                        readln(alttxt[j]);
                        writeln(quiztxt, alttxt[j]);
                    end;
                    write('Indique a resposta correta:(1-',qtdalt,'): ');
                    readln(resptxt[i]);
                    writeln(quiztxt, resptxt[i]);
                end;
            close(quiztxt);
        end;
        writeln('Quiz criado com sucesso.');
        writeln('Quiz com ',qtdtotques,' questoes.');
        writeln('Para carrega-lo, use o nome "',txtname,'".');
        readkey();
        writeln('Voltar a "Criar Quiz"? (S/N)');
        readln(opc);
    until ((opc <> 'S') and (opc <> 's'));
end;

procedure perquizload;
begin
    clrscr;
    writeln('Digite o nome do arquivo do quiz personalizado + txt. ex: quizppersonalizado.txt');
    write('Nome do arquivo: ');
    readln(txtname);
    writeln('Definir esse quiz como quiz padrao? (S/N)');
    readln(opc);
    if ((opc = 'S') or (opc ='s')) then begin
                                            assign(configtxt, 'config.txt');
                                            rewrite(configtxt);
                                                writeln(configtxt, 'V1.0');
                                                writeln(configtxt, txtname);
                                            close(configtxt);
                                            writeln('Carregado.');
                                            writeln('O quiz ',txtname,' foi definido como padrao.');
                                        end else writeln('Carregado. Volte o programa do inicio, nao o reinicie.');
end;

procedure configreset;
begin
    writeln('AVISO: Isso vai resetar as configuracoes padrao do programa.');
    writeln('O arquivo "config.txt", vai ser reescrito, reseta-lo? (S/N)');
    readln(opc);
    if ((opc = 'S') or (opc = 's')) then
        begin
            rewrite(configtxt);
                writeln(configtxt, 'V1.0');
                writeln(configtxt, 'qoriginal.txt');
                writeln(configtxt, 'qoriginalsave.txt');
                writeln(configtxt, 'V');
                writeln(configtxt, 'V');
            close(configtxt);
            writeln('O config.txt foi resetado.');
        end else writeln('Arquivo nao foi modificado. Reinicie o programa.');
end;

procedure salvar;
begin
    loadquiz;
    clrscr;
    if showpc=false then artiff;
    writeln('Criar um save novo (N), salvar em um existente (E) ou salvar no save padrao (P)? (N/E/P)');
    readln(opc);
    if ((opc='N') or (opc='n')) then
    begin
        clrscr;
        artiff;
        writeln('O arquivo novo sera para o quiz ',quizname,'.');
        write('Digite o nome do arquivo salvo (nomedoarquivo.txt): ');
        readln(savelink);
        write('Digite seu nome/iniciais: ');
        readln(ini);
        write('Salvar o progresso? (S/N): ');
        readln(opc);
        if ((opc = 'S') or (opc = 's')) then
        begin
            assign(savetxt, savelink);
            rewrite(savetxt);
                writeln(savetxt, ini);
                writeln(savetxt, ver);
                writeln(savetxt, txtname);
                writeln(savetxt, numtxt);
                for i:=0 to qtdnvl*qtdmat do writeln(savetxt, arrscore[i]);
            close(savetxt);
            writeln('Save criado.');
        end;
    end else if (((opc='E') or (opc='e')) or ((opc='P') or (opc='p'))) then
    begin
        clrscr;
        if ((opc='E') or (opc='e')) then
        begin
            artiff;
            write('Salvar o progresso no save ',savelink,'? (S/N): ');
            readln(opc);
        end else if ((opc='P') or (opc='p')) then opc:='S';
        if ((opc = 'S') or (opc = 's')) then
        begin
            assign(savetxt, savelink);
            rewrite(savetxt);
                writeln(savetxt, ini);
                writeln(savetxt, ver);
                writeln(savetxt, txtname);
                writeln(savetxt, numtxt);
                arrscore[qtdnvl*qtdmat]:=0;
                for i:=0 to qtdnvl*qtdmat-1 do arrscore[qtdnvl*qtdmat]:=arrscore[qtdnvl*qtdmat]+arrscore[i];
                for i:=0 to qtdnvl*qtdmat do writeln(savetxt, arrscore[i]);
            close(savetxt);
            writeln('Salvo.');
        end else writeln('Se quiser outro save, va em saves e carregue o arquivo salvo desejado.');
    end;
end;

procedure setsave;
begin
    writeln('Digite o nome do save: (nomesave.txt)');
    readln(savelink);
    writeln('Definir esse save como padrao? (S/N)');
    readln(opc);
    if ((opc = 'S') or (opc ='s')) then begin
                                            assign(configtxt, 'config.txt');
                                            rewrite(configtxt);
                                                writeln(configtxt, 'V1.0');
                                                writeln(configtxt, txtname);
                                                writeln(configtxt, savelink);
                                                if showiff=true then opc:='V' else opc:='F';
                                                writeln(configtxt, opc);
                                                if showpc=true then opc:='V' else opc:='F';
                                                writeln(configtxt, opc);
                                            close(configtxt);
                                            writeln('Carregado.');
                                            writeln('O save ',savelink,' foi definido como padrao.');
                                        end else writeln('Carregado. Volte o programa do inicio, nao o reinicie.');
end;

procedure carrsv;
begin
    assign(savetxt, savelink);
    reset(savetxt);
        readln(savetxt, ini);
        readln(savetxt, verify);
        if verify = ver then
        begin
            readln(savetxt, verify);
            if verify = txtname then
            begin
                readln(savetxt, numtxt);
                for i:=0 to qtdnvl*qtdmat+1 do readln(savetxt, arrscore[i]);
            end else begin writeln('O save carregado nao corresponde ao quiz carregado. Carregue o quiz ',txtname,'.'); readkey(); end;
        end else begin writeln('Versao do arquivo salvo e do programa incompativeis. Tente mudar a segunda linha do arquivo salvo para "',ver,'" e teste se ha compatibilidade.'); readkey(); end;
    close(savetxt);
end;

procedure mosprog;
begin
    loadquiz;
    carrsv;
    clrscr;
    if showpc=false then artiff;
    writeln('Progresso do jogador ',ini,', no quiz "',quizname,'":');
    for i:=0 to qtdnvl*qtdmat-1 do writeln(arrscore[i]);
    arrscore[qtdnvl*qtdmat]:=0;
    for i:=0 to qtdnvl*qtdmat-1 do arrscore[qtdnvl*qtdmat]:=arrscore[qtdnvl*qtdmat]+arrscore[i];
    writeln('No total: ',arrscore[qtdnvl*qtdmat]);
    readkey();
end;

procedure advnvl;
begin
    if opc = 'N' then
    begin
        m:=0;
        for i:=1 to qtdmat do m:=m+arrscore[selnvl*qtdmat-i];
        if ((qtdnvl > 1) and (m > nmin[selnvl-1])) then
        begin
            textcolor(green);
            writeln('Parabens! Voce passou para o proximo nivel.');
            numtxt:=selnvl+1;
            textcolor(white);
            readkey();
        end;
    end;
end;

procedure progrequiz;
begin
    clrscr;
    if showpc=false then artiff;
    loadquiz;
    carrsv;
    if numtxt > 1 then m:=numtxt else m:=1;
    for i:=0 to m-1 do nvlchk[i]:=true;
    repeat
        clrscr;
        artiff;
        writeln(' ',quizname);
        if qtdnvl > 1 then
        begin
            writeln('|==============|');
            for i:=0 to qtdnvl-1 do begin write(' NIVEL ',i+1,' - '); if nvlchk[i] = true then writeln('V') else writeln('X'); end;
            writeln('|==============|');
            write('Digite o numero do nivel desejado: ');
            readln(selnvl);
        end else selnvl:=1;
        if (((nvlchk[selnvl-1] = true) and (selnvl > 0)) or (qtdnvl <= 1)) then
        begin
            repeat
                opc:='N';
                clrscr;
                if showpc=false then artiff;
                if qtdmat > 1 then
                begin
                    writeln('         ',quizname);
                    if qtdnvl > 1 then writeln('       Questoes Nivel ',selnvl,': ');
                    writeln('|==============================|');
                    for j:=0 to qtdmat-1 do writeln(' ',j+1,' - ',mat[j],' ');
                    writeln('|==============================|');
                    write('Digite o numero do topico desejado: ');
                    readln(selmat);
                end else begin
                            writeln('Comecar Quiz? (S/N)');
                            readln(opc);
                            if ((opc <> 'S') and (opc <> 's')) then break;
                            selmat:=1;
                        end;
                if (((selmat > 0) and (selmat <= qtdmat)) or ((opc = 'S') or (opc ='s'))) then
                begin
                    m:=1;
                    score:=0;
                    clrscr;
                    if qtdmat > 1 then writeln(mat[selmat-1]);
                    for i:=0 to qtdnvl-1 do invnvl[i]:=qtdnvl-i-1;
                    l:=selmat*qtdnvl-invnvl[selnvl-1]-1;
                    if l=0 then l:=1;
                    for i:=0 to l-1 do m:=m+qtdquesmat[i];
                    if l=1 then m:=m-qtdquesmat[0];
                    if length(qtdquesmat)=1 then begin l:=1; m:=1; qtdquesmat[0]:=qtdtotques end;
                    for i:=0 to qtdquesmat[l-1]-1 do
                    begin
                        clrscr;
                        artiff;
                        selques:=m+i;
                        writeln(questxt[selques-1]);
                        for j:=0 to qtdalt-1 do writeln(j+1,' - ',alttxt[(selques*qtdalt-qtdalt)+j]);
                        writeln('Indique a alternativa correta:');
                        readln(opc);
                        if opc = resptxt[selques-1] then begin
                                                    score:=score+1;
                                                    textcolor(green);
                                                    writeln('Correto.');
                                                        end else begin
                                                                    textcolor(red);
                                                                    writeln('Incorreto.');
                                                                end;
                        textcolor(white);
                        readkey();
                        writeln('Voce acertou ',score,' questoes de ',qtdquesmat[l-1],'.');
                    end;
                    if arrscore[l-1] < score then arrscore[l-1]:=score;
                    opc:='N';
                    advnvl;
                    writeln('Salvar essa nota no ',savelink,'?');
                    readln(opc);
                    if ((opc='S') or (opc='s')) then
                    begin
                        assign(savetxt, savelink);
                        rewrite(savetxt);
                            writeln(savetxt, ini);
                            writeln(savetxt, ver);
                            writeln(savetxt, txtname);
                            writeln(savetxt, numtxt);
                            for i:=0 to qtdnvl*qtdmat do writeln(savetxt, arrscore[i]);
                        close(savetxt);
                    end;
                end else writeln('Opcao Invalida.');
                writeln('Deseja voltar a selecao de topicos? (S/N)');
                readln(opc);
            until ((opc <> 'S') and (opc <> 's'));
        end else writeln('Opcao invalida ou nivel bloqueado.');
    until ((opc <> 'S') and (opc <> 's'));
end;

procedure randomquiz;
begin
    loadquiz;
    clrscr;
    if showpc=false then artiff;
    writeln('Modo aleatorio.');
    writeln('Quantas questoes deseja fazer? (1-',qtdtotques,')');
    readln(m);
    writeln('Comecar? (S/N)');
    readln(opc);
    if ((opc = 'S') or (opc = 's')) then
    begin
        score:=0;
        randomize;
        if ((m < 1) or (m > qtdtotques)) then writeln('Valor invalido.') else
        begin
            setlength(ordques, m);
            setlength(booques, qtdtotques);
            for i:=0 to length(booques)-1 do booques[i]:= false;
            for i:=0 to m-1 do
            begin
                j:=0;
                clrscr;
                repeat
                    ordques[i]:=random(qtdtotques);
                    selques:=ordques[i];
                    if booques[selques-1] = false then begin
                                                        booques[selques-1]:=true;
                                                        j:=j+1;
                                                    end;
                until j=1;
                writeln(questxt[selques-1]);
                for k:=0 to qtdalt-1 do writeln(k+1,' - ',alttxt[(selques*qtdalt-qtdalt)+k]);
                writeln('Indique o numero da alternativa correta:');
                readln(opc);
                if opc = resptxt[selques-1] then begin
                                                score:=score+1;
                                                textcolor(green);
                                                writeln('Correto.');
                                            end else begin
                                                        textcolor(red);
                                                        writeln('Incorreto.');
                                                    end;
                textcolor(white);
                readkey();
            end;
            writeln('Voce acertou ',score,' de ',m,' questoes.');
        end;
    end;
end;

begin
    loadconfig;
    artpc;
    repeat
        clrscr;
        if showpc=false then artiff;
        writeln('|==============================|');
        writeln('| 1 - Modo Progressao          |');
        writeln('| 2 - Modo Aleatorio           |');
        writeln('| 3 - Saves                    |');
        writeln('| 4 - Criacao e Config.        |');
        writeln('| 5 - Informacoes              |');
        writeln('|==============================|');
        write('Digite o numero da opcao desejada: ');
        readln(opc);
        case opc of
        '1' : progrequiz;
        '2' : randomquiz;
        '3' : begin
                clrscr;
                if showpc=false then artiff;
                writeln('|==============================|');
                writeln('| 1 - Salvar / Criar Save      |');
                writeln('| 2 - Carregar Arquivo Salvo   |');
                writeln('| 3 - Mostrar Progresso        |');
                writeln('|==============================|');
                write('Digite o numero da opcao desejada: ');
                readln(opc);
                case opc of
                    '1' : salvar;
                    '2' : setsave;
                    '3' : mosprog;
                end
            end;
        '4' : begin
                repeat
                    clrscr;
                    if showpc=false then artiff;
                    if configchk = true then writeln('config.txt carregado.') else writeln('config.txt nao carregado.');
                    writeln('|==============================|');
                    writeln('| 1 - Criar Quiz               |');
                    writeln('| 2 - Carregar Quiz            |');
                    writeln('| 3 - Resetar Configuracoes    |');
                    write('| 4 - Logo IFFAR - '); if showiff=true then writeln('V           |') else writeln('F           |');
                    write('| 5 - Anim. PC -  '); if showpc=true then writeln('V            |') else writeln('F            |');
                    writeln('|==============================|');
                    write('Digite o numero da opcao desejada: ');
                    readln(opc);
                    case opc of
                        '1' : quizcreate;
                        '2' : perquizload;
                        '3' : configreset;
                        '4' : begin
                                if showiff=true then showiff:=false else showiff:=true;
                                assign(configtxt, 'config.txt');
                                rewrite(configtxt);
                                    writeln(configtxt, ver);
                                    writeln(configtxt, txtname);
                                    writeln(configtxt, savelink);
                                    if showiff=true then opc:='V' else opc:='F';
                                    writeln(configtxt, opc);
                                    if showpc=true then opc:='V' else opc:='F';
                                    writeln(configtxt, opc);
                                close(configtxt);
                            end;
                        '5' : begin
                                if showpc=true then showpc:=false else showpc:=true;
                                assign(configtxt, 'config.txt');
                                rewrite(configtxt);
                                    writeln(configtxt, ver);
                                    writeln(configtxt, txtname);
                                    writeln(configtxt, savelink);
                                    if showiff=true then opc:='V' else opc:='F';
                                    writeln(configtxt, opc);
                                    if showpc=true then opc:='V' else opc:='F';
                                    writeln(configtxt, opc);
                                close(configtxt);
                            end;
                    end;
                    writeln('Repetir "Criacao e Config"? (S/N)');
                    readln(opc);
                until ((opc <> 'S') and (opc <> 's'));
                end;
        '5' : begin
            clrscr;
            if showpc=false then artiff;
            writeln('Versao: 1.0');
            writeln('Como usar:');
            writeln('No modo progresso do quiz original, o usuario vai de nivel a nivel de cada materia, totalizando 60 questoes, 15 cada materia, 5 cada nivel de materia.');
            writeln('O progresso pode ser salvo em um arquivo de texto e ao solicitar o progresso, mostra os dados da progressao, mostrando sempre as maiores notas.');
            writeln('No modo aleatorio infinito as questoes vem aleatoriamente, nao se repetindo a cada jogada.');
            writeln('');
            writeln('Sobre o trabalho:');
            writeln('Programa de questionarios, com funcoes basicas de criacao e sistema de saves.');
            writeln('Trabalho de PPI do Campus Iffar Santo Augusto, feito por Heloisa Santi, Joao Schmitt e Julia Battaioli.');
        end else writeln('Opcao invalida.');
        end;
    writeln('Repetir do inicio? (S/N)');
    readln(opc);
    until ((opc <> 'S') and (opc <> 's'));
    if showpc=true then begin
                            clrscr;
                            window(94,27,94,27);
                            textcolor(red);
                            writeln('O');
                            delay(1500);
                            clrscr;
                        end;
end.