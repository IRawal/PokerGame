classdef Deck
    properties
	deck = []
	cards = []
    end
    methods
	function obj = Deck(obj)
	    for num = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"] 
		for suit = ["S", "C", "H", "D"]
		    obj.cards = [obj.cards [num; suit]];
		end
	    end
	    obj.deck = [1:52];
	end
	function obj = shuffled(obj)
	    obj.deck = randperm(52);
	end
	function [card, obj] = deal(obj)
	    top = obj.deck(1);
	    obj.deck = obj.deck(2:end);
	    card = [obj.cards(2 * top - 1), obj.cards(2 * top)];
	end
    end
end

