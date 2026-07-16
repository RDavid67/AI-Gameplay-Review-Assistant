# Final Model

## Status

- Model: `crowdhuman_visible`
- Architecture: SSD-MobileNet / MB1-SSD
- Input resolution: 300 x 300
- Training: completed 10 epochs (Epoch 0-9)
- Final image threshold: `0.35`
- Final video threshold: `0.25`

## Jetson Workspace Artifacts

```text
models/crowdhuman_visible/mb1-ssd-Epoch-9-Loss-5.253142016430469.pth
models/crowdhuman_visible/ssd-mobilenet.onnx
models/crowdhuman_visible/labels.txt
```

The Epoch 9 file is the final saved training checkpoint. The ONNX export script selects the checkpoint with the lowest recorded validation loss in the model directory.

The visible-body model produced a major qualitative improvement over the earlier full-body model. Remaining limitations include missed detections, overlapping boxes in crowded scenes, and domain differences between CrowdHuman images and gameplay footage.

Large model files may be distributed separately. CrowdHuman dataset files are not included in this repository.
