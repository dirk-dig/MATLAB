% Tim Bailey's MatLab Utilities
% Version 3.3, March, 2011.
%
% http://www-personal.acfr.usyd.edu.au/tbailey/
%
% chi_square_bound      - Compute the n-degree-of-freedom chi-squared bound for a given probability of acceptance
% chi_square_density    - Evaluate an n-degree-of-freedom chi-squared probability density function
% chi_square_mass       - Evaluate an n-degree-of-freedom chi-squared probability mass function
% chi_square_to_gauss   - Convert a chi-squared bound to a Gaussian likelihood
% covariance_intersection - Fuse two Gaussians using the CI algorithm 
% demo_bearing_only     - Demonstrate bearing-only tracking with EKF, UKF, and particle filter
% demo_chi_square       - Demonstrate chi-square functions
% demo_ekf_filter       - Demonstrate extended Kalman filter (EKF) functions
% demo_kmeans           - Demonstrate k-means clustering algorithm
% demo_particle_filter  - Demonstrate particle filter functions
% demo_unscented_filter - Demonstrate unscented Kalman filter (UKF) functions
% dist_sqr              - Compute the squared distance between two sets of vectors (version 1)
% dist_sqr_             - Compute the squared distance between two sets of vectors (version 2)
% distance_bhattacharyya - Compute Bhattacharyya distance between two Gaussians
% distance_KLD          - Compute Kullback-Leibler distance between two Gaussians
% distance_KLD_symmetric - Compute symmetric Kullback-Leibler distance between two Gaussians
% distance_mahalanobis  - Compute Mahalanobis distance between two Gaussians
% distance_normalised   - Compute normalised distance between two Gaussians
% ekf_update            - Perform extended Kalman update with numerical-approximate observation Jacobian, H
% ellipse_mass          - Compute ellipsoid bound about N% probability mass of a 2-D Gaussian 
% ellipse_sigma         - Compute the n-sigma ellipse of a 2-D Gaussian (same as sigma_ellipse)
% force_symmetry        - Make a square matrix symmetric by averaging off-diagonal terms
% gauss_entropy         - Compute the distribution entropy of a Gaussian
% gauss_evaluate        - Evaluate a Gaussian pointwise (same as gauss_likelihood)
% gauss_mutual_information - Compute the mutual information between two portions of a multivariate Gaussian 
% gauss_power           - Raise a Gaussian to a positive real power
% gauss_regularise      - Produce a set of regularised samples jittered according to a Gaussian kernel
% gauss_samples         - Produce a set of samples from a specified multivariate Gaussian density
% index_table           - Vectorise a set of indices into a hyper-dimensional matrix for fast access
% inv_posdef            - Compute the inverse of a positive-definite matrix (numerically stable)
% inv_pseudo            - Compute the Moore-Penrose pseudo-inverse of a matrix
% inv_triu              - Compute inverse of a triangular matrix
% kf_update             - Perform a Kalman filter update (recommended form)
% kf_update_iekf        - Perform an iterated extended Kalman filter (IEKF) update
% kmeans                - Perform k-means clustering 
% line_plot_conversion  - Convert a set of lines to a representation suitable for fast animation
% linearised_transform  - Transform a Gaussian via a nonlinear model according to an arbitrary tangent point
% linearised_update     - Perform an EKF update with model linearisation about an arbitrary tangent point
% numerical_Jacobian_i  - Approximate the Jacobian matrix for a non-linear model using central differencing
% pi_to_pi              - Normalise a set of angles to within +/- pi bounds
% repcol                - Replicate a column-vector
% reprow                - Replicate a row-vector
% sample_mean           - Compute the mean and variance of a set of samples
% sample_mean_weighted  - Compute the mean and variance of a set of weighted samples
% sqrt_posdef           - Compute square-root of a positive definite matrix
% stratified_random     - Generate an ordered set of stratified uniform-random numbers
% stratified_resample   - Perform resampling of weighted particles
% transform_posdef      - Compute Q = F*P*F', where P is symmetric positive definite
% transform_to_global   - Transform a set of 2-D points or poses to a global coordinate frame
% transform_to_relative - Transform a set of 2-D points or poses to a local coordinate frame
% uniform_random        - Generate an ordered set of uniform-random numbers
% unscented_transform   - Perform an unscented transform of a Gaussian density function through a nonlinear function
% unscented_update      - Perform an unscented Kalman filter (UKF) update
%
% Deprecated functions (obsolete and may be removed from future releases)
%
% assert                - Invariant checking function
% gauss_likelihood      - Compute the likelihoods for a set of Gaussian innovations
% kf_update_cholesky    - Perform a Kalman filter update using Cholesky factored implementation (numerically stable)
% kf_update_joseph      - Perform a Joseph-form Kalman filter update (ensures symmetry and positive definiteness)
% kf_update_joseph_modified - As for kf_update_joseph, but modified to improve numerics
% kf_update_simple      - Perform a Kalman filter update (basic implementation)
% multivariate_gauss    - Same as gauss_samples
% numerical_Jacobian    - Approximate the Jacobian matrix for a non-linear model, forward differencing
% numerical_Jacobian_cd - Approximate the Jacobian matrix for a non-linear model, central differencing
% repvec                - Replicate a column-vector (same as repcol)
% sigma_ellipse         - Compute the n-sigma ellipse of a 2-D mean and covariance matrix
