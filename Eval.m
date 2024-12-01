classdef Eval
    methods(Static)
	function flush = isFlush(hand)
	    flush = all(hand(2, :) == hand(2, 1))
	end
	function four = isFour(hand)
	    mode_val = string(mode(categorical(hand(1, :))));
	    four = sum(hand(1, :) == mode_val) >= 4;
	end
	function straight = isStraight(hand)
	    num_arr = str2double(hand(1, :));
	    m = min(num_arr);
	    straight = all([m:m+4] == num_arr);
	end
    end
end

    
