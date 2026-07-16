# Inference Commands

Run the scripts from the Jetson-Inference SSD working directory:

```text
jetson-inference/python/training/detection/ssd
```

## Image

```bash
bash src/image_inference.sh
```

The default image threshold is `0.35`.

## Video

```bash
bash src/video_inference.sh
```

The final video threshold is `0.25`.

Both scripts accept optional input and output paths as their first and second arguments.
