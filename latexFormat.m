function [latexOut] = latexFormat(finalScopus)
    article = struct('jid',{},'title',{},'author',{},'journal',{},'volume',{},'number',{},'pages',{},'year',{},'citedby_count',{});
    conference = struct('cid',{},'title',{},'author',{},'booktitle',{},'year',{},'address',{},'month',{},'citedby_count',{});
    incollection = struct('inid',{},'title',{},'author',{},'booktitle',{},'editor',{},'publisher',{},'address',{},'year',{},'pages',{},'isbn',{},'chapter',{},'citedby_count',{});
   
    ar = 1; cp = 1; ch = 1;
    for i = 1 : height(finalScopus)
        strAuthor = strrep(strrep(strrep(strrep(strrep(finalScopus(i).Authors,',',';'),'; ',';'),' ',', '),'.','. '),';','and ');
        if strcmp(string(finalScopus(i).DocumentType),  'Article')
            article(ar) = struct('jid',append('Jour', num2str(ar,'%03.f')),...
                'title',finalScopus(i).Title,'author',strAuthor,...
                'journal',finalScopus(i).Journals,'volume',finalScopus(i).Volume,...
                'number',finalScopus(i).Issue,'pages',finalScopus(i).Pages,...
                'year',finalScopus(i).Year,'citedby_count',finalScopus(i).CitedBy);
            ar = ar + 1;
        end
        if strcmp(string(finalScopus(i).DocumentType), 'Conference Paper')
            confMonth = month(datetime(finalScopus(i).ConferenceDate), 'name');
            conference(cp) = struct('cid',append('Conf', num2str(cp,'%03.f')),...
                'title',finalScopus(i).Title,'author',strAuthor,...
                'booktitle','In proceedings of '+finalScopus(i).ConferenceName,'year',finalScopus(i).Year,...
                'address',finalScopus(i).ConferenceLocation,'month',confMonth,'citedby_count',finalScopus(i).CitedBy);
            cp = cp + 1;
        end
        if strcmp(string(finalScopus(i).DocumentType), 'Book Chapter')
            incollection(ch) = struct('inid',append('Chap', num2str(ch,'%03.f')),...
                'title',finalScopus(i).Title,'author',strAuthor,...
                'booktitle',finalScopus(i).Booktitle,'editor',finalScopus(i).Editors,...
                'publisher',finalScopus(i).Publisher,'address',finalScopus(i).Bookaddress,...
                'year',finalScopus(i).Year,'pages',finalScopus(i).Pages,...
                'isbn',finalScopus(i).ISBN,'chapter',finalScopus(i).Chapters,...
                'citedby_count',finalScopus(i).CitedBy);
            ch = ch + 1;
        end
    end
    
    fileID = fopen('latexArticle_out.txt','wt');
    formatSpec = '@article{%s,\n title={%s},\n author={%s},\n journal={%s},\n volume={%s},\n number={%s},\n pages={%s},\n year={%s}\n}\ncitation=%s\n\n';
    for i = 1 : length(article)
        fprintf(fileID, formatSpec, article(i).jid...
                        ,article(i).title, article(i).author...
                        ,article(i).journal, article(i).volume...
                        ,article(i).number, article(i).pages...
                        ,article(i).year, article(i).citedby_count);
    end
    fclose(fileID);
    
    fileID = fopen('latexConference_out.txt','wt');
    formatSpec = '@conference{%s,\n title={%s},\n author={%s},\n booktitle={%s},\n year={%s},\n address={%s},\n month={%s}\n}\ncitation=%s\n\n';
    for i = 1 : length(conference)
        fprintf(fileID, formatSpec, conference(i).cid...
                        ,conference(i).title, conference(i).author...
                        ,conference(i).booktitle, conference(i).year...
                        ,conference(i).address, conference(i).month...
                        ,conference(i).citedby_count);
    end
    fclose(fileID);

    fileID = fopen('latexChapter_out.txt','wt');
    formatSpec = '@incollection{%s,\n title={%s},\n author={%s},\n booktitle={%s},\n editor={%s},\n publisher={%s},\n address={%s},\n year={%s},\n pages={%s},\n isbn={%s},\n chapter={%s}\n}\ncitation=%s\n\n';
    for i = 1 : length(incollection)
        fprintf(fileID, formatSpec, incollection(i).inid...
                        ,incollection(i).title, incollection(i).author...
                        ,incollection(i).booktitle, incollection(i).editor...
                        ,incollection(i).publisher, incollection(i).address...
                        ,incollection(i).year, incollection(i).pages...
                        ,incollection(i).isbn, incollection(i).chapter...
                        ,incollection(i).citedby_count);
    end
    fclose(fileID);
end
