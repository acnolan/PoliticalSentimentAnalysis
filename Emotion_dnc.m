% Step 1: Load the lexicon into MATLAB
% Assume 'nrc_lexicon.txt' is a tab-separated file where the first column is
% the word, the second is the emotion (e.g., 'joy', 'sadness'), and the third is
% the association (0 or 1).

nrcTable = readtable('NRC-Emotion-Lexicon-Wordlevel-v0.92.txt', 'Delimiter', '\t', 'ReadVariableNames', false);
nrcTable.Properties.VariableNames = {'Word', 'Emotion', 'Association'};

% Step 2: Read the speech transcript
fileName = 'harris_dnc.txt'; % Change this to your file path
speechText = fileread(fileName);

% Tokenize the speech text
document = tokenizedDocument(speechText);
words = lower(string(document)); % Get the words in lowercase

% Step 3: Analyze the emotions for each word in the document
% Create a table to hold emotion scores
emotionCategories = unique(nrcTable.Emotion);
emotionScores = zeros(1, numel(emotionCategories));

% Loop through each word in the document
for i = 1:numel(words)
    % Find if the word exists in the lexicon and is associated with an emotion
    matches = strcmp(nrcTable.Word, words(i));
    if any(matches)
        % For each emotion
        for j = 1:numel(emotionCategories)
            % For each matching word, accumulate its emotion score
            isEmotion = strcmp(nrcTable.Emotion(matches), emotionCategories{j});
            emotionScores(j) = emotionScores(j) + sum(nrcTable.Association(matches) & isEmotion);
        end
    end
end

% Step 4: Display the emotion scores
emotionTable = table(emotionCategories, emotionScores', 'VariableNames', {'Emotion', 'Score'});
disp(emotionTable);

% Optionally, plot the emotion scores
figure;
bar(emotionScores);
set(gca, 'xticklabel', emotionCategories);
title('Emotion Analysis of Speech');
xlabel('Emotions');
ylabel('Scores');
