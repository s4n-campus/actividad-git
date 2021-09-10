#!/bin/bash
RUTA=$(pwd)
RUTAREPO="git-test"
REPO="https://github.com/alejokalderon/${RUTAREPO}.git"
ARCHIVO_VALIDA_REPO_CLONADO="$RUTA/${RUTAREPO}/index.dat"

#Introducción
clear
echo "Hola, bienvenido a la práctica de git."
echo ""
echo "Cómo bien sabes, git es uno de los estándares más utilizados en la industria de software para el control de versiones"
echo "y queremos que puedas darle buen uso en cualquier momento y desde cualquier lugar."
echo ""
echo "En esta actividad te plantearemos un escenario ficticio, en donde haremos uso de sus utilidades básicas" 
echo "con el fin de que puedas desarrollar una estrategia de gitflow desde sus inicios."
echo ""
echo "Este script te irá haciendo preguntas que deberás resolver en este mismo directorio"
echo "al final te entregará un flag."
echo ""
echo "Recuerda que debes resolver todas las preguntas utilizando como directorio padre,"
echo "el mismo directorio donde está este script."
echo ""
echo "¿Estás listo?"
echo ""
echo "¡Comencemos!"
echo ""
#sleep 2
read -n 1 -r -s -p $'Presiona enter para continuar...\n'

#Introduce nombre
clear
echo "Introduce tu nombre y apellido (sin espacios o caracteres especiales)," 
echo "no lo olvides, este lo utilizaremos durante toda la actividad."
echo ""
#read -p "Introduce tu nombre aquí: " NOMBRE
NOMBRE="alejo"
while [[ "$NOMBRE" =~ [^a-zA-Z] || -z "$NOMBRE" ]]
do     
echo ""   
echo "El nombre debe contener valores y NO debe incluir caracteres especiales."     
echo "Por favor escriba solo caracteres alfabéticos."     
echo ""
read -p "Introduce tu nombre aquí: " NOMBRE
done
echo ""
echo "Perfecto, has introducido $NOMBRE"
#sleep 2
echo ""
#read -p "Es esto correcto? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo ""
read -n 1 -r -s -p $'Presiona enter para continuar...\n'

#1. Validando que git esté instalado
clear
INSTALADO="false"
while [ "$INSTALADO" != "true" ]
do 
  echo "Actividad 1"
  echo ""
  echo 'Lo primero que haremos será verificar que el comando "git" esté instalado en tu máquina.'
  echo "Si crees que ya está instalado puedes presionar enter para validarlo," 
  echo "en caso de que no, te invitamos a seguir las instrucciones de instalación en este enlace:" 
  echo ""
  echo "https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
  echo ""
  read -n 1 -r -s -p $'Presiona enter para validar si tienes el comando git instalado...\n'
  echo ""
  echo "Validando..."
  #sleep 1
  if ! git --version COMMAND &> /dev/null
  then
      echo "Aún no tienes git instalado, instalaló e intenta de nuevo."
      INSTALADO="false"
  else
      echo ""
      VERSION=$(git --version | cut -d' ' -f3)
      echo "Perfecto, tienes la versión $VERSION de git"
      INSTALADO="true"
      #sleep 3
      read -n 1 -r -s -p $'Presiona enter para continuar...\n'
  fi
done

