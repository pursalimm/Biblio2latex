% clc, clear all
% 
% apiURL = 'https://api.elsevier.com/content/search/scopus';
% apiQue = '?query=TITLE-ABS-KEY(collective cell migration)';
% apiURL = [apiURL apiQue];
% 
% apiOpt = weboptions('Timeout',inf,'HeaderFields',{'X-ELS-APIKey' 'edc2dc30410e81f4bda6e7b44cebf47b'});
% % apiOpt = weboptions('Timeout',inf,'HeaderFields',{'X-ELS-APIKey' 'edc2dc30410e81f4bda6e7b44cebf47b';'X-ELS-Insttoken' '00acade379ff169ff38aefcdd2aa580e'});
% 
% api_call = webread(apiURL, apiOpt);
% 
% docTmp = api_call.search_results.entry;
% while (length(docTmp) <= str2double(api_call.search_results.opensearch_totalResults))
%     apiURL = api_call.search_results.link(3,1).x_href;
%     api_call = webread(apiURL, apiOpt);
%     docTmp = vertcat(docTmp, api_call.search_results.entry);
% end
% docRes=docTmp(1:str2double(api_call.search_results.opensearch_totalResults), :);

clc, clear all
load('finalScopus.mat');
latexFormat(table2struct(finalScopus));