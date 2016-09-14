function update () {
  sudo apt-get update -y && echo "" && \
  sudo apt-get dist-upgrade -y && echo "" && \
  sudo apt-get upgrade -y && echo "" && \
  sudo apt-get autoremove -y && echo "" && \
  sudo localepurge && echo "" && \
  sudo deborphan | xargs sudo apt-get remove -y --purge && echo "" && \
  sudo apt-get autoclean -y && echo "" && \
  sudo apt-get moo
}

function iniciar () {

  if [ $# -eq 1 ]; then
      if [ $1 == "cd" ]; then
          cd
      elif [ $1 == "cc" ]; then
          clear
          cd
      fi
  fi

  for file in /etc/update-motd.d/*
  do
    bash $file
  done
}

function fs () { #fix symfony permissions
#  sudo rm -rf app/cache/*
#  sudo rm -rf app/logs/*

  HTTPDUSER=`ps aux | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`
  sudo setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX app/cache app/logs
  sudo setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX app/cache app/logs

  sudo chown -R www-data:www-data *
}


function cacheclear () { #clear symfony cache
  FILE1="app/console"
  FILE2="bin/console"
  if [ -f $FILE1 ];
  then
    php $FILE1 cache:clear --env=prod
    php $FILE1 cache:clear
  fi
  if [ -f $FILE2 ];
  then
    php $FILE2 cache:clear --env=prod
    php $FILE2 cache:clear
  fi
  mkdir -p app/cache/dev/vich_uploader
  mkdir -p app/cache/prod/vich_uploader
  fs
}

function godev () {
  cd /var/www/
  if [ $# -eq 1 ]; then
      cd $1
  fi
}

function mcd () {
    mkdir -p $1
    cd $1
    ls
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"

 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}
