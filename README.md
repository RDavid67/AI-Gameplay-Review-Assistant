# AI Gameplay Review Assistant

An AI-assisted post-match gameplay review tool using human detection on NVIDIA Jetson Orin.

## Project Description

This project uses AI-based human detection to assist players with reviewing recorded gameplay after a match.

The first version focuses on the Solo vs Squad mode in Delta Force. In this mode, the player enters without teammates and may face squads of up to three players. Because there are no friendly teammates, detected human targets can be treated as potential enemy encounters during replay review.

The project is designed for post-match analysis, not live competitive assistance.

## Current Status

The project is currently under development.

- A baseline full-body human detection model has been trained and exported to ONNX.
- The baseline model produced inaccurate and overlapping detection boxes.
- A visible-body human detection model is currently being retrained.
- The final model and detection threshold have not yet been selected.

## The Algorithm

The project uses:

- NVIDIA Jetson Orin Nano
- NVIDIA Jetson-Inference
- SSD-MobileNet / MB1-SSD
- Person-only CrowdHuman training data
- Visible-body human annotations
- 300 × 300 model input resolution

The model detects human targets in prerecorded gameplay footage.

## Input and Output

### Input

A prerecorded MP4 gameplay video.

### Planned Output

An MP4 gameplay video with human-detection bounding boxes.

The final output quality is still being tested and improved.

## Current Features

- Human detection
- Image inference testing
- Video inference testing
- Post-match gameplay review focus
- Support for prerecorded MP4 footage

## Limitations

- The model detects humans or potential enemies, but does not identify team membership.
- The current baseline model does not yet provide acceptable detection quality.
- The visible-body model is still being trained.
- AI coaching and long-term memory are not yet implemented.

## Future Improvements

- Enemy and teammate classification
- AI-generated summaries of mistakes and useful techniques
- Personalized gameplay suggestions
- Long-term memory of repeated player habits
- Automatic video-format conversion
- Optional humorous replay subtitle and voiceover mode

## Running This Project

Final setup and inference instructions will be added after the visible-body model and video-processing command are confirmed.

## Results

Final detection screenshots, evaluation results, and demonstration videos will be added after testing is complete.

## Documentation

Project documentation is available in the [`docs`](docs) folder.

## Source Code

Source-code information is available in the [`src`](src) folder.

## Models

Model information is available in the [`models`](models) folder.

## License

This project is planned to be released as free and open-source software.

The final open-source license has not yet been selected.
