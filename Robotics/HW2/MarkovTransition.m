classdef MarkovTransition
    %MARKOVTRANSITION Summary of this class goes here
    %   Detailed explanation goes here 
    
    properties
        states = {'sunny' 'cloudy' 'rainy'};
        state_ids = [1 2 3];
        transition_table = [0.8 0.2   0;
                            0.4 0.4 0.2;
                            0.2 0.6 0.2];
        cumulative_transition_table = [0.8 1.0 0.0;
                                       0.4 0.8 1.0;
                                       0.2 0.8 1.0];
    end
    
    methods
        
        function MT = MarkovTransition()
            
        end
        
        function seq_num = generateStateSequence( MT, sequenceNum )
            
            randomNum = rand(sequenceNum,1);
            % First state chosen at random from all possible states
            % with equal probability
            seq_num(1,1) = floor(randomNum(1,1)*length(MT.states))+1;
            % Remainder of states chosen with respect to the transition
            % table
            % For each day in the sequence
            for i=2:sequenceNum
               % For each possibility for the next state
               for j=1:size(MT.cumulative_transition_table(3,:),2)
                  % If the day's probability is less than 
                  current_cumulative_transition_table = MT.cumulative_transition_table(seq_num(i-1,1),j);
                  if randomNum(i,1) < MT.cumulative_transition_table(seq_num(i-1,1),j)
                      seq_num(i,1) = j;
                      break; 
                  end
               end
            end
        end
        
        function [seq_num,seq_desc] = generateStateSequenceViaMatrix( MT, sequenceNum )
            X = repmat(1/length(MT.states), length(MT.states), 1);
            for i = 1:sequenceNum
                X = MT.transition_table' * X;
                [seq_num(i,1), seq_desc(i,1)] = sample(X, MT.states);
            end
        end
        
        function [state_desc, stable_dist] = generateStableDist( MT, sequenceNum )
            [seq_num, seq_disc] = MT.generateStateSequenceViaMatrix( sequenceNum );
            X_accum = zeros(1,3);
            for i=1:sequenceNum
                for j=1:length(MT.state_ids)
                    if seq_num(i,1) == MT.state_ids(1,j)
                        X_accum(1,j) = X_accum(1,j) + 1;
                    end
                end
            end
            stable_dist = X_accum / sequenceNum;
            state_desc = MT.states;
        end
    end
    
end