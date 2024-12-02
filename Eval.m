classdef Eval
    methods(Static)
	% Note that the hand needs to be sorted
	function sorted = sortHand(hand)
	    [arr, ind] = sort(hand(1, :));
	    sorted = hand(:, ind);
	end
	function flush = isFlush(hand)
	    flush = all(hand(2, :) == hand(2, 1))
	end
	%function four = isQuad(hand)
	%    mode_val = string(mode(categorical(hand(1, :))));
	%    four = sum(hand(1, :) == mode_val) >= 4;
	%end
	function mult = multiplicity(hand)
	    mode_val = string(mode(categorical(hand(1, :))));
	    mult = sum(hand(1, :) == mode_val)
	end
	function straight = isStraight(hand)
	    num_arr = str2double(hand(1, :));
	    m = min(num_arr);
	    straight = all([m:m+4] == num_arr);
	end
	function highest = high(hand)
	    highest = str2double(hand(1, end)) 
	end
	function full = isFull(hand) 
	    v = hand(1, :);
	    u = unique(v);
	    if length(u) ~= 2
		full = false;
		return
	    end
	    full = ((sum(v == u(1)) == 3) && (sum(v == u(2)) == 2)) || ((sum(v == u(1)) == 2) && (sum(v == u(2)) == 3));
	end
	function twopair = isTwopair(hand)
	    twopair = sum(histc(str2double(hand(1, :)), [1:14]) == 2) == 2;
	end
	function sflush = isSflush(hand)
	    sflush = Eval.isFlush(hand) && Eval.isStraight(hand);
	end
	function rflush = isRflush(hand)
	    rflush = Eval.isSflush(hand) && Eval.high(hand) == 14;
	end
	function winner = evaluate(hand1)
	    hand1 = Eval.sortHand(hand1);

	    % rough calculation to meet basic requirments.
	    winner = 0;
	    h = Eval.high(hand1)
	    m = Eval.multiplicity(hand1);

	    winner = winner + h;

	    winner = winner + (m == 2) * 15;
	    
	    winner = winner + (Eval.isTwopair(hand1)) * 15^2;

	    winner = winner + (m == 3) * 15^3;

	    winner = winner + Eval.isStraight(hand1) * 15^4;

	    winner = winner + Eval.isFlush(hand1) * 15^5;

	    winner = winner + Eval.isFull(hand1) * 15^6;

	    
	    winner = winner + (m == 4) * 15^7;

	    winner = winner + Eval.isSflush(hand1) * 15^8;

	    winner = winner + Eval.isRflush(hand1) * 15^9;
	end
    end
end

    
