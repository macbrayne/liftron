void startTotalTimeTimer() {
  universalSave("totalTimeTimerStartTime", millis() + "");
}

void saveTotalTimeTimerTime() {
  int passedTime = int(millis()) - loadPassedTimeThisRun(); 
  int totalTime = loadTotalTimeTimerTime() + passedTime;
  universalSave("totalTimeTimerTime", totalTime + "");
}

void savePassedTimeThisRun() {
  universalSave("passedTimeThisRun", millis() + "");
}

int loadPassedTimeThisRun() {
  return int(universalLoad("passedTimeThisRun"));
}

int loadTotalTimeTimerTime() {
  return int(universalLoad("totalTimeTimerTime"));
}

String changeTimeInHours(int millis) {
  String result = "";
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  for (int mill = millis; mill>3600000; mill -= 3600000) {
    hours++ ;
  }
  int remaining = millis - (hours * 3600000);
  for (int rest = remaining; rest>60000; rest -= 60000) {
    minutes++ ;
  }
  int stillRemaining = millis - (hours * 3600000) - (minutes * 60000);
  for (int rest = stillRemaining; rest>1000; rest -= 1000) {
    seconds++ ;
  }

  result += hours + "";
  if (hours<10)result += 0;
  result += "h : ";
  if (minutes<10 && minutes>0)result += 0;
  result += minutes + "";
  if (minutes == 0)result += 0;
  result += "m : ";
  if (seconds<10 && seconds>0)result += 0;
  result += seconds;
  if (seconds == 0)result += 0;
  result += "s";

  return result;
}

//Permission handles
void handleREAD_EXTERNAL_STORAGE(boolean granted) {
  permissionRequestionClosed = true;
  if (granted)universalSave("grantedRead", "true");
  else exit();
}

void handleWRITE_EXTERNAL_STORAGE(boolean granted) {
  if (granted)  universalSave("grantedWrite", "true");
  else exit();
}
