#!/bin/bash 

#Colours
greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
blueColor="\e[0;34m\033[1m"
yellowColor="\e[0;33m\033[1m"
purpleColor="\e[0;35m\033[1m"
turquoiseColor="\e[0;36m\033[1m"
grayColor="\e[0;37m\033[1m"

#crtl  function
function ctrl_c(){
  tput civis
	echo -e "\n${yellowColour}[*]${endColour}${grayColour} Abandoned bet...${endColour}"; sleep 1
	tput cnorm; exit 1
}

trap ctrl_c INT

#functions

function helpPanel(){

echo -e "\n\n\n\n\t\t\t\t\t${greenColor}[!]${endColor} ${turquoiseColor}welcome to the help panel${endColor}\n\n\n"
echo -e "${yellowColor}[!]${endColor} use script for bet: ${purpleColor}$0${endColor} + ${purpleColor}amount of money${endColor} + ${purpleColor}tecniche of bet${endColor} ${greenColor}\nCommands:${endColor}"
echo -e "\t${blueColor}m) How much money to bet \n"
echo -e "\tt) Thecnique for bet\n"
echo -e "\th) Show help panel${endColor}\n"
}
  

function martingala(){
  echo -e "${greenColor}[!]${endColor}${redColor} actual money: s/$money${endColor}"
  echo -ne "${blueColor}[?]${endColor} ${greenColor}how much money are you going to bet?${endColor} -> " && read initial_bet
  echo -ne "${blueColor}[?]${endColor}${blueColor} play to (even/odd)?${endColor} ->  "&& read even_odd
  echo -e "${blueColor}[+]${endColor} let's play $even_odd whith s/$money" 
  sleep 2

  backup_bet=$initial_bet
  play_counter=1
  bad_plays=""
  top=0

  tput civis
  while true; do 

    money=$(($money-$initial_bet))
    echo -e "${greenColor}[+]${endColor}You just bet ${turquoiseColor}s/$initial_bet${endColor} and you have ${greenColor}s/$money${endColor}"

    random_number="$(($RANDOM % 37))"
    echo -e "${turquoiseColor}number out: $random_number${endColor}"

    if [ ! "$money" -lt 0 ]; then
      if [ $even_odd == "even" ]; then 
        if [ "$(($random_number % 2))" -eq 0 ]; then 
          if [ "$random_number" -eq 0 ]; then
             echo -e "is 0, you lose"
             echo -e "${redColor}is 0 , you lose money${endColor}"
             initial_bet=$(($initial_bet*2))
             echo -e "Do you have s/$money"
            bad_plays+="$random_number "
          else
            #echo -e "even number, Win!"
            reward=$(($initial_bet*2))
            #echo -e "${greenColor}:)${endColor} you have earned a total of s/$reward"
            money=$(($money+$reward))
            #echo -e "${greenColor}!!!${endColor}You have $money "
            initial_bet=$backup_bet
            bad_plays=" " 
          fi
        else
          echo -e  "${redColor}odd number, you lose money${endColor}"
          initial_bet=$(($initial_bet*2))
          bad_plays+="$random_number"
        fi 
      else
 #     numeros impares
        if [ "$(($random_number % 2))" -eq 1 ]; then
            #echo -e "even number, Win!"
            reward=$(($initial_bet*2))
            #echo -e "${greenColor}:)${endColor} you have earned a total of s/$reward"
            money=$(($money+$reward))
            #echo -e "${greenColor}!!!${endColor}You have $money "
            initial_bet=$backup_bet
        else
          initial_bet=$(($initial_bet*2))
          #echo -e "Do you have s/$money"
          bad_plays+="$random_number "
            if [ ! $top -ge $reward ]; then
                top="$reward"
            fi

        fi 
      fi
    else
       echo -e "${redColor} !congratulation!!, now you are poor,wbn${endColor}"
       echo -e "${redColor} it has taken ${purpleColor}$play_counter moves${endColor} to lose all your money${endColor},${greencolor}your reward ${purpleColor}top was${purpleColor} s/$top ${endColor} and lose for you bad streak: $bad_plays "
       sleep 7
       echo "....."
       sleep 5
       echo "...."
       sleep 5
       echo -e " sigues aca?"
       sleep 5
      echo -e "${greenColor}Es correcto dejar tus decisiones en manos de la suerte?${endColor}"
       exit 0
    fi
    tput cnorm
    let play_counter+=1
    if [ ! $top -ge $reward ]; then
      top=$reward
    fi
  done 
}

