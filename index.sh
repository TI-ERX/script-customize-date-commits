#!/usr/bin/env sh

_() {
  YEAR="2016"
  echo "GitHub Username: "
  read -r USERNAME
  echo "GitHub Access token: "
  read -r ACCESS_TOKEN

  [ -z "$USERNAME" ] && exit 1
  [ -z "$ACCESS_TOKEN" ] && exit 1
  [ ! -d $YEAR ] && mkdir $YEAR

  cd "${YEAR}" || exit
  git init
  git config core.autocrlf false  # Desativa a conversão automática CRLF no Windows
  echo "**${YEAR}** - Generate by Erick" \
    >README.md
  git add README.md

  # Commit para os dias de janeiro e fevereiro
  for MONTH in {01}
  do
    for DAY in 01 09 17 25
    do
      echo "Content for ${YEAR}-${MONTH}-${DAY}" > "day${MONTH}_${DAY}.txt"
      git add "day${MONTH}_${DAY}.txt"
      GIT_AUTHOR_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00" \
        GIT_COMMITTER_DATE="${YEAR}-${MONTH}-${DAY}T18:00:00" \
        git commit -m "Commit for ${YEAR}-${MONTH}-${DAY}"
    done
  done

  git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/${YEAR}.git"
  git branch -M main
  git push -u origin main -f
  cd ..
  rm -rf "${YEAR}"

  echo
  echo "Legal, esqueça tudo fio https://github.com/${USERNAME}"
} && _

unset -f _
