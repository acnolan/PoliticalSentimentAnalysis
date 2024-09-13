% https://www.mathworks.com/help/matlab/ref/wordcloud.html
dnc_filename = "harris_dnc.txt";
dnc_text = fileread(dnc_filename);

punctuationCharacters = ["." "?" "!" "," ";" ":"];
dnc_text = replace(dnc_text,punctuationCharacters," ");
words = split(join(dnc_text));
words(strlength(words)<5) = []; % Do we want to remove short words?
words = lower(words);

C = categorical(words);
figure
wordcloud(C);
title("DNC Word Cloud")