# Basic laser-shock analysis routines

Standalone MATLAB R2024a reference functions for three calculation steps:

- `fit_axis_aligned_front`: least-squares fit of an axis-aligned ellipse to an already extracted contour.
- `ray_ellipse_distance`: forward intersection of rays from a fixed origin with the fitted ellipse.
- `ratio_uncertainty`: delta-method standard error for a ratio of paired independent-unit means.

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

These routines do not constitute the full image-segmentation, hybrid-fitting, model-selection or nested-validation pipeline. No experimental images, fitted regression models, sample identifiers, private file paths or acquisition metadata are included. The software is provided as reference code without a claim that the synthetic tests constitute experimental validation.