#2. Validando el clonado de repositorio
clear
PUNTOS=0
while [ "$PUNTOS" != 1 ]
do
echo "Actividad 2"
echo ""
echo "Hemos creado este proyecto en GitHub:"
echo ""
echo "$REPO"
echo ""
echo "Este es un proyecto de prueba y desarrollaremos toda la práctica con el."
echo ""
echo "Para poder lograrlo deberás hacer un fork de dicho proyecto en tu propia cuenta de GitHub,"
echo "si no sabes como hacerlo te invitamos a que lo aprendas con los pasos descritos "
echo "en el siguiente enlace:"
echo ""
echo "https://docs.github.com/es/get-started/quickstart/fork-a-repo"
echo ""
echo "Una vez tengas el proyecto en tu cuenta deberas clonarlo en la misma ruta de este script"
echo "la cual es $RUTA"
echo ""
echo "Para lograr esto deberás utilizar comandos de git en una nueva terminal,"
echo "deberás quedar en la rama main."
echo ""
echo "   ________ "
echo "  | remote | "
echo "  |________| "
echo "            \ "
echo "             \________ "
echo "             | local  |"
echo "             |________|"
echo ""
read -n 1 -r -s -p $'Una vez lo hayas clonado presiona enter para validarlo...\n'
if [[ -f "$ARCHIVO_VALIDA_REPO_CLONADO" ]]; then
    echo ""
    echo "✔ Excelente, el repositorio fue clonado satisfactoriamente."
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Cuando utilizas "git glone" puedes añadir algunos flags importantes, por ejemplo:'
    echo ""
    echo "  ✸ git clone \${repositorio} --branch \${branch}: Permite descargar un branch específico"
    echo "  ✸ git clone -C \${ruta} \${repositorio}: Permite descargar un repositorio en una ruta específica"
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Parece que no has clonado el repositorio."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
fi
done

#3. Validando checkout
clear
cd ${RUTA}
PUNTOS=1
while [ "$PUNTOS" != 2 ]
do
echo "Actividad 3"
echo ""
echo "Haz checkout a la rama develop."
echo ""
echo "    v1   v2   v3 "
echo "    |    |    | "
echo "----o----o----o main "
echo "               \____ "
echo "                    \ "
echo "----o-o--o-o-o---o---o develop "
echo ""
read -n 1 -r -s -p $'Una vez lo hayas hecho presiona enter para validarlo...\n'
RAMAACTUAL=$(cd ${RUTA}/${RUTAREPO} && git rev-parse --abbrev-ref HEAD)
cd ${RUTA}
if [[ "$RAMAACTUAL" == "develop" ]]; then
    echo ""
    echo "✔ Excelente, tu rama actual es develop."
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Bien hecho, con el comando "git checkout" puedes moverte entre ramas,'
    echo 'si no conoces el nombre de una rama por ejemplo puedes actualizar las ramas remotas con el comando'
    echo '"git fetch --all" y luego listar con "git branch"'
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Parece que tu rama actual es ${RAMAACTUAL}, y debería ser develop."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#4. Validando creación de rama feature
clear
cd ${RUTA}
PUNTOS=2
while [ "$PUNTOS" != 3 ]
do
RAMAFEATURE="fb-$NOMBRE"
echo "Actividad 4"
echo ""
echo "A partir de la rama develop crea una rama de feature con tu nombre '${NOMBRE}' prefijada con el texto 'fb-' es decir $RAMAFEATURE"
echo ""
echo "    v1   v2   v3 "
echo "    |    |    | "
echo "----o----o----o main "
echo "               \____ "
echo "                    \ "
echo "----o-o--o-o-o---o---o develop "
echo "                      \ "
echo "                       \__$RAMAFEATURE"
echo ""
read -n 1 -r -s -p $'Una vez la hayas creado presiona enter para validarlo...\n'
RAMA_FEATURE_EXISTE=$(cd ${RUTA}/${RUTAREPO} && git branch | grep $RAMAFEATURE)
cd ${RUTA}
if [[ $RAMA_FEATURE_EXISTE ]]; then
    echo ""
    echo "✔ Excelente, has creado la rama ${RAMAFEATURE}"
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Recuerda que existen dos formas de crear una rama, una de ellas es utilizar el comando'
    echo '"git branch ${branch}" y la otra es "git checkout -b ${branch}".'
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Parece que no has creado la rama ${RAMAFEATURE}, creala e intenta de nuevo."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#5. Validando movimento a rama feature
clear
cd ${RUTA}
PUNTOS=3
while [ "$PUNTOS" != 4 ]
do
ARCHIVO1="mod1-${NOMBRE}.mod"
ARCHIVO2="mod2-${NOMBRE}.mod"
ARCHIVO3="modlocal-${NOMBRE}.mod"
ARCHIVO4="secreto-${NOMBRE}.txt"
echo "Actividad 5"
echo ""
echo "Muévete a la rama $RAMAFEATURE y estando ahí crea en la carpeta 'modules' 3 archivos de texto llamados:"
echo 
echo "1. ${ARCHIVO1}"
echo "2. ${ARCHIVO2}"
echo "3. ${ARCHIVO3}"
echo ""
echo "Además crea un archivo llamado '${ARCHIVO4}'."
echo ""
echo "└── ${RUTAREPO}"
echo "      └── modules"
echo "            ├── ${ARCHIVO1}"
echo "            ├── ${ARCHIVO2}"
echo "            ├── ${ARCHIVO3}"
echo "            └── ${ARCHIVO4}"
echo ""
read -n 1 -r -s -p $'Una vez la hayas creado presiona enter para validarlo...\n'
cd ${RUTA}/${RUTAREPO}/modules
if [[ -f "$ARCHIVO1" && -f "$ARCHIVO2" && -f "$ARCHIVO3" && -f "$ARCHIVO4" ]]; then
    echo ""
    echo '✔ Excelente, todos los archivos existen'
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Parece que no has creado alguno de los archivos, validalo e intenta de nuevo."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#6. Añade a stagging
clear
cd ${RUTA}
PUNTOS=4
while [ "$PUNTOS" != 8 ]
do
echo "Actividad 6"
echo ""
echo "Añade al stagging los archivos ${ARCHIVO1} y ${ARCHIVO2}, el archivo ${ARCHIVO3} NO debe ser enviado al stagging aún,"
echo "por ello debes dejarlo en tu máquina local, además el archivo ${ARCHIVO4} debe ser añadido a tu gitignore."
echo ""
echo "De la siguiente forma"
echo ""
echo "└── ${RUTAREPO}"
echo "      └── modules"
echo "            ├── ${ARCHIVO1} (staged)"
echo "            ├── ${ARCHIVO2} (staged)"
echo "            ├── ${ARCHIVO3} (not staged)"
echo "            └── ${ARCHIVO4} (gitignore)"
echo ""
read -n 1 -r -s -p $'Una vez la hayas creado presiona enter para validarlo...\n'
cd ${RUTA}/${RUTAREPO}
STAGED1=$(git diff --staged --name-only | sed -n '1p')
STAGED2=$(git diff --staged --name-only | sed -n '2p')
ARCHIVO4_IGNORED=""
ARCHIVO3_NO_STAGED=""
#ESTO SE COMENTÓ SOLO PARA LA PRUEBA
#if [[ "$STAGED1" == "modules/${ARCHIVO1}" && "$STAGED2" == "modules/${ARCHIVO2}" ]]; then
if [[ $ARCHIVO3_NO_STAGED == "" ]]; then
#La linea anterior se debe borrar
    echo ""
    echo "✔ Excelente, los archivos ${ARCHIVO1} y ${ARCHIVO2} fueron enviados a stagging."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
