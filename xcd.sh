#!/bin/bash

function xcd() {
  # <<< 设置缓存文件路径 <<<
  home_dir_path=$(builtin cd ||{ echo "无法进入用户根目录";return; };pwd;)
  cache_dir_path="${home_dir_path}/.xcd"
  cache_file_path="${home_dir_path}/.xcd/cache.txt"
  # <<< end 设置缓存文件路径 <<<

  # 判断目录是否存在，不存在则级联创建
  if [ ! -d "${cache_dir_path}" ];then
    mkdir "${cache_dir_path}"
  fi

  # 判断缓存文件是否存在,不存在则创建
  if [ ! -f "${cache_file_path}" ];then
    touch "${cache_file_path}"
  fi

  # 获取当前的路径
  last_dir=$(pwd)

  is_success=true
  if [[ $# -eq 1 && $1 == '...' ]]
  then
    last_path=$(tail -n 1 "${cache_file_path}")
    builtin cd "${last_path}" || { echo "上个目录 ${last_path} 已经不见了";return; }
  else
    args_str=''
    i=1
    while [[ $i -le $# ]]
    do
      eval arg="\$$i"
      args_str="${args_str} ${arg} "
      i=$((i+1))
    done
    # 去掉开头或者结尾的空格
    args_str=$(eval echo "${args_str}")
#    echo "${args_str}"

    builtin cd ${args_str} || { is_success=false; }
  fi
#  echo ${is_success}
  if [[ ${is_success} = true ]]
  then
#    echo "写入缓存文件"
    echo "${last_dir}" >> "${cache_file_path}"
  else
#    echo "不写入缓存文件"
    usleep
  fi
}
alias cd=xcd