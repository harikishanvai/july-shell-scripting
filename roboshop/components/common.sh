StatCheck() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[31mSUCCESS\e[0m"
  else
    echo -e "\e[32mFAILURE\e[0m"
    exit 2
  fi
}
Print() {
  echo -e "\n -----------------$1--------------" &>>$LOG_FILE
  echo -e "\e[35m $1 \e[0m"
}

USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo You Should run your script as sudo or root user
  exit 1
fi

LOG_FILE=/tmp/roboshop.log
rm -rf $LOG_LOG_FILE