#!/bin/bash

# fork from Per-core temperatures :
# https://github.com/jaagr/polybar/wiki/User-contributed-modules#per-core-temperatures

# Get information from cores temp thanks to sensors

function temperature {
  local tempCore=$1
  local degree="°C"
  local temperaturesValues=(40 50 60 70 80 90)
  local temperaturesColors=("#6bff49" "#f4cb24" "#ff8819" "#ff3205" "#f40202" "#ef02db")
  local temperaturesIcons=($2 $2 $2 $2  )  

  local finalEcho
  local tmpEcho
  local total

  for iCore in ${!tempCore[*]}
  do
      for iTemp in ${!temperaturesValues[*]}
      do
          if (( "${tempCore[$iCore]}" < "${temperaturesValues[$iTemp]}"  )); then
              tmpEcho="%{F${temperaturesColors[$iTemp]}}${tempCore[$iCore]}$degree%{F-}"
              finalEcho="$finalEcho $tmpEcho"
              break
          fi
      done
      total=$(( ${tempCore[$iCore]} + total ));
  done  

  local sum=$(( $total/${#tempCore[*]} ))  

  for iTemp in ${!temperaturesValues[*]}
  do
      if (( "$sum" < "${temperaturesValues[$iTemp]}" )); then
          ## This line will color the icon too
          tmpEcho="%{F${temperaturesColors[$iTemp]}}${temperaturesIcons[$iTemp]}%{F-}"
          ## This line will NOT color the icon
          #tmpEcho="${temperaturesIcons[$iTemp]}"
          finalEcho=" $finalEcho $tmpEcho"
          break
      fi
  done  

  echo $finalEcho
  return
}


rawData=$( sensors | grep -m 1 Tctl | awk '{print substr($2,2,2)   }' )
tempTctl=($rawData)

tTctl=$(temperature $tempTctl )

rawData=$(sensors | grep -m 1 Composite | awk '{print substr($2,2,2)   }')
tempNvme=($rawData)
tNvme=$(temperature $tempNvme )


# Define constants :

echo "$tTctl $tNvme"
