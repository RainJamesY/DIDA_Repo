# ---------------------------------------------------------------
# Create buffer with different size
# Anonymous ICME2023 Authors, Paper-id:541
# ---------------------------------------------------------------
import numpy as np
import torch
import torch.nn.functional as F
import pdb

buffer_size = 300 # can be viewed as a hyperparameter
dim = 256   # 
f_buffer = torch.randn(buffer_size, dim, dtype=torch.float32) # feature buffer
f_buffer = F.normalize(f_buffer, dim=1) # initiallize as unit random vectors
# f_buffer = f_buffer.numpy()
# pdb.set_trace()
np.savez(r'./embedding_cache/f_buffer.npz', f_buffer)

