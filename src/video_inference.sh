#!/usr/bin/env bash
set -euo pipefail

MODEL_DIR="${MODEL_DIR:-models/crowdhuman_visible}"
INPUT_VIDEO="${1:-data/2mom_home_test.mp4}"
OUTPUT_VIDEO="${2:-data/2mom_home_test_visible_t25.mp4}"

detectnet \
  --model="${MODEL_DIR}/ssd-mobilenet.onnx" \
  --labels="${MODEL_DIR}/labels.txt" \
  --input-blob=input_0 \
  --output-cvg=scores \
  --output-bbox=boxes \
  --threshold=0.25 \
  "${INPUT_VIDEO}" \
  "${OUTPUT_VIDEO}"
