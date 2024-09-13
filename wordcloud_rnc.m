% https://www.mathworks.com/help/matlab/ref/wordcloud.html
rnc_filename = "trump_rnc.txt";
rnc_text = fileread(rnc_filename);
wordcloud(rnc_text); % With text analyics toolbox

% Without text analytics toolbox
punctuationCharacters = ["." "?" "!" "," ";" ":"];
rnc_text = replace(rnc_text,punctuationCharacters," ");
words = split(join(rnc_text));
words(strlength(words)<5) = []; % Do we want to remove short words?
words = lower(words);

C = categorical(words);
figure
wordcloud(C);
title("RNC Word Cloud")