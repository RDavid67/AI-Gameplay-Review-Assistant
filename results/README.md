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
