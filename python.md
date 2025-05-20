## 搭建环境
**创建venv虚拟环境**
```
python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt
```

查看 pip位置
conda run which pip   

终端配置代理
export http_proxy=http://127.0.0.1:10809  
export https_proxy=http://127.0.0.1:10809 
export ALL_PROXY=socks5://127.0.0.1:10808

vim ./.zshrc  
取消代理
unset http_proxy
unset https_proxy
unset all_proxy


export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"


conda config --add channels conda-forge
conda config --set channel_priority strict
conda install osmium


conda create -n osm-env python=3.10
conda activate osm-env
conda install -c conda-forge pyosmium pandas


pip install flask -i https://pypi.tuna.tsinghua.edu.cn/simple