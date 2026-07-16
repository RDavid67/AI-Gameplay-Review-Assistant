# AI Gameplay Review Assistant

An AI-assisted post-match review prototype that detects visible people in prerecorded gameplay on an NVIDIA Jetson Orin Nano.

> **Project status:** the final visible-body model has completed training, has been exported to ONNX, and has passed image and video inference tests. The final demonstration video uses a confidence threshold of `0.25`. The current version is a functional demonstration prototype, not a live competitive-assistance tool.

## Project Goal

The project helps players review their own recorded matches after play. The first use case is the Solo vs Squad mode in *Delta Force*, where one player may encounter squads of up to three players. Human-detection boxes make encounters easier to locate and inspect during replay review.

The project is intended only for post-match analysis of prerecorded footage.

## Scope Decision

The original idea included detecting military units. However, the available military-oriented source images mainly showed heavily camouflaged people and did not closely match the appearance of characters in *Delta Force*. The project therefore shifted toward general visible-person detection rather than military-unit classification.

## Hardware and Software

- NVIDIA Jetson Orin Nano
- NVIDIA Jetson-Inference
- CUDA
- SSD-MobileNet / MB1-SSD
- 300 x 300 model input resolution
- CrowdHuman data converted to Pascal VOC format
- Visible-body person annotations

## Dataset

- Training set: 15,000 images
- Validation set: 4,370 images
- Detection scope: one visible-person class

The CrowdHuman dataset itself is not included in this repository. Users must obtain it from its official source and follow its terms of use.

## Final Model

The earlier full-body model often produced oversized, overlapping, or merged boxes. The final `crowdhuman_visible` model uses visible-body annotations and produced a major qualitative improvement: boxes more closely follow the visible parts of people, and multiple people can be detected separately in crowded scenes.

| Item | Result |
| --- | --- |
| Training | Completed 10 epochs (Epoch 0-9) |
| Final saved Epoch 9 checkpoint | `models/crowdhuman_visible/mb1-ssd-Epoch-9-Loss-5.253142016430469.pth` |
| Exported model | `models/crowdhuman_visible/ssd-mobilenet.onnx` |
| Labels | `models/crowdhuman_visible/labels.txt` |
| Reference image output | `data/crowdhuman_visible_test_t30.jpg` |
| Final image threshold | `0.35` |
| Final video threshold | `0.25` |
| Final demonstration video | `FInal_2mom_home.mp4` |

The Epoch 9 file above is the final saved checkpoint. The ONNX export script selects the checkpoint with the lowest recorded validation loss in the model directory.

## Detection Threshold

No single threshold works best for every scene. Tests showed the usual precision-recall trade-off:

| Threshold | Observed behavior |
| --- | --- |
| `0.30` | Detects more people, but may retain overlapping or duplicate boxes |
| `0.35` | Practical balance for the reference CrowdHuman image; selected as the default image starting point |
| `0.40` | Cleaner boxes, but more missed people |

Gameplay videos have a larger visual difference from CrowdHuman images, so lower thresholds such as `0.25` or `0.28` may be more useful. Thresholds should be tuned for each video instead of treated as a universal value.

For the submitted prototype, the final settings are `0.35` for image demonstrations and `0.25` for the final video demonstration.

## Export the Model to ONNX

Run this command from `jetson-inference/python/training/detection/ssd`:

```bash
python3 onnx_export.py --model-dir=models/crowdhuman_visible
```

Expected output:

```text
models/crowdhuman_visible/ssd-mobilenet.onnx
```

## Test a Reference Image

```bash
detectnet --model=models/crowdhuman_visible/ssd-mobilenet.onnx --labels=models/crowdhuman_visible/labels.txt --input-blob=input_0 --output-cvg=scores --output-bbox=boxes --threshold=0.35 "data/crowdhuman_dataset/voc_visible/JPEGImages/273271,c9db000d5146c15.jpg" data/crowdhuman_visible_test_t35.jpg
```

To reproduce the saved `0.30` reference result, change the threshold to `0.30` and the output name to `data/crowdhuman_visible_test_t30.jpg`.

## Test a Gameplay Video

Always run inference on the original video, not on a video that already contains detection boxes.

Final video inference example for the original `2mom_home_test.mp4`:

```bash
detectnet --model=models/crowdhuman_visible/ssd-mobilenet.onnx --labels=models/crowdhuman_visible/labels.txt --input-blob=input_0 --output-cvg=scores --output-bbox=boxes --threshold=0.25 data/2mom_home_test.mp4 data/2mom_home_test_visible_t25.mp4
```

Example for the existing `hybird_test.mp4` file:

```bash
detectnet --model=models/crowdhuman_visible/ssd-mobilenet.onnx --labels=models/crowdhuman_visible/labels.txt --input-blob=input_0 --output-cvg=scores --output-bbox=boxes --threshold=0.28 data/hybird_test.mp4 data/hybird_test_visible_t28.mp4
```

The existing `hybird` spelling is intentionally retained so that the documented paths match the project files.

Let video processing finish normally. Interrupting the process can leave the output MP4 incomplete or unplayable.

## Current Results

- The visible-body model is a qualitative improvement over the earlier full-body model.
- Most detection boxes align more closely with visible people.
- Crowded scenes can contain separately detected individuals instead of one oversized merged box.
- A processed `1mom_home_test_visible_t33.mp4` test showed that `0.33` was too strict for parts of the indoor gameplay footage and caused substantial missed detections.
- Lower video thresholds improve recall but can introduce unstable or inaccurate boxes.
- The final `2mom` demonstration confirmed that `0.25` gives a more useful balance for the submitted video, so further threshold tuning was stopped.

## Final Video Examples

Representative screenshots are available in the [Final Detection Examples](results/README.md) page:

- A successful outdoor person detection at approximately 25 seconds.
- A crowded multi-person scene at approximately 45 seconds.
- A moving indoor scene at approximately 5 seconds where visible people are missed.

Formal mAP, precision, recall, and end-to-end FPS have not yet been reported. Current conclusions are based on qualitative image and video comparisons.

## Limitations

- The model detects visible people; it does not determine whether a person is an enemy or teammate.
- Domain differences between CrowdHuman photographs and gameplay footage can cause missed or inaccurate detections.
- Distant, partially visible, low-contrast, and motion-blurred people remain difficult.
- Threshold changes trade false detections against missed detections.
- The system does not yet generate coaching summaries or remember repeated player habits.
- The project has been tested as a post-match prototype and is not production software.

## Remaining Packaging Steps

- Add the final normal demonstration video or a shareable link only after everyone shown has agreed to public distribution.
- Measure mAP, precision, recall, and processing speed when time permits.
- Add reproducible setup details and any final helper scripts to `src`.

## Repository Structure

```text
.
|-- docs/      Project documentation
|-- models/    Model information and artifact paths
|-- results/   Representative detection screenshots
|-- demo/      Final demonstration video information
|-- src/       Source-code and inference-script information
`-- README.md  Project overview and usage
```

## Documentation

Additional project documentation is available in the [`docs`](docs) folder.

## Model and Source Notes

Model information is available in [`models`](models), and source-code information is available in [`src`](src). The model and dataset paths in this README refer to the Jetson training workspace and may not be stored directly in the GitHub repository.

## License

The final source-code license has not yet been selected. Dataset files and pretrained weights remain subject to their own licenses and must not be assumed to use the same license as this repository.

## Disclaimer

This is an independent educational project and is not affiliated with or endorsed by the developers or publishers of *Delta Force*.
