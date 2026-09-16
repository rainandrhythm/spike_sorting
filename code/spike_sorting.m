close all 
clear

%% Parameters

% Max iterations for k means
max_iterations = 100; 
% Subplot K means for the number of clusters
max_cluster_number = 5;  
% Number of runs for k
number_of_runs = 9;               

% load data 
load('waveforms.mat');
% PCA 
[coeff, score] = pca(waveforms);
% projecting the data onto the first two principal components
waveforms_pca = score(:, 1:2);
% run clustering with k=3 clusters 
[idx, c, history] = k_means_g(waveforms_pca, 3, max_iterations);

num_iterations = length(history.centroids);
ncols = ceil(sqrt(num_iterations));
nrows = ceil(num_iterations / ncols);

%% Figure 1: cluster assignments for each iteration

figure;

for i = 1:num_iterations
    subplot(nrows, ncols, i); 
    hold on;

    centroids_i = history.centroids{i};
    idx_i = history.assignments{i};

    % Plot points colored by cluster
    gscatter(waveforms_pca(:,1), waveforms_pca(:,2), idx_i);

    % Plot centroids
    plot(centroids_i(:,1), centroids_i(:,2), 'kx', 'LineWidth', 1.5, 'MarkerSize', 5);

    % voronoi tessellation placement
    voronoi(centroids_i(:,1), centroids_i(:,2));

    % graphical elements
    if i ==1
        title('Initialization');
    else
        title(['Step ' num2str(i-1)]);
    end
    xlabel('PCA 1')
    ylabel('PCA 2')
    axis equal;
    axis tight;
    grid on;
end

sgtitle('Figure 1: K-means Clustering Evolution');


%% Figure 2: K-mean for different k clusters and subplot them- assess sensitivity for different k values 

n_cols = ceil(sqrt(max_cluster_number));
n_rows = ceil(max_cluster_number / n_cols);

figure;
for i = 1:max_cluster_number
    [idx, c, history] = k_means_g(waveforms_pca, i+1, max_iterations);
    subplot(n_rows, n_cols, i);
    gscatter(waveforms_pca(:, 1), waveforms_pca(:, 2), idx);
    hold on 
    plot(c(:,1), c(:, 2), 'kx');
    % do not create tessallation for the first plot (i), because this is
    % when k=2, and that breaks voronoi
    if i > 1
        voronoi(c(:,1), c(:, 2));
    end

    % graphical elements 
    title(['k= ' num2str(i+1)]);
    xlabel('PC 1')
    ylabel('PC 2')
    axis tight;

end

sgtitle('Figure 2: K-means Clustering for Different K-means')

%% Figure 3: K-mean for same k clusters and subplot multiple runs- assess sensitivity for k initial clusters 

% create the layout for my new subplots
n_cols_2 = ceil(sqrt(number_of_runs));
n_rows_2 = ceil(number_of_runs / n_cols_2);

figure;

for i = 1:number_of_runs
    [idx, c, history] = k_means_g(waveforms_pca, 3, max_iterations);
    subplot(n_rows_2, n_cols_2, i);
    gscatter(waveforms_pca(:, 1), waveforms_pca(:, 2), idx);
    hold on 
    plot(c(:,1), c(:, 2), 'kx');
    voronoi(c(:,1), c(:, 2));

    % graphical elements 
    title(['run ' num2str(i)]);
    xlabel('PC 1')
    ylabel('PC 2')
    axis tight;

end

sgtitle('Figure 3: K-means Clustering for k=3 at Different Initializations')
