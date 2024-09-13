function [] = emotion_display(text, speaker, color)
    %EMOTION_DISPLAY - Generate a histogram of emotions in text
    %   Takes in a vector of tokenized text and categorizes it based on the
    %   National Research Council Canada (NRC) emotion lexicon
    %   https://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm
    
    % Read the NRC data
    nrcTable = readtable('NRC-Emotion-Lexicon-Wordlevel-v0.92.txt', 'Delimiter', '\t', 'ReadVariableNames', false);
    nrcTable.Properties.VariableNames = {'Word', 'Emotion', 'Association'};

    % Preprocess the text
    tokens = tokenizedDocument(strjoin(text));
    words = lower(string(tokens)); % Get the words in lowercase

    % Create a table to hold emotion scores
    emotionCategories = unique(nrcTable.Emotion);
    emotionCategories(strcmp(emotionCategories, 'positive') | strcmp(emotionCategories, 'negative')) = []; % remove the sentiment so we just have the emotions
    emotionScores = zeros(1, numel(emotionCategories));

    % Loop through each word in the document
    for i = 1:numel(words)
        % Find if the word exists in the lexicon and is associated with an emotion
        matches = strcmp(nrcTable.Word, words(i));
        if any(matches)
            % Loop through each emotion
            for j = 1:numel(emotionCategories)
                % For each matching word, accumulate its emotion score
                isEmotion = strcmp(nrcTable.Emotion(matches), emotionCategories{j});
                emotionScores(j) = emotionScores(j) + sum(nrcTable.Association(matches) & isEmotion);
            end
        end
    end
    
    % Display the emotion scores
    emotionTable = table(emotionCategories, emotionScores', 'VariableNames', {'Emotion', 'Score'});
    disp(emotionTable);
    
    % Plot the emotion scores
    figure;
    bar(emotionScores/sum(emotionScores), "FaceColor", color);
    set(gca, 'xticklabel', emotionCategories);
    title(strcat("Emotion Analysis of ", speaker, "'s Statements"));
    xlabel('Emotions');
    ylabel('Percent of speech');
end