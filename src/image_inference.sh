#!/usr/bin/env bash
set -euo pipefail

MODEL_DIR="${MODEL_DIR:-models/crowdhuman_visible}"
INPUT_IMAGE="${1:-data/crowdhuman_dataset/voc_visible/JPEGImages/273271,c9db000d5146c15.jpg}"
OUTPUT_IMAGE="${2:-data/crowdhuman_visible_test_t35.jpg}"

detectnet \
  --model="${MODEL_DIR}/ssd-mobilenet.onnx" \
  --labels="${MODEL_DIR}/labels.txt" \
  --input-blob=input_0 \
  --output-cvg=scores \
  --output-bbox=boxes \
  --threshold=0.35 \
  "${INPUT_IMAGE}" \
  "${OUTPUT_IMAGE}"
