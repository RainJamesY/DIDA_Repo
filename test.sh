# ---------------------------------------------------------------
# Anonymous ICME2023 Authors, Paper-id:541
# ---------------------------------------------------------------
TEST_ROOT=$1
mkdir -p ${TEST_ROOT}/preds/
CONFIG_FILE="${TEST_ROOT}/*${TEST_ROOT: -1}.json"
CHECKPOINT_FILE="${TEST_ROOT}/latest.pth"
SHOW_DIR="${TEST_ROOT}/preds/"
echo 'Config File:' $CONFIG_FILE
echo 'Checkpoint File:' $CHECKPOINT_FILE
echo 'Predictions Output Directory:' $SHOW_DIR

nohup python -m tools.test ${CONFIG_FILE} ${CHECKPOINT_FILE} --eval mIoU --show-dir ${SHOW_DIR} --opacity 1 > ${SHOW_DIR}pre_log.out
