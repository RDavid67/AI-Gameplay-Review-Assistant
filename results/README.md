# Final Detection Examples

These screenshots were extracted from the final `0.25`-threshold demonstration video.

## Successful Detection

<img width="1088" height="1920" alt="Successful outdoor person detection" src="https://github.com/user-attachments/assets/4f2ac0bb-9628-4352-af94-0262bf658f96" />

The model detects a clearly visible person outdoors at approximately 25 seconds.

## Multi-Person Scene

<img width="1088" height="1920" alt="Crowded multi-person detection" src="https://github.com/user-attachments/assets/a6a161f0-904c-4aa9-96ae-4ed4d54493e1" />

The model detects several people in a crowded indoor scene at approximately 45 seconds. Some boxes overlap, illustrating the remaining duplicate-box limitation.

## Missed Detection

<img width="1088" height="1920" alt="Missed detection during movement" src="https://github.com/user-attachments/assets/be27888e-078f-4ed9-b487-6108b373c336" />

Several moving people are visible at approximately 5 seconds, but the model does not produce detection boxes. This example documents the remaining recall limitation under motion and indoor lighting.


## Model Improvement and Image Threshold Comparison

All four images use the same validation scene, making the change in box quality directly comparable.

### Baseline Full-Body Model

<img width="800" height="600" alt="clipboard" src="https://github.com/user-attachments/assets/5c8a40f4-7a8b-44bb-9d25-f8304a756c39" />


The baseline `person` model creates many oversized, duplicate, and overlapping boxes that cover most of the scene. Individual people are difficult to distinguish.

### Visible-Body Model at 0.30

<img width="800" height="600" alt="clipboard" src="https://github.com/user-attachments/assets/3b662425-1091-4afc-9301-d2274e339308" />


Visible-body annotations greatly reduce full-frame boxes and make individual people easier to separate. At `0.30`, recall is higher, but extra overlapping boxes remain.

### Visible-Body Model at 0.35 - Selected Image Threshold

<img width="800" height="600" alt="clipboard" src="https://github.com/user-attachments/assets/472f3fbd-d3f6-4315-82d4-2f0602d6f48d" />


The `0.35` result provides the most practical balance for the reference image: it is cleaner than `0.30` while retaining more people than `0.40`.

### Visible-Body Model at 0.40

<img width="800" height="600" alt="clipboard" src="https://github.com/user-attachments/assets/736bd35e-53f4-4065-b5a1-90d6b5c8e006" />


At `0.40`, boxes are cleaner but additional people are missed. This confirms the precision-recall trade-off and supports the final image threshold of `0.35`.
