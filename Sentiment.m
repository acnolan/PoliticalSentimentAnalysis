%% Sources
% https://www.mathworks.com/help/textanalytics/ug/sentiment-analysis-in-matlab.html
% https://www.mathworks.com/help/textanalytics/ref/ratiosentimentscores.html
% BERT model

%% DNC Sentiment
dnc_filename = "harris_dnc.txt";
dnc_text = fileread(dnc_filename);
disp(strcat("Word count: ", num2str(numel(strsplit(dnc_text)))))
dnc_sentences = splitSentences(dnc_text);
disp(strcat("Sentence count: ", num2str(numel(dnc_sentences))))
dnc_tokens = tokenizedDocument(dnc_sentences);
dnc_sentiment_vader = vaderSentimentScores(dnc_tokens);
dnc_sentiment_ratio = ratioSentimentScores(dnc_tokens);
disp(strcat("Average DNC vader sentiment: ", num2str(mean(dnc_sentiment_vader))));
disp(strcat("Average DNC vader sentiment: ", num2str(mean(dnc_sentiment_ratio))));


%% RNC Sentiment
rnc_filename = "trump_rnc.txt";
rnc_text = fileread(rnc_filename);
rnc_sentences = splitSentences(rnc_text);
rnc_tokens = tokenizedDocument(rnc_sentences);
rnc_sentiment_vader = vaderSentimentScores(rnc_tokens);
rnc_sentiment_ratio = ratioSentimentScores(rnc_tokens);
disp(strcat("Average RNC vader sentiment: ", num2str(mean(rnc_sentiment_vader))));
disp(strcat("Average RNC vader sentiment: ", num2str(mean(rnc_sentiment_ratio))));