else
    echo "✘ Parece que los archivos ${ARCHIVO1} y ${ARCHIVO2} no han sido enviados a stagging."
fi
ARCHIVO3_NO_STAGED=$(cd ${RUTA}/${RUTAREPO} && git diff --staged --name-only | grep modules/${ARCHIVO3}.mod)
if [[ $ARCHIVO3_NO_STAGED == "" ]]; then
    echo ""
    echo "✔ Excelente, el archivo ${ARCHIVO3} no fue enviado a stagging."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
else
    echo ""
    echo "✘ Parece que el archivo ${ARCHIVO3} fue enviado a stagging."
fi
GIT_IGNORE=".gitignore"
ARCHIVO4_IGNORED=$(cat ${RUTA}/${RUTAREPO}/.gitignore | grep modules/${ARCHIVO4_IGNORED})
if [[ -f "${GIT_IGNORE}" && ${ARCHIVO4_IGNORED} == "modules/${ARCHIVO4}" ]]; then
    echo ""
    echo "✔ Excelente, el archivo ${GIT_IGNORE} existe y el archivo ${ARCHIVO4} fue añadido."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
else
    echo "✘ Parece que el archivo ${GIT_IGNORE} no existe o no está ignorando al archivo ${ARCHIVO4}."
fi
if [[ "$PUNTOS" != "7" ]]; then
    echo ""
    PUNTOS=4
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo..\n'
    clear
