#!/bin/bash 

greenColor="\e[0;32m\033[1m"
endColor="\033[0m\e[0m"
redColor="\e[0;31m\033[1m"
blueColor="\e[0;34m\033[1m"
yellowColor="\e[0;33m\033[1m"
purpleColor="\e[0;35m\033[1m"
turquoiseColor="\e[0;36m\033[1m"
grayColor="\e[0;37m\033[1m"

 
function ctrl_c(){
  echo -e "\n\n ${redColor}[!] exiting...\n${endColor}"
  tput cnorm && exit 1
}
#ctrl c 
trap ctrl_c INT
#global variables 

main_url="https://htbmachines.github.io/bundle.js"

function helpPanel(){
  echo -e "\n ${greenColor}[!]Welcome to help panel${endColor}\n"
  echo -e "${turquoiseColor}u)${endColor}${blueColor}Download or update need files${endColor}"
  echo -e "${turquoiseColor}u)${endColor}${greenColor}Search for IP${endColor}"
  echo -e "${turquoiseColor}y)${endColor}${blueColor}Print link of the video writeUp${endColor}"
  echo -e "${turquoiseColor}m)${endColor}${greenColor}Search for machine name${endColor}"
  echo -e "${turquoiseColor}h)${endColor}${blueColor}Show help panel${endColor}"
  echo -e "${turquoiseColor}d)${endColor}${greenColor}Search for difficulty${endColor}"
  echo -e "${turquoiseColor}s)${endColor}${blueColor}Search for Operating System${endColor}"
  echo -e "${turquoiseColor}k)${endColor}${greenColor}Search for skill${endColor}"
}



function updateFiles(){
  if [ ! -f boundle.js ]; then
     tput civis
     echo -e "${yellowColor}[!]${endColor} update files..."
     curl -s $main_url > boundle.js
     js-beautify boundle.js | sponge boundle.js
     tput cnorm
  else
     curl -s $main_url > boundle_temp.js
     js-beautify boundle_temp.js | sponge boundle_temp.js
     md5_temp_value=$(md5sum boundle_temp.js | awk '{print $1}')
     md5_original_value=$(md5sum boundle.js | awk '{print $1}')
function youtubeVideo(){
  machineName="$1"

  echo -e "\n${yellowColor}[!] searching video youtube${endColor}...\n"

   youtubeLink="$(cat boundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//' | grep youtube | awk 'NF{print $NF}')"

  if [ $youtubeLink ]; then
    echo -e "[!] enter for see video $machineName machine resolve: \n\t$youtubeLink"
  else
    echo -e "${redColor}video for $machineName not avaliable or machine not exist${endColor}"
  fi
}

     if [ "$md5_temp_value" == "$md5_original_value" ]; then 
       echo -e "${yellowColor}not update avaliable"
       rm boundle_temp.js
     else
       echo -e "${redColor}AVALIABLE UPDATE"
       rm boundle.js && mv boundle_temp.js boundle.js
     fi  
  fi 
}
#indicadores
function searchIp(){
  ipAddres="$1"

  machineName="$(cat boundle.js | grep "ip: \"$ipAddres\"" -B 3 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',')"
  if [ "$machineName" ]; then  
    echo -e "\n ${greenColor}[+]${endColor}the ipAddres ${purpleColor}$ipAddres${endColor} belongs machine:${purpleColor}$machineName${endColor}"
  else
    echo -e "${redColor}[!]${endcolor}${endcolor} ${purpleColor}$ipAddres${endColor} it's not a machine"
  fi 
}

function searchMachine(){
  machineName="$1"

  machine_checker="$( cat boundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//'
)"

  if [ "$machine_checker" ]; then

    echo -e "${yellowColor}[!] read machine properties:${endColor} \n"

    cat boundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//' > colored.txt

    line1="$(cat colored.txt | awk 'NR==1')"
    line2="$(cat colored.txt | awk 'NR==2')"
    line3="$(cat colored.txt | awk 'NR==3')"
    line4="$(cat colored.txt | awk 'NR==4')"
    line5="$(cat colored.txt | awk 'NR==5')"
    line6="$(cat colored.txt | awk 'NR==6')"
    line7="$(cat colored.txt | awk 'NR==7')"
    line8="$(cat colored.txt | awk 'NR==8')"
    line9="$(cat colored.txt | awk 'NR==9')"

    echo -e "${purpleColor}$line1${endColor}\n${greenColor}$line2${endColor}\n${greenColor}$line3${endColor}\n${greenColor}$line4${endColor}\n${redColor}$line5${endColor}\n${greenColor}$line6${endColor}\n${redColor}$line7${endColor}\n${greenColor}$line8${endColor}\n${redColor}$line9${endColor}"

  else
    echo -e "\n ${redColot}The Machine ${purpleColor}$machineName${endColor} no exist ${endColor}"
  fi 
}

