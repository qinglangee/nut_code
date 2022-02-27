
REM javac -d classes -cp %zh_classpath% -encoding utf-8  --module-path %PATH_TO_FX% --add-modules javafx.controls,javafx.fxml  src/*.java  client/*.java

rem set zh_classpath=classes;lib/sqlite-jdbc-3.33.0.1.jar;lib/gson-2.3.jar

call vars.cmd
javac -d classes -cp %zh_classpath% -encoding utf-8 src/*.java

if %errorlevel%==0 (
    call run.bat %1 %2 %3 %4 %5 %6 %7
)