else
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Excelente, con el comando "git add" puedes añadir tus archivos a stagging, además existen flags importantes como:'
    echo "  ✸ -f: Forzar incluso archivos en el gitignore."
    echo "  ✸ -A: Añadir todos los archivos."
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
    #sleep 1
fi
done


#7. Pregunta git diff
clear
cd ${RUTA}
PUNTOS=7
while [ "$PUNTOS" != 8 ]
do
clear
echo "Actividad 7"
echo ""
echo "Uno de los siguientes comandos nos permiten para validar los archivos en stagging ¿Cual es el comando correcto?"
echo 
echo "1. git difference --stagging"
echo "2. git compare --branch"
echo "3. git diff --staged"
echo "4. git validate --staged"
echo ""
read -p "Introduce el número correspondiente a tu respuesta: " RESPUESTA7
if [[ "$RESPUESTA7" == "3" ]]; then
    echo ""
    echo '✔ Excelente, has elegido la respuesta correcta.'
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Con el comando git diff no solo puedes ver los archivos en stagging, también puedes ver,'
    echo 'por ejemplo archivos en cache con la opción "git diff --cached" o ver solo los nombres de los archivos'
    echo 'utilizando "git diff --staged--name-only"'
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Tu respuesta no es correcta, valida de nuevo, te recomendamos probarlos si tienes dudas."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#8. Pregunta git pull
clear
cd ${RUTA}
PUNTOS=8
while [ "$PUNTOS" != 9 ]
do
echo "Actividad 8"
echo ""
echo "Uno de los siguientes comandos nos permite descargar los últimos cambios de la rama develop a tu rama ${RAMAFEATURE} ¿Cuál es el comando correcto?"
echo 
echo "1. git pull origin develop"
echo "2. git retrieve develop"
echo "3. git take origin develop"
echo "4. git download develop"
echo ""
read -p "Introduce el número correspondiente a tu respuesta: " RESPUESTA8
if [[ "$RESPUESTA8" == "1" ]]; then
    echo ""
    echo '✔ Excelente, has elegido la respuesta correcta.'
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Bien hecho, el comando "git pull" permite hacer una integración de ramas o repositorios.'
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Tu respuesta no es correcta, valida de nuevo, te recomendamos probarlos si tienes dudas."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#9. Validando creacion de commit
clear
cd ${RUTA}
PUNTOS=9
while [ "$PUNTOS" != 10 ]
do
RAMAFEATURE="fb-$NOMBRE"
echo "Actividad 9"
echo ""
echo "Haz un commit de tu rama ($RAMAFEATURE) que contenga los archivos en stagging ${ARCHIVO1} y ${ARCHIVO2}"
echo "y que su commit message sea 'Adding new ${NOMBRE} modules' (sin comillas) de tus cambios."
echo ""
echo "        ________  "
echo "       | local  |└── modules "
echo "       |________|	   ├── ${ARCHIVO1} "
echo "                 	   └── ${ARCHIVO2} " 
echo ""
read -n 1 -r -s -p $'Una vez la hayas creado presiona enter para validarlo...\n'
cd ${RUTA}/${RUTAREPO}
COMMIT_MESSAGE=$(git log --format=%B -n 1)
cd ${RUTA}
#ESTO SE COMENTÓ SOLO PARA LA PRUEBA
#if [[ $COMMIT_MESSAGE == "Adding new ${NOMBRE} modules" ]]; then
if [[ $ARCHIVO3_NO_STAGED == "" ]]; then
#La linea anterior se debe borrar
    echo ""
    echo '✔ Excelente, tu commit message es correcto'
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Buen trabajo, el comando "git commit" permite "comprometer" o enviar a stagging tus cambios locales,'
    echo 'cuenta con algunas flags interesantes:'
    echo "  ✸ -a: Envía a stagging todo lo modificado, añadido o borrado."
    echo "  ✸ -m: permite añadir un texto descriptor al commit."
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Tu commit message es ${COMMIT_MESSAGE} y debería ser 'Adding new ${NOMBRE} modules', revisalo e intenta de nuevo."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#10. Pregunta git commit
clear
cd ${RUTA}
PUNTOS=10
while [ "$PUNTOS" != 11 ]
do
echo "Actividad 10"
echo ""
echo "Uno de los siguientes comandos nos permite validar el último commit ¿Cuál es el comando correcto?"
echo 
echo "1. git compare"
echo "2. git log"
echo "3. git validate"
echo "4. git last-commit"
echo ""
read -p "Introduce el número correspondiente a tu respuesta: " RESPUESTA10
if [[ "$RESPUESTA10" == "2" ]]; then
    echo ""
    echo '✔ Excelente, has elegido la respuesta correcta.'
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Bien hecho, el comando "git log" imprime información detallada de los commits en tu parent actual'
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Tu respuesta no es correcta, valida de nuevo, te recomendamos probarlos si tienes dudas."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#Pausa
clear
echo "Una pausa."
echo ""
echo "Hasta ahora has podido practicar varios de los comandos más importantes de git, ¿los recuerdas?, estos son:"
echo ""
    echo "  ✸ git clone: para clonar un repositorio"
    echo "  ✸ git branch: para crear una rama"
    echo "  ✸ git checkout: para moverse a una rama"
    echo "  ✸ git log: para imprimir registros de tu parent actual"
    echo "  ✸ git pull: para descargar los cambios de una rama"
    echo "  ✸ git diff: para ver archivos en stagging o en caché"
    echo "  ✸ git fetch: para actualizar las ramas locales con las remotas"
