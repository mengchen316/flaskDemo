server='app.py'
main_path='/home/cm/python3/flaskDemo'


# 重启服务
restart_server(){
    ps -ef | grep $server  | grep -v grep | awk '{print $2}' | xargs sudo kill -9
    sleep 1

    export LANG="en_US.UTF-8"
    export PYTHONPATH=$PYTHONPATH:$main_path

    if [ ! -d "${main_path}/venv" ];then
      setup
    fi

    ${main_path}/venv/bin/python3 -m pip install -r ${main_path}/requirements.txt

    nohup ${main_path}/venv/bin/python3 $server
    echo "======================================"
    sleep 1
    ps -ef | grep $server | grep -v grep
}

setup(){
  rm -rf ${main_path}/venv
  mkdir ${main_path}/venv
  python3 -m venv ${main_path}/venv
  ${main_path}/venv/bin/python3 -m pip install -r ${main_path}/requirements.txt
}

# 执行sh restart.sh
restart_server
