/***
 * js_CheckOS1.js
 * This Function Checks if OS is satisfied conditions
 * for Security Update Install (returns true)
***/

function checkOSSatisfied01()
{
  if(jscd.os == "Windows") {
    if(jscd.osVersion == "7" || jscd.osVersion == "8.1" || jscd.osVersion == "10")
      return true;
    else
      return false;
  }
  else
    return false;
} 

function writeCheckedText() {
  if(checkOSSatisfied01()) {
    document.getElementById("aChoice").innerHTML = "Операционная система удовлетворяет требованиям к обновлению безопасности. Можете скачивать файлы.";
	document.getElementById("aButton").innerHTML = "<button onclick=\"onClick02()\">Загрузить</button><p>Для загрузки скрипта установки обновления безопасности нажмите кнопку выше. Файл будет загружен в системную папку &quot;Downloads&quot;. У Вас будет запрошено разрешение на сохранение небезопасного файла.</p>";
  }
  else {
    document.getElementById("aChoice").innerHTML = "Операционная система не удовлетворяет требованиям к админ-паку.";
  }
}