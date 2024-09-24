## 注意

本 Repo 適用於 [powenn/AltServer-Linux-PyScript](https://github.com/powenn/AltServer-Linux-PyScript)

## 使用方法

複製以下指令

```bash
# clone 本 repo 
git clone git@github.com:iervn6341-ovo/altserver_lib_install_script.git
cd altserver_lib_install_script

# 賦予可執行權限
chmod +x altserver_lib_install.sh

# 開始建置環境必要依賴
./altserver_lib_install.sh

# clone AltServer-Linux-PyScript 遠端倉庫
cd ..
git clone https://github.com/powenn/AltServer-Linux-PyScript.git
cd AltServer-Linux-PyScript
sudo python3 main.py
```

最後執行 main.py 也可以用 nohup 啟
```bash
nohup sudo python3 main.py > /dev/null 2>&1 &
```
