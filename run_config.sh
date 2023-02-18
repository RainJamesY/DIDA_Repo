gpu=$1
echo "export CUDA_VISIBLE_DEVICES=$gpu"
export CUDA_VISIBLE_DEVICES=${gpu}

#source ~/venv/daformer/bin/activate
# run config exp
nohup python run_experiments.py --config configs/daformer/gta2cs_uda_warm_fdthings_rcs_croppl_a999_daformer_mitb5_s0.py   > run_config.out # 你要运行的python进程

#gnome-terminal
#watch -n 1 'ps -aux --sort -pmem'
#$pid = pgrep "python"
#sudo echo -17>/proc/$pid/oom_adj