function inverseLabruchere(){ #esta parte del codigo aun es confuso y esta sujeto a futuras modificaciones(que quere que ñe haga manitp,soy nuevo en esto)
  echo -e "${greenColor}[!]${endColor}${purpleColor}actual money: s/$money"
  echo -ne "${blueColor}[?]${endColor}${purpleColor}play to (even/odd)? ->  "&& read even_odd  
  declare -a labruchere=(1 2 3 4)

  echo -e "${greenColor}[!]${endColor} starting with next sequence ${greenColor}[${labruchere[@]}${endColor}]"

  bet=$((${labruchere[0]} + ${labruchere[-1]}))
  let play_counter=1
  bet_renew=$((money+50))
  bad_plays=""
  top=0
  
  
  while true; do
    money=$(($money - $bet))
    random_number=$(($RANDOM % 37))
    if [ ! "$money" -lt 0 ]; then
     let play_counter+=1

      echo -e "${blueColor}[...]${endColor}${blueColor} lets play number: ${endColor}${greenColor}$random_number${endColor}"
      echo -e "${purpleColor}Beting:${endColor} ${blueColor}$bet${endColor}" 
      echo -e "${purpleColor}Have:${endColor} ${greenColor}$money${endColor}"

      echo -e "\n\t\t\t\tSpinning roulette..."
   
      if [ $even_odd == "even" ] || [ $even_odd == "odd" ]; then
        if [ $(($random_number % 2)) -eq 0 ] && [ "$random_number" -ne 0 ]; then
          #echo -e "${yellowColor}[+] WIN!${endColor}the number is even"
          reward=$(($bet*2))
          let money+=$reward 
           #echo -e "you have ${greenColor}s/$money${endColor}"
          if [ $money -gt $bet_renew ]; then 
              bet_renew=$(($bet_renew + 50))
              labruchere=(1 2 3 4)
              bet=$((${labruchere[0]} + ${labruchere[-1]})) 
          else
              labruchere+=($bet)
              labruchere=(${labruchere[@]})

#              echo -e "the sequence is ${blueColor}[${labruchere[@]}]${endColor}"
              if [ "${#labruchere[@]}" -ne 1 ] && [ "${#labruchere[@]}" -ne 0 ]; then
                bet=$((${labruchere[0]} + ${labruchere[-1]}))
              elif [ "${#labruchere[@]}" -eq 1 ]; then
                bet=${labruchere[0]}
              else
#                echo -e "${redColor}[!]${endColor} the end sequence"
                labruchere=(1 2 3 4)
#                echo -e "${greenColor}[*] Restart sequence..${endColor}" 
#                echo -e "${greenColor}[!]${endColor} the sequense is ${blueColor} [${labruchere[@]}]${endColor}"
              fi
                if [  $reward -ge $top ]; then
                  top=$reward
          fi

          fi 
        elif [ $(($random_number % 2)) -eq 1 ] || [ "$random_number" -eq 0 ]; then
            if [ $money -lt $(($bet_renew-100)) ]; then
#                echo -e "the top bet critical reset top"
              bet_renew=$(($bet_renew - 50 ))
#                echo -e "the new top is $bet_renew"

              labruchere+=($bet)
              labruchere=(${labruchere[@]})
              bad_plays+="$random_number "

#                echo -e "the sequence is ${blueColor}[${labruchere[@]}]${endColor}"
                 if [ "${#labruchere[@]}" -ne 1 ] && [ "${#labruchere[@]}" -ne 0 ]; then
                  bet=$((${labruchere[0]} + ${labruchere[-1]}))
                 elif [ "${#labruchere[@]}" -eq 1 ]; then
                  bet=${labruchere[0]}
                 else
#                    echo -e "${redColor}[!]${endColor} the end sequence"
                 labruchere=(1 2 3 4)
#                   echo -e "${greenColor}[*] Restart sequence..${endColor}"
#                echo -e "${greenColor}[!]${endColor} the sequense is ${blueColor} [${labruchere[@]}]${endColor}"
            fi   
          else
            unset labruchere[0]
            unset labruchere[-1] 2>/dev/null

            labruchere=(${labruchere[@]})
            bad_plays+="$random_number "

#            echo -e "${greenColor}[+]${endColor} the new sequence is ${bluecolor}[${labruchere[@]}]${endColor}"
            if [ "${#labruchere[@]}" -ne 1 ] && [ "${#labruchere[@]}" -ne 0 ]; then
              bet=$((${labruchere[0]} + ${labruchere[-1]}))
            elif [ "${#labruchere[@]}" -eq 1 ]; then
              bet=${labruchere[0]}
            else
#             echo -e "${redColor}[!]${endColor} the end sequence ${labruchere[@]}"
              labruchere=(1 2 3 4)
#              echo -e "${greenColor}[*] Restart sequence..${endColor}"
#              echo -e "${greenColor}[!]${endColor} the sequense is ${blueColor} [${labruchere[@]}]${endColor}"
              bet=$((${labruchere[0]} + ${labruchere[-1]}))
            fi
          fi 
        fi
        if [  $reward -ge $top ]; then
           top=$reward
        fi
      else 
        echo -e "${redColor}[!]${endColor} ${grayColor}select${purpleColor} even${endColor} ${grayColor} or ${purpleColor}odd${endColor}${endColor}\n\n"
        inverseLabruchere
      fi

    else
       echo -e "${redColor} !congratulation!!, now you are poor,wbn${endColor}"
       echo -e "${redColor} it has taken $play_counter moves to lose all your money${endColor},${greencolor}your reward top was $top ${endColor} and lose for you bad streak: $bad_plays "
       sleep 7
       echo "....."_:
       sleep 5
       echo "...."
       sleep 5
       echo -e " sigues aca?"
       sleep 5
      echo -e "${greenColor}Es correcto dejar tus decisiones en manos de la suerte?${endColor}"
       exit 0
    fi
  done
  
}

while getopts "m:t:h" arg; do
  case $arg in
    m) money="$OPTARG";;
    t) technique="$OPTARG";;
    h) helpPanel;;
  esac
done

if [ "$money" ] && [ "$technique" ]; then 
    if [ "$technique" == "martingala" ]; then
      martingala
    elif [ "$technique" == "inverseLabruchere" ]; then 
      inverseLabruchere    
    else
    echo -e "only use ${blueColor}martingala${endColor} and ${blueColor}jsjs${endColor}"
    
    fi  
else
 helpPanel
fi