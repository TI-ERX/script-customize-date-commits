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

  # Commits para os dias de janeiro
  for DAY in 02 03 04 05 06 07 08 10 11 12 13 14 15 16 18 19 20 21 22 23 24 26 27 28 29 30
  do
    echo "Content for ${YEAR}-01-${DAY}" > "day01_${DAY}.txt"
    git add "day01_${DAY}.txt"
    GIT_AUTHOR_DATE="${YEAR}-01-${DAY}T18:00:00" \
      GIT_COMMITTER_DATE="${YEAR}-01-${DAY}T18:00:00" \
      git commit -m "Commit for ${YEAR}-01-${DAY}"
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
