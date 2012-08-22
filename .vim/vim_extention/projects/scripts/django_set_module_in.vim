
"let dir_name = expand("%:p:h:t")

"let dir_name = &cd 
"Decho('cd='.dir_name)
"python << EOF
"import sys,os
"def SetDjangoProjectVariable()
    ""python sys.path.append('D:/workspace/django/create_web_app_with_py')
    ""python os.environ['DJANGO_SETTINGS_MODULE'] = 'mysite.settings'


"python import sys,os
"python sys.path.append('D:/workspace/django/create_web_app_with_py/mysite')
"python os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'


"let $PROJECT_HOME='~/my_project'
	"" Put the compiler in $PATH
	"if $PATH !~ '/path/to/my/compiler'
		"let $PATH=$PATH.':/path/to/my/compiler'
	"endif

