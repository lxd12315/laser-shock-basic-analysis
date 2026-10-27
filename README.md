# Basic laser-shock analysis routines

MATLAB R2024a functions illustrating axis-aligned least-squares contour fitting,
fixed-origin ray/ellipse intersection, and covariance-aware uncertainty of a
ratio of paired acquisition-unit means. Run `test_basic_functions` for numerical
checks on synthetic data.

These are standalone reference implementations of basic calculation steps,
not the complete image-segmentation, hybrid-fitting or nested-validation pipeline.
They do not include experimental images, fitted regression models, private file
paths, sample identifiers or acquisition metadata. Input coordinates and angles
must be mapped explicitly to the experimental coordinate convention. No synthetic
test output should be interpreted as an experimental validation result.
