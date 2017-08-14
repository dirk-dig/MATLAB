MT = MarkovTransition();
seqLen = 1000;
numSeq = 1000;
seq = zeros(seqLen, numSeq);
states = {'sunny' 'cloudy' 'rainy'};
count_last_entry_of_seq = zeros(3, 1);
count_seq_occurances = zeros(3, 1);

for i=1:numSeq
    seq(:,i) = MT.generateStateSequence(seqLen);
end

for i=1:numSeq
   if seq(seqLen,i) == 1
       count_last_entry_of_seq(1,1) = count_last_entry_of_seq(1,1) + 1;
   end
   if seq(seqLen,i) == 2
       count_last_entry_of_seq(2,1) = count_last_entry_of_seq(2,1) + 1;
   end
   if seq(seqLen,i) == 3
       count_last_entry_of_seq(3,1) = count_last_entry_of_seq(3,1) + 1;
   end
end

for i=1:seqLen
   if seq(i,1) == 1
       count_seq_occurances(1,1) = count_seq_occurances(1,1) + 1;
   end
   if seq(i,1) == 2
       count_seq_occurances(2,1) = count_seq_occurances(2,1) + 1;
   end
   if seq(i,1) == 3
       count_seq_occurances(3,1) = count_seq_occurances(3,1) + 1;
   end
end