echo ""
echo "Con estos ya puedes tener un control general de un repositorio en tu máquina local."
echo "¡Ahora continuemos con la práctica!"
echo ""
#sleep 2
read -n 1 -r -s -p $'Presiona enter para continuar...\n'

#11. Validando git push
clear
cd ${RUTA}
PUNTOS=11
while [ "$PUNTOS" != 12 ]
do
RAMAFEATURE="fb-$NOMBRE"
echo "Actividad 11"
echo ""
echo "Has push del commit 'Adding new ${NOMBRE} modules' en la rama ${RAMAFEATURE} al repositorio remoto."
echo ""
echo "                     ________ "
echo "                    | remote |└── modules "
echo "                    |________|     ├── ${ARCHIVO1} "
echo "                    /              └── ${ARCHIVO2} "
echo "          ________ / "
echo "         | local  |└── modules "
echo "         |________|     ├── ${ARCHIVO1} "
echo "                        ├── ${ARCHIVO2} "
echo "                        └── ${ARCHIVO3} "
echo ""
read -n 1 -r -s -p $'Una vez la hayas creado presiona enter para validarlo...\n'
cd ${RUTA}/${RUTAREPO}
LAST_PUSH=$(git log origin/${RAMAFEATURE} --pretty=format:%s -1 2>/dev/null)
cd ${RUTA}
if [[ $LAST_PUSH == "Adding new ${NOMBRE} modules" ]]; then
    echo ""
    echo '✔ Excelente, tu push ha sido desarrollado correctamente'
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Buen trabajo, el comando "git push" permite enviar tus cambios a la rama remota,'
    echo 'además cuenta con algunas flags interesantes:'
    echo "  ✸ -a: Hace push de todas las ramas."
    echo "  ✸ -u: Añade datos adicionales de referencia."
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
else
    echo ""
    echo "✘ Tu push no ha sido enviado a la rama remota, revisa e intenta de nuevo."
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo...\n'
    clear
fi
done

