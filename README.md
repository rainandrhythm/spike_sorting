# spike_sorting
PCA and K-means clustering for unsupervised neural spike sorting and evaluation of clustering sensitivity.

**Overview**

This project explores unsupervised spike sorting using Principal Component Analysis (PCA) and K-means clustering. The goal is to separate neural spike waveforms into distinct putative neuronal populations based on their waveform characteristics.

**Methods**

PCA: Spike waveforms were projected onto the first two principal components to reduce dimensionality while preserving major sources of variation.

K-means clustering: The PCA-transformed waveforms were clustered into putative spike populations.

Cluster evaluation: Clustering was evaluated across different numbers of clusters (k) and across multiple initializations to assess the sensitivity and stability of the method.

Visualization: Cluster assignments, centroids, and Voronoi decision boundaries were visualized in PCA space.

**Results**

Sensitivity to Number of Clusters

The clustering method was evaluated for different values of k.

k < 3: Distinct spike populations were merged.

k = 3: Cluster assignments most closely corresponded to the underlying spike populations.

k > 3: Individual spike populations were fragmented into multiple clusters.

Sensitivity to Initialization

With k = 3, different initial centroid locations produced different cluster boundaries, particularly where spike populations overlapped. However, when the underlying clusters were well separated, most runs recovered the three expected populations.

The iterative clustering visualization also demonstrated convergence toward stable cluster assignments when initialization was reasonable.

**Conclusion**

The results demonstrate that PCA combined with K-means can effectively separate distinct spike populations when the number of clusters matches the underlying data structure. However, performance is sensitive to both cluster number and initialization, highlighting important limitations of basic K-means for spike sorting.

**Data Availability**

The waveform dataset was provided separately for the project and is not included in this repository.
