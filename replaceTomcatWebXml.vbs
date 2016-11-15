# $language = "VBScript"
# $interface = "1.0"

' create ShutdownTomcat.sh, cause shutdown.sh not used
Function createShutdownTomcat
    
	crt.Screen.Send " cd /usr/local/apache-tomcat-7.0.39/bin" & chr(13)	
	crt.Screen.Send " rm -rf ./shutdown-force.sh " & chr(13)
	crt.Screen.Send "vi /usr/local/apache-tomcat-7.0.39/bin/shutdown-force.sh" & chr(13)
	crt.Sleep 1000
	crt.Screen.Send "set fileformat=unix  " & chr(13)
	crt.Screen.Send "#!/bin/bash  " & chr(13)
	crt.Screen.Send "#by lym6520 2014-11-08  " & chr(13)
	crt.Screen.Send "#force shutdown tomcat,copy this sh file to tomcat/bin dir  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "path=$" & chr(123) & "PWD" & chr(125) & "  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "ps -ef" & chr(124) & "grep $path" & chr(124) & "grep java" & chr(124) & "awk '" & chr(123) & "print $2" & chr(125) & "'  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "echo " & chr(34) & "exec $path/shutdown.sh" & chr(34) & "  " & chr(13)
	crt.Screen.Send "$path/shutdown.sh  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "sleep 3s  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "#kill -9 pid  " & chr(13)
	crt.Screen.Send "ps -ef" & chr(124) & "grep $path" & chr(124) & "grep java" & chr(124) & "awk '" & chr(123) & "print $2" & chr(125) & "'" & chr(124) & "xargs kill -9  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "#success msg  " & chr(13)
	crt.Screen.Send "echo " & chr(34) & "shutdown success" & chr(34) & "  " & chr(13)
	crt.Screen.Send "  " & chr(13)
	crt.Screen.Send "ps -ef" & chr(124) & "grep $path" & chr(124) & "grep java" & chr(124) & "awk '" & chr(123) & "print $2" & chr(125) & "'  " & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OA" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "OD" & chr(27) & "ODs" & chr(27) & ":wq" & chr(13)
	crt.Sleep 1000
	crt.Screen.Send "chmod +x /usr/local/apache-tomcat-7.0.39/bin/shutdown-force.sh" & chr(13)

End Function

'main function
Function replaceWebXml
    crt.Screen.Send " cd /usr/local/apache-tomcat-7.0.39/bin" & chr(13)
    crt.Screen.Send "./shutdown-force.sh" & chr(13)
	crt.Sleep 1000
	crt.Screen.Send "vi /usr/local/apache-tomcat-7.0.39/webapps/soa-web/WEB-INF/web.xml" & chr(13)
	crt.Sleep 1000
	crt.Screen.Send ":168,168s#*</param-value>#*" & chr(124) & "/collect/resp</param-value>" & chr(13)
	crt.Sleep 1000
	crt.Screen.Send ":wq" & chr(13)
	crt.Sleep 1000
	crt.Screen.Send "/usr/local/apache-tomcat-7.0.39/bin/startup.sh" & chr(13)
	crt.Screen.Send chr(13)
	crt.Screen.Send "tail -f /usr/local/apache-tomcat-7.0.39/logs/catalina.out" & chr(13)
End Function

Sub Main
	'open ip file
	Const ForReading = 1, ForWriting = 2, ForAppending = 8
	Dim fso,file1,line,params
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set file1 = fso.OpenTextFile("d:\ip2.txt",Forreading, False)
	crt.Screen.Synchronous = True
	DO While file1.AtEndOfStream <> True
		'read each line
		line = file1.ReadLine
		'auto login
			StrIp = Trim(line) 
			If StrIp <> "" Then 
					REM cmd = "/ssh2 /L " & "root" &" /PASSWORD " & "3edc#EDC" & " /C 3DES " & StrIp 
					REM crt.Session.ConnectInTab cmd 
					crt.session.Connect("/ssh2 /L " & "root" &" /PASSWORD " & "password" & " /C 3DES " & StrIp) 
					createShutdownTomcat()
					crt.Sleep 1000
					replaceWebXml()
					crt.Sleep 1000
					crt.Session.Disconnect
			End If 		
	loop
	crt.Screen.Synchronous = False
End Sub