#12. Validando integración con develop
clear
cd ${RUTA}
while [ "$PUNTOS" != 16 ]
do
PUNTOS=12
RAMAFEATURE="fb-$NOMBRE"
echo "Actividad 12"
echo ""
echo "En este punto tus cambios deben estar en tu rama remota, lo ideal sería que crees un Pull"
echo "Request para solicitar la integración de dichos cambios a la rama develop, hay varias formas de"
echo "hacerlo:"
echo ""
echo "  ✸ Con git utilizando el comando 'git request-pull', sin embargo no es soportado por todas las versiones de git."
echo "  ✸ Con la cli oficial de github utilizando el comando 'gh pr create', sin embargo no todas las personas utilizan GitHub,"
echo "    algunos prefieren gitlab o Bitbucket por ejemplo."
echo "  ✸ A través de los clientes web."
echo ""
echo "Para este caso no crearemos un Pull Request (PERO OJO, CREAR EL PR SIEMPRE ES LO IDEAL), sino que traeremos los cambios de tu rama a develop directamente."
echo ""
echo "Muévete a la rama develop e integra los cambios de la rama de feature que creaste,"
echo "además has un push de estos cambios con el commit message 'Integracion $RAMAFEATURE' (sin tílde)"
echo ""
echo "   v1   v2   v3 "
echo "   	|    |    | "
echo "----o----o----o main "
echo "               \____ "
echo "                    \ "
echo "----o-o--o-o-o---o---o -o---o develop"
echo "                      \    / "
echo "                       \__/$RAMAFEATURE "
echo ""
read -n 1 -r -s -p $'Una vez lo hayas hecho presiona enter para validarlo...\n'
RAMAACTUAL=$(cd ${RUTA}/${RUTAREPO} && git rev-parse --abbrev-ref HEAD)
RAMA_FEATURE_EN_DEVELOP=$(cd ${RUTA}/${RUTAREPO} && git branch --merged | grep $RAMAFEATURE)
COMMIT_MESSAGE_DEVELOP=$(cd ${RUTA}/${RUTAREPO} && git log origin/develop --pretty=format:%s -1)
cd ${RUTA}
if [[ "$RAMAACTUAL" == "develop" ]]; then
    echo ""
    echo "✔ Excelente, estás en la rama develop."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    if [[ $RAMA_FEATURE_EN_DEVELOP ]]; then
    echo ""
    echo "✔ Excelente, has traído todos los cambios de $RAMAFEATURE."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que no has traído todos los cambios de $RAMAFEATURE."
    fi
    if [[ "$COMMIT_MESSAGE_DEVELOP" == "Integracion $RAMAFEATURE" ]]; then
    echo ""
    echo "✔ Excelente, tu commit message es correcto y tus cambios fueron enviados al repositorio."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que tu commit message no es correcto o tus cambios no fueron enviados al repositorio."
    fi
else
    echo ""
    echo "✘ Parece que no estás en la rama correcta."
    echo ""
fi
if [[ "$PUNTOS" != "15" ]]; then
    echo ""
    PUNTOS=12
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo..\n'
    clear
else
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Excelente, has podido hacer una integración completa en la que tuviste que usar múltiples comandos de git:'
    echo ""
    echo "  ✸ git checkout: para moverte de rama."
    echo "  ✸ git pull: para traer los cambios de la rama $RAMAFEATURE."
    echo "  ✸ git add: para añadir los cambios antes del commit."
    echo "  ✸ git commit: para comprometer los cambios integrados"
    echo "  ✸ git push: para enviar dichos cambios a la rama develop"
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
    #sleep 1
fi
done

#13. Validando integración con main
clear
cd ${RUTA}
while [ "$PUNTOS" != 21 ]
do
PUNTOS=16
RAMAFEATURE="fb-$NOMBRE"
echo "Actividad 13"
echo ""
echo "Luego de un arduo proceso de análisis el equipo de QA ha certificado todos los cambios de"
echo "develop, ahora se debe integrar esta rama con main para ser llevada a producción, esto se hace a"
echo "través de un Pull Request también, para esta actividad vamos a traer los cambios de develop a main "
echo "directamente. (RECUERDA, ESTO ES SOLO UNA PRÁCTICA, CREAR EL PR SIEMPRE ES LO IDEAL)."
echo ""
echo "Muévete a la rama main e integra los cambios de la rama develop con el commit message $RAMAFEATURE."
echo "Además taggea dicho commit con el tag v4"
echo ""
echo "   v1   v2   v3               v4 "
echo "    |    |    |                | "
echo "----o----o----o ---------------o main "
echo "               \____          / "
echo "                    \        / "
echo "----o-o--o-o-o---o---o -o---o develop "
echo "                      \    / "
echo "                       \__/$RAMAFEATURE "
echo ""
read -n 1 -r -s -p $'Una vez lo hayas hecho presiona enter para validarlo...\n'
RAMAACTUAL=$(cd ${RUTA}/${RUTAREPO} && git rev-parse --abbrev-ref HEAD)
RAMA_DEVELOP_EN_MAIN=$(cd ${RUTA}/${RUTAREPO} && git branch --merged | grep develop)
COMMIT_MESSAGE_MAIN=$(cd ${RUTA}/${RUTAREPO} && git log origin/main --pretty=format:%s -1)
TAG=$(cd ${RUTA}/${RUTAREPO} && git ls-remote --tags --refs -q | cut -d '/' -f3 | grep v4)
cd ${RUTA}
if [[ "$RAMAACTUAL" == "main" ]]; then
    echo ""
    echo "✔ Excelente, estás en la rama main."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    if [[ $RAMA_FEATURE_EN_DEVELOP ]]; then
    echo ""
    echo "✔ Excelente, has traído todos los cambios de develop."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que no has traído todos los cambios de develop."
    fi
    if [[ "$COMMIT_MESSAGE_MAIN" == "$RAMAFEATURE" ]]; then
    echo ""
    echo "✔ Excelente, tu commit message es correcto y tus cambios fueron enviados al repositorio."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que tu commit message no es correcto o tus cambios no fueron enviados al repositorio."
    fi
    if [[ $TAG ]]; then
    echo ""
    echo "✔ Excelente, tu tag es correcto."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que tu tag no es correcto."
    fi
