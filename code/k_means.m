function [idx, c, history] = k_means_g(x, k, max_i)

    [num_points, num_dim] = size(x);

    rng('shuffle');               
    c = x(randperm(num_points,k),:);
    idx = zeros(num_points,1);

    history.centroids = {}; % cell array to store centroid positions  
    history.assignments = {}; % cell array to store assignments
    
    history.centroids = {c};
    history.assignments = {idx};
    
    for i = 1:max_i
        
        % assign points to nearest centroid
        for j = 1:num_points
            distances = sum((c - x(j,:)).^2, 2);
            [~, idx(j)] = min(distances);
        end

        % update centroids
        c_new = zeros(k, num_dim);

        % recompute cluster centers by calculating average positions 
        for a = 1:k
            points_in_cluster = x(idx == a, :);
            if isempty(points_in_cluster)
                c_new(a,:) = x(randi(num_points), :); 
            else
                c_new(a,:) = mean(points_in_cluster,1);
            end
        end

        % check for convergence
        if isequal(c_new, c)
            c = c_new;
            break;
        end

        c = c_new;

        history.centroids{end+1} = c_new;
        history.assignments{end+1} = idx;

    end
end
