*written by Hou Xinshuo 2018-8-8
*version 1.0
*Email: houxinshuo@126.com


capture program drop efolder
program define efolder
  syntax [anything] ,  [Cd(string)] [Sub] [SUBname(string)]
  global gcd="`c(pwd)'" 
  qui cd "$gcd"
if "`cd'"!="" {
   global gcd=`"`cd'"'
   capture cd "$gcd"
   if _rc{
   mkdir "$gcd"
   capture cd "$gcd"
   dis in w "A folder been created!" `"{browse "$gcd": [new path and folder] }"' 
   }
}  
if "`cd'"=="" {
   dis in w "Default folder in STATA" `"{browse "`c(pwd)'": [`c(pwd)'] }"' 
}

if "`sub'" == "" & "`subname'" ==""{
    if "`anything'" != "" {
	 capture mkdir "`anything'"
	 dis in w `"A folder named `anything' created."'  `"{browse `"`c(pwd)'/`anything'"' :      [`anything'] }"'
	 dis in w `"No subfolders been created."' 
	}
	else if "`anything'" == "" {
	 dis in w `"No folders been created."' 
	}
}

if "`sub'" != "" & "`subname'" ==""{
    if "`anything'" != "" {
	 capture mkdir "`anything'"
     capture mkdir "`anything'/do"
     capture mkdir "`anything'/dta"
     capture mkdir "`anything'/ref"
	dis in w `"A folder named `anything' created."'     `"{browse `"`c(pwd)'/`anything'"' :      [`anything'] }"'
	capture cd "`"$gcd"\'`anything'" 
	}
	else if "`anything'" == "" {
	 capture mkdir f1
     capture mkdir f2
     capture mkdir f3
	}
}

if  "`subname'" != "" & "`anything'" != "" {
 	    capture mkdir "`anything'"
		global sflist="`subname'" 
        foreach f in $sflist {
	         capture mkdir "`anything'/`f'"
			 dis in w `"A subfolder named `f' created."'
			 }
	   dis in w `"A folder named `anything' created."'  `"{browse `"`c(pwd)'/`anything'"' :      [`anything'] }"'
	   capture cd "`$gcd\'`anything'" 
	}
	
if  "`subname'" != "" & "`anything'" == "" {
	    global sflist="`subname'" 
        foreach k in $sflist {
	         capture mkdir `k'
			 dis in w `"A subfolder named `k' created."'
			 }
	} 
end