else
    echo ""
    echo "✘ Parece que no estás en la rama correcta."
    echo ""
fi
if [[ "$PUNTOS" != "20" ]]; then
    echo ""
    PUNTOS=16
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo..\n'
    clear
else
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Excelente, has logrado completar un gitflow convencional.'
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
    #sleep 1
fi
done

#14. Validando bug
clear
cd ${RUTA}
PUNTOS=21
while [ "$PUNTOS" != 24 ]
do
RAMAHOTFIX="bug-$NOMBRE"
echo "Actividad 14"
echo ""
echo "Ups, parece que un cliente reporta un bug..."
echo "El equipo de desarrollo lo analizó e identificó como resolverlo, el cambio consiste"
echo "en subir un archivo llamado modfinal.mod."
echo ""
echo "Crea una rama de hotfix llamada ${RAMAHOTFIX} a partir de main."
echo "En esta rama crea un archivo llamado 'modfinal.mod' el cual aparentemente resuelve el bug."
echo "Haz un commit llamado $RAMAHOTFIX y sube el cambio a la rama."
echo ""
echo "                                  __ ${RAMAHOTFIX} "
echo "   v1   v2   v3               v4 / "
echo "    |    |    |                |/ "
echo "----o----o----o ---------------o main "
echo "               \____          / "
echo "                    \        / "
echo "----o-o--o-o-o---o---o -o---o develop "
echo "              \    / "
echo "               \__/${RAMAFEATURE} "
echo ""
echo ""
echo "└── ${RUTAREPO}"
echo "      └── modules"
echo "            └── modfinal.mod"
echo ""
read -n 1 -r -s -p $'Una vez la hayas creado presiona enter para validarlo...\n'
COMMIT_MESSAGE_HOTFIX=$(cd ${RUTA}/${RUTAREPO} && git log origin/${RAMAHOTFIX} --pretty=format:%s -1)
RAMAACTUAL=$(cd ${RUTA}/${RUTAREPO} && git rev-parse --abbrev-ref HEAD)
cd ${RUTA}/${RUTAREPO}/modules
if [[ "$RAMAACTUAL" == "${RAMAHOTFIX}" ]]; then
    if [[ -f "modfinal.mod" ]]; then
        echo ""
        echo '✔ Excelente, el archivo modfinal.mod existe'
        PUNTOS=$(( PUNTOS +1 ))
        echo ""
    else
        echo ""
        echo "✘ Parece que no has creado el archivo, validalo e intenta de nuevo."
    fi
    if [[ "$COMMIT_MESSAGE_HOTFIX" == "$RAMAHOTFIX" ]]; then
        echo ""
        echo "✔ Excelente, tu commit message es correcto y tus cambios fueron enviados al repositorio."
        PUNTOS=$(( PUNTOS +1 ))
        #sleep 1
    else
        echo ""
        echo "✘ Parece que tu commit message no es correcto o tus cambios no fueron enviados al repositorio."
    fi