function youtubeVideo(){ 
  machineName="$1"

  echo -e "\n${yellowColor}[!] searching video youtube${endColor}...\n"

   youtubeLink="$(cat boundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta" | tr -d '"' | tr -d ',' | sed 's/^ *//' | grep youtube | awk 'NF{print $NF}')"

  if [ "$youtubeLink" ]; then
    echo -e "${greenColor}[+]${endColor} enter for see video resolve machine${purpleColor}$machineName${endColor}: \n\t${greenColor}$youtubeLink${endColor}"
  else
    echo -e "${redColor}video for $machineName not avaliable or machine not exist${endColor}"
  fi
}

function searchDifficulty(){
  difficulty="$1"

 result_checker="$(cat boundle.js | grep "dificultad: \"$difficulty\"" -B 5 |  grep name | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column
)"
  if [ "$result_checker" ]; then
    echo -e echo -e "${greenColor}[+] listing machines in difficulty $difficulty: ${endColor} \n"
     cat boundle.js | grep "dificultad: \"$difficulty\"" -B 5 |  grep name | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column > colored.txt
     diff="$(cat colored.txt)"
     if [ "$difficulty" = "Fácil" ]; then 
       echo -e "${greenColor}$diff${endColor}"
     elif [ "$difficulty" = "Difícil" ]; then 
       echo -e "${purpleColor}$diff${endColor}"
     else
        echo -e "${redColor}$diff${endColor}"
     fi
  else
  echo -e "${redColor}[!]${endColor} are you stupid? your difficulty ""${redColor}$difficulty${endColor}"" no exist....use the capital letter"
  fi 
}

function searchOS(){
  OS="$1"

  OS_results="$(cat boundle.js | grep "so: \"$OS\"" -B 5 |  grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"
  if [ "$OS_results" ]; then 
    echo  -e "[+] listing ${blueColor} $OS ${endColor} machines\n"
    cat boundle.js | grep "so: \"$OS\"" -B 5 |  grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column > colored.txt
    op="$(cat colored.txt)"
    if [ "$OS" = "Linux" ]; then
      echo -e "${blueColor}$op${endColor}"
    else
      echo -e "${turquoiseColor}$op${endColor}"
    fi 
  else
    echo -e "${redColor}[!]${endColor} Operating System invalid2 "
  fi 
}

function searchOsDifficulty(){
  difficulty="$1"
  OS="$2"
  o_d_check="$(cat boundle.js | grep "so: \"$OS\"" -C 4 | grep "dificultad: \"$difficulty\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"
  if [ "$o_d_check" ]; then
    echo -e "${yellowColor}[+]searching machines $OS in level $difficulty...${endColor}"
    cat boundle.js | grep "so: \"$OS\"" -C 4 | grep "dificultad: \"$difficulty\"" -B 5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column > colored.txt

    od="$(cat colored.txt)"
    if [ "$od" = "Linux" ] || [ "$od" = "Fácil"  ]; then
      echo -e "${bluecolor}$od${endColor}"
    else
      echo -e "${blueColor}$od${endColor}"
    fi 
  else
    echo -e "${redColor}[!]${endColor} Difficulty or Operating System is not correct"
  fi
}

function searchSkill(){
  skill="$1"
  skill_checker="$(cat boundle.js | grep "skills: " -B 6 | grep "$skill" -B 6 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"
  if [ "$skill_checker" ]; then
    echo -e "[+] searching for skill: ${greenColor}$skill${endColor}"
    cat boundle.js | grep "skills: " -B 6 | grep "$skill" -i -B 6 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column > colored.txt
    sl="$(cat colored.txt)"
    echo -e "${purpleColor}$sl${endColor}"
  else
    echo -e ̣"${redColor}[!]${endColor} skill $skill not avaliable"
  fi
}
#chivatos

declare -i ch_difficulty=0
declare -i ch_os=0

declare -i parameter_counter=0

while getopts "m:ui:y:d:s:k:h" arg; do
  case $arg in 
    m) machineName="$OPTARG"; let parameter_counter+=1;;
    u) let parameter_counter+=2;;
    i) ipAddres="$OPTARG"; let parameter_counter+=3;;
    y) machineName="$OPTARG"; let parameter_counter+=4;;
    d) difficulty="$OPTARG"; ch_difficulty=1; let parameter_counter+=5;;
    s) OS="$OPTARG"; ch_os=1; let parameter_counter+=6;;
    k) skill="$OPTARG"; let parameter_counter+=7;;
    h) ;;
  esac 
done

if [ $parameter_counter -eq 1 ]; then
  searchMachine "$machineName"
elif [ $parameter_counter -eq 2 ]; then
  updateFiles
elif [ $parameter_counter -eq 3 ]; then 
  searchIp "$ipAddres"
elif [ $parameter_counter -eq 4 ]; then 
  youtubeVideo "$machineName"
elif [ $parameter_counter -eq 5 ];then
  searchDifficulty "$difficulty"
elif [ $parameter_counter -eq 6 ]; then
  searchOS "$OS"
elif [ $parameter_counter -eq 7 ]; then 
  searchSkill "$skill"
elif [ $ch_difficulty -eq 1 ] && [ $ch_os -eq 1 ]; then
  searchOsDifficulty "$difficulty" "$OS"
else
  helpPanel  
fi