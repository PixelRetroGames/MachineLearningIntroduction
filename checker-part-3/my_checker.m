function [sq] = my_checker()
    sq = [];
    for i = 1 : 254
        i
        sq = [sq helper_check_prediction('RGB', i)]; 
        size(sq)  
        fflush(stdout)
    end
end