else
    echo ""
    echo "✘ Parece que no estás en la rama correcta."
    echo ""
fi
if [[ "$PUNTOS" != "23" ]]; then
    echo ""
    PUNTOS=21
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo..\n'
    clear
else
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Excelente, has logrado completar la creación de un hotfix.'
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para continuar con la siguiente actividad...\n'
    #sleep 1
fi
done

#15. Validando integración de bug con main
clear
cd ${RUTA}
while [ "$PUNTOS" != 29 ]
do
PUNTOS=24
RAMAFEATURE="fb-$NOMBRE"
echo "Actividad 15"
echo ""
echo "El equipo de QA ha validado que tu rama de hotfix es funcional y ahora debe crearse un PR de"
echo "dicho cambio directamente a la rama de main, (RECUERDA, PARA LA PRÁCTICA HAREMOS EL MERGE"
echo "DIRECTAMTENTE DEL HOTFIX DESDE main)."
echo ""
echo "Muévete a la rama main e integra los cambios de la rama ${RAMAHOTFIX} con el commit message $RAMAHOTFIX."
echo "Además taggea dicho commit con el tag v4.1"
echo ""
echo ""
echo "                                  __ ${RAMAHOTFIX} "
echo "   v1   v2   v3               v4 /  \ v4.1 "
echo "    |    |    |                |/    \| "
echo "----o----o----o ---------------o main "
echo "               \____          / "
echo "                    \        / "
echo "----o-o--o-o-o---o---o -o---o develop "
echo "              \    / "
echo "               \__/${RAMAFEATURE} "
echo ""
echo ""
read -n 1 -r -s -p $'Una vez lo hayas hecho presiona enter para validarlo...\n'
RAMAACTUAL=$(cd ${RUTA}/${RUTAREPO} && git rev-parse --abbrev-ref HEAD)
RAMA_HOTFIX_EN_MAIN=$(cd ${RUTA}/${RUTAREPO} && git branch --merged | grep ${RAMAHOTFIX})
COMMIT_MESSAGE_MAIN=$(cd ${RUTA}/${RUTAREPO} && git log origin/main --pretty=format:%s -1)
HOTFIXTAG=$(cd ${RUTA}/${RUTAREPO} && git ls-remote --tags --refs -q | cut -d '/' -f3 | grep v4.1)
cd ${RUTA}
if [[ "$RAMAACTUAL" == "main" ]]; then
    echo ""
    echo "✔ Excelente, estás en la rama main."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    if [[ $RAMA_HOTFIX_EN_MAIN ]]; then
    echo ""
    echo "✔ Excelente, has traído todos los cambios de la rama ${RAMAHOTFIX}."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que no has traído todos los cambios de ${RAMAHOTFIX}."
    fi
    if [[ "$COMMIT_MESSAGE_MAIN" == "$RAMAHOTFIX" ]]; then
    echo ""
    echo "✔ Excelente, tu commit message es correcto y tus cambios fueron enviados al repositorio."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que tu commit message no es correcto o tus cambios no fueron enviados al repositorio."
    fi
    if [[ $TAG ]]; then
    echo ""
    echo "✔ Excelente, tu tag es correcto."
    PUNTOS=$(( PUNTOS +1 ))
    #sleep 1
    else
    echo ""
    echo "✘ Parece que tu tag no es correcto."
    fi
else
    echo ""
    echo "✘ Parece que no estás en la rama correcta."
    echo ""
fi
if [[ "$PUNTOS" != "28" ]]; then
    echo ""
    PUNTOS=24
    read -n 1 -r -s -p $'Presiona enter para validar de nuevo..\n'
    clear
else
    echo ""
    echo "Feedback:"
    echo ""
    echo 'Excelente, has logrado completar un gitflow convencional.'
    echo ""
    PUNTOS=$(( PUNTOS +1 ))
    echo ""
    read -n 1 -r -s -p $'Presiona enter para finalizar la actividad y obtener tu flag...\n'
    #sleep 1
fi
done

echo ""
echo "Excelente, has logrado desarrollar todas las actividades con éxito, tu flag es."
echo ""
echo "Octopuss"
