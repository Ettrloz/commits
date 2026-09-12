#!/bin/sh

useless_commit() {
  if ! command -v git >/dev/null 2>&1; then
    echo "Command git does not exist"
    
    return
  fi

  if [ ! -d "trash_do_not_open" ]; then
    mkdir "trash_do_not_open"
  fi

  git_alias=$1
  git_branch=$2

  while true; do
    current_date="$(date +%s)"
    filename="trash_do_not_open/${current_date}.txt"

    head -c 10000 /dev/urandom | base64 > "$filename"

    git add "$filename"
    git commit -m "trash $current_date"
    git push "$git_alias" "$git_branch"

    sleep 30
  done
}

useless_commit "origin" "main"
