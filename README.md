<<<<<<< HEAD
# Reference routines for laser-induced shock-wave velocity analysis

This repository contains three calculations with explicitly specified numerical conventions, together with synthetic tests that fix those conventions:

- constrained axis-aligned ellipse fitting of shock-front contours (cross term fixed to zero, real positive semiaxes only);
- fixed-origin ray–ellipse intersection, which returns directional displacement from the laser-interaction point rather than from the fitted ellipse centre;
- covariance-aware uncertainty of the ratio between paired independent acquisitions.

Each routine is written for MATLAB R2024a and is self-contained. The synthetic test script generates reference cases and prints the expected values next to the computed ones.

Scope: wavefront segmentation and contour screening, the hybrid displacement model and the nested-validation, permutation and bootstrap procedures operate on the recorded image sets; their inputs and outputs are supplied in the Supporting Information (Figs. S7–S25, S28; Tables S1–S9), and their procedures are specified there in Sections 6, 10, 11 and 12. This repository covers the three calculations listed above; the data-dependent processing procedures are described in the Supporting Information.

## Contents

- `fit_axis_aligned_front.m`: constrained axis-aligned ellipse fit.
- `ray_ellipse_distance.m`: fixed-origin forward ray–ellipse intersection.
- `ratio_uncertainty.m`: covariance-aware ratio standard uncertainty.
- `test_basic_functions.m`: synthetic numerical and invalid-input tests.
=======
# Basic laser-shock analysis routines

Standalone MATLAB R2024a reference functions for three calculation steps:

- `fit_axis_aligned_front`: least-squares fit of an axis-aligned ellipse to an already extracted contour.
- `ray_ellipse_distance`: forward intersection of rays from a fixed origin with the fitted ellipse.
- `ratio_uncertainty`: delta-method standard error for a ratio of paired independent-unit means.
>>>>>>> origin/main

## Run the checks

Open MATLAB R2024a, set the current folder to this directory, and run:

```matlab
test_basic_functions
```

The checks use synthetic coordinates and paired values. They verify known ellipse geometry, vectorized ray intersections, the ratio-uncertainty calculation, and representative invalid-input cases. They do not load experimental data or reproduce manuscript results.

## Scope and input conventions

Ellipse coordinates must be finite real vectors in one shared spatial unit, with at least five contour points. The fitted ellipse is axis-aligned; image segmentation, coordinate calibration, contour screening and rotated-ellipse fitting are outside this function's scope.

Angles are in radians, measured counterclockwise from the positive x-axis of the supplied coordinate system. The origin and ellipse must use the same coordinate frame. The routine returns the nonnegative forward intersection along each ray; callers must map image axes and the experimental zero direction before use.

For `ratio_uncertainty`, each paired row represents one independent acquisition unit. The output is the ratio of the two sample means and its first-order delta-method standard error. Recombined or repeated rows from one acquisition unit must not be treated as independent units.

<<<<<<< HEAD
## License

MIT. See [LICENSE](LICENSE) for the reuse terms.
=======
These routines do not constitute the full image-segmentation, hybrid-fitting, model-selection or nested-validation pipeline. No experimental images, fitted regression models, sample identifiers, private file paths or acquisition metadata are included. The software is provided as reference code without a claim that the synthetic tests constitute experimental validation.
>>>>>>> origin/main
