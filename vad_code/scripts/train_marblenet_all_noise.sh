DATA_DIR="./manifests_local"
NAME="marblenet_3x2x64_multilang_40ms_all_noise_adamlr1e-2_wd1e-3_trnoise"
BATCH_SIZE=512
NUM_WORKERS=4
PIN_MEMORY=true
CUDA_VISIBLE_DEVICES=0 python speech_to_multi_label.py \
    --config-path="./configs" --config-name="marblenet_3x2x64_noise" \
    model.train_ds.augmentor.noise.manifest_path="[${DATA_DIR}/musan_train_44h.json,${DATA_DIR}/freesound_train_262h.json,${DATA_DIR}/freesound_nonspeech_train_FL200_local.json,${DATA_DIR}/musan_train_FL200_local.json]" \
    model.train_ds.manifest_filepath="[${DATA_DIR}/ami_train_40ms_local.json,${DATA_DIR}/fisher_2004_40ms_local.json,${DATA_DIR}/fisher_2005_40ms_local.json,${DATA_DIR}/icsi_all_40ms_local.json,${DATA_DIR}/french_train_40ms_cleaned_local.json,${DATA_DIR}/german_train_40ms_local.json,${DATA_DIR}/mandarin_train_40ms_local.json,${DATA_DIR}/russian_train_40ms_local.json,${DATA_DIR}/spanish_train_40ms_local.json]" \
    model.validation_ds.manifest_filepath="[${DATA_DIR}/ami_dev_40ms_local.json,${DATA_DIR}/ch120_moved_40ms_local.json,${DATA_DIR}/french_dev_40ms_local.json,${DATA_DIR}/german_dev_40ms_local.json,${DATA_DIR}/mandarin_dev_40ms_local.json,${DATA_DIR}/russian_dev_40ms_local.json,${DATA_DIR}/spanish_dev_40ms_local.json]" \
    model.test_ds.manifest_filepath="[${DATA_DIR}/ami_dev_40ms_local.json,${DATA_DIR}/ch120_moved_40ms_local.json,${DATA_DIR}/french_dev_40ms_local.json,${DATA_DIR}/german_dev_40ms_local.json,${DATA_DIR}/mandarin_dev_40ms_local.json,${DATA_DIR}/russian_dev_40ms_local.json,${DATA_DIR}/spanish_dev_40ms_local.json]" \
    model.train_ds.batch_size=$BATCH_SIZE \
    model.validation_ds.batch_size=$BATCH_SIZE \
    model.test_ds.batch_size=$BATCH_SIZE \
    model.train_ds.num_workers=$NUM_WORKERS \
    model.validation_ds.num_workers=$NUM_WORKERS \
    model.test_ds.num_workers=$NUM_WORKERS \
    model.train_ds.pin_memory=$PIN_MEMORY \
    model.validation_ds.pin_memory=$PIN_MEMORY \
    model.test_ds.pin_memory=$PIN_MEMORY \
    trainer.max_epochs=50 \
    exp_manager.name=${NAME} \
    exp_manager.create_wandb_logger=true \
    exp_manager.wandb_logger_kwargs.name=${NAME} \
    exp_manager.wandb_logger_kwargs.project="Frame_VAD" \
    ++model.loss.weight="[2.37,1.73]"
